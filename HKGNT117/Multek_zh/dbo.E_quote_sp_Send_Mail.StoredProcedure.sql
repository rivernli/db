USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[E_quote_sp_Send_Mail]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[E_quote_sp_Send_Mail] 
	-- Add the parameters for the stored procedure here
	@To NVARCHAR(MAX)=NULL,
	@CC NVARCHAR(MAX)=NULL,
	@BCC NVARCHAR(MAX)=NULL,
	@Body NVARCHAR(MAX)=NULL,
	@Subject NVARCHAR(MAX)=NULL,
	@Attachment VARCHAR(MAX)=NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	EXEC msdb.dbo.sp_send_dbmail
		@profile_name='CN-HKGMultekApplications&Business@cn.flextronics.com',
		@recipients=@To,
		@copy_recipients =@CC,
		@blind_copy_recipients =@BCC,
		@body=@Body, 
		@subject =@Subject,
		@file_attachments =@Attachment,
		@body_format  =  'HTML'      
END 




GO
