USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_Shipped_Update_Sale_Account_List]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_Shipped_Update_Sale_Account_List]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @To NVARCHAR(MAX),@Cc NVARCHAR(MAX),@Bcc NVARCHAR(MAX),@Subject NVARCHAR(MAX),@Body NVARCHAR(MAX),@Email NVARCHAR(200),@Total_count INT,@Loop INT
	DECLARE	@Account NVARCHAR(20),@Descriation NVARCHAR(200),@Company NVARCHAR(50)

	-- Insert 180 sale account 
		IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#temp_ttfgld008180') AND TYPE = 'U')
			DROP TABLE #temp_ttfgld008180
		--SELECT * INTO #temp_ttfgld008180 FROM OPENQUERY(AS1P1,'SELECT T$LEAC,T$DESC FROM Baan.ttfgld008180 WHERE t$subl = 0') WHERE t$LEAC between '300000' and '399999'
		SELECT * INTO #temp_ttfgld008180 FROM OPENQUERY(AS1P1,'SELECT T$LEAC,T$DESC FROM Baan.ttfgld008180 WHERE t$subl = 0 and t$leac between ''300000'' and ''399999''')
		
		INSERT INTO dbo.ShipmentReport_Shipped_Sale_Account_List(Account,[Description],Company,[include]) SELECT T$LEAC,T$DESC,'180',NULL FROM #temp_ttfgld008180 AS A WHERE A.T$LEAC NOT IN(SELECT Account FROM ShipmentReport_Shipped_Sale_Account_List where company = 180)

	-- Insert 183 sale account 
		IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#temp_ttfgld008183') AND TYPE = 'U')
			drop table #temp_ttfgld008183
		SELECT * INTO #temp_ttfgld008183 FROM OPENQUERY(AS1P1,'SELECT T$LEAC,T$DESC FROM Baan.ttfgld008183 WHERE t$subl = 0') WHERE t$LEAC between '300000' and '399999'
		
		INSERT INTO dbo.ShipmentReport_Shipped_Sale_Account_List(Account,[Description],Company,[include]) SELECT T$LEAC,T$DESC,'183',NULL FROM #temp_ttfgld008183 AS A WHERE A.T$LEAC NOT IN(SELECT Account FROM ShipmentReport_Shipped_Sale_Account_List where company = 183)

	--	-- Update include field
	--	UPDATE dbo.ShipmentReport_Shipped_Sale_Account_List SET [Include] = 0 
	--	UPDATE dbo.ShipmentReport_Shipped_Sale_Account_List SET [Include] = 1 
	--	FROM dbo.ShipmentReport_Shipped_Sale_Account_List AS A, FactoryLoading.dbo.sale_Account AS B
	--	WHERE B.Account = A.Account
	--	AND	  B.Company = A.Company

	-- Send email to admin if exists new account

	IF EXISTS(SELECT TOP 1 * FROM dbo.ShipmentReport_Shipped_Sale_Account_List WHERE [INCLUDE] IS NULL)
		BEGIN
			IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#temp_email_Note') AND TYPE = 'U')
				DROP TABLE #temp_email_Note

			SELECT Account,[Description],Company INTO #temp_email_Note FROM dbo.ShipmentReport_Shipped_Sale_Account_List WHERE [INCLUDE] IS NULL
			ALTER TABLE #temp_email_Note ADD ID INT IDENTITY
			
			SELECT @Total_count = MAX(ID) FROM #temp_email_Note

			SET @Loop = 1 

			SET @Body = N'<html>'
			SET @Body = @Body + N'<body>'
			SET @Body = @Body + N'<TABLE id=Table2 style='+''''+'POSITION: relative;left: 0 ; FONT-SIZE: 8pt; Z-INDEX: 101; LEFT: 8px; COLOR: blue; FONT-FAMILY: Verdana, Arial;'+''''+' cellSpacing=0 cellPadding=0  border=0>'
			SET @Body = @Body + N'<tr>'
			SET @Body = @Body + N'<td>Hello!<br><br>'
			SET @Body = @Body + N'The finance account update successful!</br>'
			SET @Body = @Body + N'<br>There are some new finance account add , Please review following details!<br>'
			SET @Body = @Body + N'<br>'
			SET @Body = @Body + N'</td>'
			SET @Body = @Body + N'</tr>'
			SET @Body = @Body + N'</table>'
			SET @Body = @Body + N'<br/>'
			SET @Body = @Body + N'<table width=100% style='+''''+'FONT-SIZE: 10pt ; background-color: white; font-family: '+''''+'Times New Roman; border='+''''+'1'+''''+' cellpadding='+''''+'1'+''''+' cellspacing='+''''+'1'+''''+' >'
			SET @Body = @Body + N'<TR align=left style='+''''+'font-weight: bold; color: white; background-color: navy;'+''''+'>'
			SET @Body = @Body + N'<td>Account</td>'
			SET @Body = @Body + N'<td>Description</td>'
			SET @Body = @Body + N'<td>Company</td>'
			SET @Body = @Body + N'</tr>'
			WHILE @Loop <= @Total_count
				BEGIN
					SELECT @Account = Account,@Descriation = [Description],@Company = Company FROM #temp_email_Note WHERE ID = @Loop
					SET @Body = @Body + N'<tr>'
					SET @Body = @Body + N'<td>'+@Account+'</td>'
					SET @Body = @Body + N'<td>'+@Descriation+'</td>'
					SET @Body = @Body + N'<td>'+@Company+'</td>'
					SET @Body = @Body + N'</tr>'
					SET @Loop = @Loop + 1
				END
			SET @Body = @Body + N'</Table>'
			SET @Body = @Body + N'<br/>'
			SET @Body = @Body + N'<br/>'
			SET @Body = @Body + N'<font face=Verdana color=Blue size=1>Thanks a lot!</br>'
			SET @Body = @Body + N'Admin: Peter Xu;Rivern Li</br>'
			SET @Body = @Body + N'E-mail:<a href='+''''+'mailto:'+''''+'>Peter.xu@hk.multek.com</a>,<a href='+''''+'mailto:'+''''+'>Rivern.li@hk.multek.com</a></br>'
			SET @Body = @Body + N'Phone:(+86)18998189980</font></br>'
			SET @Body = @Body + N'</body>'
			SET @Body = @Body + N'</html>'

			SET @To		 = 'Rivern.li@hk.multek.com;jianguang.zhang@hk.multek.com;peter.xu@hk.multek.com'
			SET @Cc		 = ''
			SET @BCC	 = ''
			SET @Subject = 'Finance New sales account add !'

			EXEC	msdb.dbo.sp_send_dbmail
					@profile_name          ='CN-HKGMultekApplications&Business@cn.flextronics.com',
					@recipients            =@To,
					@copy_recipients       =@CC,
					@blind_copy_recipients =@BCC,
					@body                  =@Body, 
					@subject               =@Subject,
					--@file_attachments =@Attachment,
					@body_format		   ='HTML'  
		END
	
	---------------------------------------------------------------------------------------------------------
	---- Check Leadge account if first time used
	--	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('tempdb.#First_Used_Account') AND TYPE = 'U')
	--		DROP TABLE #First_Used_Account

	--	CREATE TABLE #First_Used_Account
	--	(
	--		T$LEAC	NVARCHAR(12),
	--		T$CUNT	INT,
	--		T$DESC  NVARCHAR(50),
	--		T$CNPR  INT
	--	)

	--	INSERT INTO #First_Used_Account
	--	SELECT T$LEAC,COUNT(*),180 FROM [HKGNT111].[Multek_SZ_New].[dbo].[TTFGLD106180] GROUP BY T$LEAC HAVING COUNT(*) = 1

	--	INSERT INTO #First_Used_Account
	--	SELECT T$LEAC,COUNT(*),181 FROM [HKGNT111].[Multek_SZ_New].[dbo].[TTFGLD106181] GROUP BY T$LEAC HAVING COUNT(*) = 1

	--	INSERT INTO #First_Used_Account
	--	SELECT T$LEAC,COUNT(*),183 FROM [HKGNT111].[Multek_SZ_New].[dbo].[TTFGLD106183] GROUP BY T$LEAC HAVING COUNT(*) = 1

	--	INSERT INTO #First_Used_Account
	--	SELECT T$LEAC,COUNT(*),184 FROM [HKGNT111].[Multek_SZ_New].[dbo].[TTFGLD106184] GROUP BY T$LEAC HAVING COUNT(*) = 1

	--	INSERT INTO #First_Used_Account
	--	SELECT T$LEAC,COUNT(*),185 FROM [HKGNT111].[Multek_SZ_New].[dbo].[TTFGLD106185] GROUP BY T$LEAC HAVING COUNT(*) = 1

	--	INSERT INTO #First_Used_Account
	--	SELECT T$LEAC,COUNT(*),186 FROM [HKGNT111].[Multek_SZ_New].[dbo].[TTFGLD106186] GROUP BY T$LEAC HAVING COUNT(*) = 1

	--	INSERT INTO #First_Used_Account
	--	SELECT T$LEAC,COUNT(*),819 FROM [HKGNT111].[Multek_SZ_New].[dbo].[TTFGLD106819] GROUP BY T$LEAC HAVING COUNT(*) = 1

--		IF EXISTS(SELECT TOP 1 * FROM #First_Used_Account)
--			BEGIN
--				SET @To		 = 'Rivern.li@hk.multek.com;jianguang.zhang@hk.multek.com;peter.xu@hk.multek.com'
--				SET @Cc		 = ''
--				SET @BCC	 = 'rivern@189.cn'
--				SET @Subject = 'Please note leadge account First time use !'
--
--				EXEC	msdb.dbo.sp_send_dbmail
--						@profile_name          ='CN-HKGMultekApplications&Business@cn.flextronics.com',
--						@recipients            =@To,
--						@copy_recipients       =@CC,
--						@blind_copy_recipients =@BCC,
--						@body                  =@Body, 
--						@subject               =@Subject,
--						--@file_attachments =@Attachment,
--						@body_format		   ='HTML' 
--			END

END



GO
