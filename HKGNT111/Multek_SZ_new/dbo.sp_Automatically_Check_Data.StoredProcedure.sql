USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[sp_Automatically_Check_Data]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Automatically_Check_Data]
	-- Add the parameters for the stored procedure here
	@Option VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @LinkedServer VARCHAR(100),@Table_Qualifier VARCHAR(100),@Table_Owner VARCHAR(100),@Table_Name VARCHAR(100),@SQLString VARCHAR(MAX),@EmailBody VARCHAR(MAX),@NotUpdateTable INT,@YesterdayCount BIGINT,@NowCount BIGINT
	DECLARE @OriginalTable TABLE (Table_Qualifier VARCHAR(100),Table_Owner VARCHAR(100),Table_Name VARCHAR(100),Table_Type VARCHAR(100),Remarks VARCHAR(100))
	DECLARE @Table TABLE (Table_Qualifier VARCHAR(100),Table_Owner VARCHAR(100),Table_Name VARCHAR(100),Table_Type VARCHAR(100),Remarks VARCHAR(100),LinkedServer VARCHAR(100))
	SET @LinkedServer=''
	INSERT INTO @OriginalTable
	EXECUTE SP_TABLES
	INSERT INTO @Table(LinkedServer,Table_Qualifier,Table_Owner,Table_Name,Table_Type,Remarks)
	SELECT @LinkedServer,Table_Qualifier,Table_Owner,Table_Name,Table_Type,Remarks FROM @OriginalTable WHERE Table_Name LIKE 'tfsolp%' AND Table_Type='Table'
	SET @LinkedServer='HKGNT117'
	DELETE @OriginalTable
	INSERT INTO @OriginalTable
	EXECUTE HKGNT117.Multek_ZH..SP_TABLES
	INSERT INTO @Table(LinkedServer,Table_Qualifier,Table_Owner,Table_Name,Table_Type,Remarks)
	SELECT @LinkedServer,Table_Qualifier,Table_Owner,Table_Name,Table_Type,Remarks FROM @OriginalTable WHERE Table_Name LIKE 'tfsolp%' AND Table_Type='Table'
	INSERT INTO Check_Data (Table_Qualifier,Table_Owner ,Table_Name ,Table_Type,Remarks,LinkedServer,YesterdayCount,NowCount)
	SELECT Table_Qualifier,Table_Owner ,Table_Name ,Table_Type,Remarks,LinkedServer,0,0 FROM @Table WHERE LinkedServer+Table_Qualifier+Table_Owner+Table_Name NOT IN (SELECT LinkedServer+Table_Qualifier+Table_Owner+Table_Name FROM Check_Data)

	DELETE Check_Data
	WHERE LinkedServer+Table_Qualifier+Table_Owner+Table_Name NOT IN (SELECT LinkedServer+Table_Qualifier+Table_Owner+Table_Name FROM @Table)

	CREATE TABLE #DataCount (RecordCount INT)

	DECLARE CheckTable_C CURSOR FOR
	SELECT LinkedServer,Table_Qualifier,Table_Owner,Table_Name FROM Check_Data 
	OPEN CheckTable_C
	FETCH NEXT FROM CheckTable_C INTO @LinkedServer,@Table_Qualifier,@Table_Owner,@Table_Name
	WHILE @@FETCH_STATUS=0
		BEGIN
			SET @SQLString='DELETE #DataCount '
			SET @SQLString=@SQLString+'INSERT INTO #DataCount '
			SET @SQLString=@SQLString+'SELECT COUNT(*) AS RecordCount FROM '+@LinkedServer+(CASE WHEN @LinkedServer<>'' THEN '.' ELSE '' END)+@Table_Qualifier+'.'+@Table_Owner+'.'+@Table_Name
			EXECUTE (@SQLString)
			
			IF @Option='Yesterday'
				BEGIN
					UPDATE Check_Data
					SET YesterdayCount=ISNULL((SELECT RecordCount FROM #DataCount),0)
					WHERE LinkedServer=@LinkedServer AND Table_Qualifier=@Table_Qualifier AND Table_Owner=@Table_Owner AND Table_Name=@Table_Name
				END
			IF @Option='Now'
				BEGIN
					UPDATE Check_Data
					SET NowCount=ISNULL((SELECT RecordCount FROM #DataCount),0)
					WHERE LinkedServer=@LinkedServer AND Table_Qualifier=@Table_Qualifier AND Table_Owner=@Table_Owner AND Table_Name=@Table_Name
				END
			
			FETCH NEXT FROM CheckTable_C INTO @LinkedServer,@Table_Qualifier,@Table_Owner,@Table_Name
		END
	CLOSE CheckTable_C
	DEALLOCATE CheckTable_C
	
	IF @Option='Now' AND DATEPART(WEEKDAY,GETDATE())>=3
		BEGIN
			SET @NotUpdateTable=(SELECT COUNT(*) FROM Check_Data WHERE YesterdayCount=NowCount AND CHARINDEX('BK',Table_Name)=0 AND CHARINDEX('_',Table_Name)=0)
			IF @NotUpdateTable<>0
				BEGIN
					SET @EmailBody=''
					SET @EmailBody=@EmailBody+'<html><body><TABLE style='+''''+'POSITION: relative;left: 0 ; FONT-SIZE: 8pt; Z-INDEX: 101; LEFT: 8px; COLOR: blue; FONT-FAMILY: Verdana, Arial;'+''''+' cellSpacing=0 cellPadding=0  border=0>'
					SET @EmailBody=@EmailBody+'<tr><td>Hello,<br><br>There are some tables record count data were not changed!<br><br>The following is the result! This is an automatically e-mail, please do not reply it! <br><br><br>Thanks a lot !<br><br><br>Administrator: JG Zhang <br>E-mail: <a href='+''''+'mailto:'+''''+'>jianguang.zhang@multek.com.hk</a><br>Phone: 0755-61266888-113</td></tr></TABLE><br><hr />'
					SET @EmailBody=@EmailBody+'<span style='+''''+'FONT-SIZE: 10pt ;  font-family: Times New Roman;'+''''+'><strong>Date:'+CONVERT(VARCHAR(20),GETDATE(),120)+' Not changed table(s): '+CONVERT(VARCHAR(10),@NotUpdateTable)+'<br>'
				    SET @EmailBody=@EmailBody+'<table width=100%  style='+''''+'FONT-SIZE: 10pt ; background-color: white; font-family: '+''''+'Times New Roman'+''''+';'+''''+' border=1 cellpadding=1 cellspacing=1>'
					SET @EmailBody=@EmailBody+'<TR align=left style='+''''+'font-weight: bold; color: white; background-color: navy;'+''''+'><td >Linked Server</td><td>Database Name</td><td>Owner</td><td>Table Name</td><td>Yesterday Record Count</td><td>Now Record Count</td></tr>'
					DECLARE NotUpdatedTable_C CURSOR FOR
					SELECT LinkedServer,Table_Qualifier,Table_Owner,Table_Name,YesterdayCount,NowCount FROM Check_Data WHERE CHARINDEX('BK',Table_Name)=0 AND CHARINDEX('_',Table_Name)=0 ORDER BY LinkedServer,Table_Qualifier,Table_Name
					OPEN NotUpdatedTable_C
					FETCH NEXT FROM NotUpdatedTable_C INTO @LinkedServer,@Table_Qualifier,@Table_Owner,@Table_Name,@YesterdayCount,@NowCount
					WHILE @@FETCH_STATUS=0
						BEGIN
							IF @YesterdayCount=@NowCount
								BEGIN
									SET @EmailBody=@EmailBody+'<TR align=left style='+''''+'color: red'+''''+'><td >'+(CASE WHEN @LinkedServer='' THEN 'HKGNT111' ELSE @LinkedServer END)+'</td><td>'+@Table_Qualifier+'</td><td>'+@Table_Owner+'</td><td>'+@Table_Name+'</td><td>'+CONVERT(VARCHAR(10),@YesterdayCount)+'</td><td>'+CONVERT(VARCHAR(10),@NowCount)+'</td></tr>'
								END
							ELSE
								BEGIN
									SET @EmailBody=@EmailBody+'<TR align=left><td >'+(CASE WHEN @LinkedServer='' THEN 'HKGNT111' ELSE @LinkedServer END)+'</td><td>'+@Table_Qualifier+'</td><td>'+@Table_Owner+'</td><td>'+@Table_Name+'</td><td>'+CONVERT(VARCHAR(10),@YesterdayCount)+'</td><td>'+CONVERT(VARCHAR(10),@NowCount)+'</td></tr>'
								END							
							FETCH NEXT FROM NotUpdatedTable_C INTO @LinkedServer,@Table_Qualifier,@Table_Owner,@Table_Name,@YesterdayCount,@NowCount
						END
					CLOSE NotUpdatedTable_C
					DEALLOCATE NotUpdatedTable_C
					SET @EmailBody=@EmailBody+'</table>'
					SET @EmailBody=@EmailBody+'</body></html>'
					--select @EmailBody
					EXECUTE sp_Send_Mail @TO='CN-HKGMultekApplications&Business@cn.flextronics.com',@Cc='',@Bcc='',@Subject='There are some tables record count data were not changed!',@Body=@EmailBody
				END
		END

END
GO
