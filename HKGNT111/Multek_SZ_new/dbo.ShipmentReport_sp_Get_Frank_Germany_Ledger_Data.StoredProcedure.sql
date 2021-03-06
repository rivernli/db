USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Get_Frank_Germany_Ledger_Data]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Get_Frank_Germany_Ledger_Data] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @SQLString VARCHAR(MAX),
			@SourceDatabase VARCHAR(50),@SourceTable VARCHAR(50),@SourceDataTextFile VARCHAR(50),
			@SourceDBUserID VARCHAR(50),@SourceDBUserPassword VARCHAR(50),@SourceLinkServer VARCHAR(50),
			@SourceZipFile VARCHAR(50),@SourceZipEXE VARCHAR(50),
			@NetUseDisk CHAR(3),@NetUseIP VARCHAR(100),@NetUseAccount VARCHAR(50),@NetUsePassword VARCHAR(50),@NetUseVDisk CHAR(2),
			@TargetUnZipEXE VARCHAR(50),@TargetFileFolder VARCHAR(50),@TargetDatabase VARCHAR(50),@TargetTable VARCHAR(50),
			@TargetDBUserID VARCHAR(50),@TargetDBUserPassword VARCHAR(50),@TargetLinkServer VARCHAR(50)

	SET	@SourceDatabase='ODS_Corp'
	SET @SourceTable='vcr_For_RevenueReport_Germany_Ledger'
	SET @SourceDataTextFile='D:\GermanyLedger.txt'
	SET @SourceDBUserID='RevenueUser'
	SET @SourceDBUserPassword='XiaGuangMary1!'
	SET @SourceLinkServer='[10.10.8.226]'
    SET @SourceZipFile='D:\GermanyLedger.zip'
	SET @SourceZipEXE='D:\TransData\WinZip\WzZip.exe'
	SET @NetUseIP='HKGNT111.asia.ad.flextronics.com'
	SET @NetUseAccount='asia\hkg_sql'
	SET @NetUsePassword='P@ssw0rd'
	SET @NetUseVDisk='Z:'	
	SET @NetUseDisk='D$'	
	SET @TargetUnZipEXE='D:\TransDBProject\WinZip\WZUNZIP.EXE'
	SET @TargetFileFolder='D:\GermanyLedger'
	SET @TargetDBUserID='sa'
	SET @TargetDBUserPassword='P@ssw0rd'	
	SET @TargetDatabase='Multek_SZ_New'
	SET @TargetTable='ShipmentReport_Germany_Ledger'
	SET @TargetLinkServer='HKGNT111'

	SET @SQLString=''
	SET @SQLString=' XP_CMDShell '+''''''+' BCP '+@SourceDatabase+'.dbo.'+@SourceTable +' out '+@SourceDataTextFile+' -c -t -U '+@SourceDBUserID+' -P '+@SourceDBUserPassword+''''''
	SET @SQLString=@SourceLinkServer+'.'+@SourceDatabase++'..SP_EXECUTESQL ' +'N'+''''+@SQLString+''''	
	EXECUTE (@SQLString)

	SET @SQLString=''
	SET @SQLString=' XP_CMDShell '+''''''+' DEL '+@SourceZipFile+''''''
	SET @SQLString=@SourceLinkServer+'.'+@SourceDatabase++'..SP_EXECUTESQL ' +'N'+''''+@SQLString+''''	
	EXECUTE (@SQLString)

	SET @SQLString=''
	SET @SQLString=' XP_CMDShell '+''''''+' '+@SourceZipEXE+' '+@SourceZipFile+' '+@SourceDataTextFile+''''''
	SET @SQLString=@SourceLinkServer+'.'+@SourceDatabase++'..SP_EXECUTESQL ' +'N'+''''+@SQLString+''''	
	EXECUTE (@SQLString)

	SET @SQLString=''
	SET @SQLString=' xp_cmdshell '+''''''+'net use * /del /y'+''''''
	SET @SQLString=@SourceLinkServer+'.'+@SourceDatabase++'..SP_EXECUTESQL ' +'N'+''''+@SQLString+''''	
	EXECUTE (@SQLString)

	SET @SQLString=''
	SET @SQLString=' xp_cmdshell '+''''''+'net use '+@NetUseVDisk+' \\'+@NetUseIP+'\'+@NetUseDisk+' '+@NetUsePassword+' /user:'+@NetUseAccount+''''''
	SET @SQLString=@SourceLinkServer+'.'+@SourceDatabase++'..SP_EXECUTESQL ' +'N'+''''+@SQLString+''''	
	EXECUTE (@SQLString)

	SET @SQLString=''
	SET @SQLString=' xp_cmdshell '+''''''+'Copy '+@SourceZipFile+' '+@NetUseVDisk+'\'+''''''
	SET @SQLString=@SourceLinkServer+'.'+@SourceDatabase++'..SP_EXECUTESQL ' +'N'+''''+@SQLString+''''	
	EXECUTE (@SQLString)

	SET @SQLString=''
	SET @SQLString=' XP_CMDShell '+''''+' '+@TargetUnZipEXE+' -O '+@SourceZipFile+' '+@TargetFileFolder+''''
	EXECUTE (@SQLString)

	SET @SQLString=''
	SET @SQLString=' TRUNCATE TABLE '+@TargetTable
	EXECUTE (@SQLString)

	SET @SQLString=''
	SET @SQLString=' xp_cmdshell '+''''+'bcp '+@TargetDatabase+'.dbo.'+@TargetTable+' in '+@TargetFileFolder+'\GermanyLedger.txt -c -t -U '+@TargetDBUserID+' -P '+@TargetDBUserPassword+''''
	EXECUTE (@SQLString)

	SET @SQLString=''
	SET @SQLString=' XP_CMDShell '+''''''+' DEL '+@SourceZipFile+''''''
	SET @SQLString=@SourceLinkServer+'.'+@SourceDatabase++'..SP_EXECUTESQL ' +'N'+''''+@SQLString+''''	
	EXECUTE (@SQLString)

	SET @SQLString=''
	SET @SQLString=' XP_CMDShell '+''''''+' DEL '+@SourceDataTextFile+''''''
	SET @SQLString=@SourceLinkServer+'.'+@SourceDatabase++'..SP_EXECUTESQL ' +'N'+''''+@SQLString+''''	
	EXECUTE (@SQLString)

	SET @SQLString=''
	SET @SQLString=' XP_CMDShell '+''''+' DEL '+@SourceZipFile+''''
	EXECUTE (@SQLString)
	--DBCC SHRINKFILE (N'TestDB_Data' , 0)
	--DBCC SHRINKFILE (N'TestDB_Log' , 0)

END
GO
