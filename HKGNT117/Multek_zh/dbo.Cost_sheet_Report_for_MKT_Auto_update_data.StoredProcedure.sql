USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Cost_sheet_Report_for_MKT_Auto_update_data]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Cost_sheet_Report_for_MKT_Auto_update_data]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
--Update view ti tabke
	TRUNCATE TABLE DBO.COST_SHEET_REPORT_FOR_MKT
	INSERT INTO DBO.COST_SHEET_REPORT_FOR_MKT
	SELECT * FROM DBO.VC_COST_SHEET_REPORT_FOR_MKT

-- udpate autocomplete table 
	-- Insert Customer Part Num for autocomplete
	TRUNCATE TABLE DBO.COST_SHEET_REPORT_FOR_MKT_AUTOCOMPLETE_CUSPARTNUM
	INSERT INTO DBO.COST_SHEET_REPORT_FOR_MKT_AUTOCOMPLETE_CUSPARTNUM
	SELECT  CUSPART FROM DBO.COST_SHEET_REPORT_FOR_MKT WHERE CUSPART IS NOT NULL AND CUSPART <> '' GROUP BY CUSPART

	-- Insert Project for autocomplete
	TRUNCATE TABLE dbo.Cost_sheet_Report_for_MKT_autocomplete_Project
	INSERT INTO dbo.Cost_sheet_Report_for_MKT_autocomplete_Project
	SELECT  T$PJNO FROM DBO.COST_SHEET_REPORT_FOR_MKT WHERE T$PJNO IS NOT NULL AND T$PJNO <> '' GROUP BY T$PJNO

	-- Insert OEM for autocomplete
	TRUNCATE TABLE dbo.Cost_sheet_Report_for_MKT_autocomplete_OEM
	INSERT INTO dbo.Cost_sheet_Report_for_MKT_autocomplete_oem
	SELECT  OEM FROM DBO.COST_SHEET_REPORT_FOR_MKT WHERE OEM IS NOT NULL AND OEM <> '' GROUP BY OEM

	-- RESULT CHECKING
	DECLARE @To NVARCHAR(MAX),@Cc NVARCHAR(MAX),@Bcc NVARCHAR(MAX),@Subject NVARCHAR(MAX),@Body NVARCHAR(MAX),@OK NVARCHAR(100)
	
	SET @To			= ''
	SET	@Cc			= ''
	SET @Bcc		= ''
	SET @Subject	= ''
	SET @Body		= ''
	SET	@OK		= ''

	SET @Body=''
	SET @Body=@Body+'<!DOCTYPE html PUBLIC ''-//W3C//DTD XHTML 1.0 Transitional//EN'' ''http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd''>'
	SET @Body=@Body+'<HTML>'
	SET @Body=@Body+'<body style=''font-size: 10pt; font-family: Verdana, Times New Roman, Courier New; background-color: white;''>'
	SET @Body=@Body+'<table cellpadding=''5'' border=''1''  cellspacing=''0'' width=''100%'' style=''border-collapse: collapse;font-size: 8pt; font-family: Verdana, Times New Roman, Courier New''>'
	IF NOT EXISTS(SELECT TOP 1 * FROM COST_SHEET_REPORT_FOR_MKT)
		BEGIN
			SET @Body=@Body+'<tr><td>COST_SHEET_REPORT_FOR_MKT</td><td>0</td><tr/>'
			SET @OK = 'EMPTY'
		END
	IF NOT EXISTS(SELECT TOP 1 * FROM COST_SHEET_REPORT_FOR_MKT_AUTOCOMPLETE_CUSPARTNUM)
		BEGIN
			SET @Body=@Body+'<tr><td>COST_SHEET_REPORT_FOR_MKT_AUTOCOMPLETE_CUSPARTNUM</td><td>0</td><tr/>'
			SET @OK = 'EMPTY'
		END
	IF NOT EXISTS(SELECT TOP 1 * FROM Cost_sheet_Report_for_MKT_autocomplete_Project)
		BEGIN
			SET @Body=@Body+'<tr><td>Cost_sheet_Report_for_MKT_autocomplete_Project</td><td>0</td><tr/>'
			SET @OK = 'EMPTY'
		END
	IF NOT EXISTS(SELECT TOP 1 * FROM Cost_sheet_Report_for_MKT_autocomplete_OEM)
		BEGIN
			SET @Body=@Body+'<tr><td>Cost_sheet_Report_for_MKT_autocomplete_OEM</td><td>0</td><tr/>'
			SET @OK = 'EMPTY'
		END
	SET @Body=@Body+'</table>'
	SET @Body=@Body+'</BODY></HTML>'

	IF	@OK = 'EMPTY' 
		BEGIN
			SET @Subject='MKT cost sheet query come table emptty!please check'
			SET @TO = 'Rivern.Li@HK.MULTEK.COM'
			SET @CC = ''
			SET @BCC = ''
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
END


GO
