USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[CCN_SP_Send_Mail]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[CCN_SP_Send_Mail] 
	@To NVARCHAR(MAX)=NULL,
	@CC NVARCHAR(MAX)=NULL,
	@Body NVARCHAR(MAX)=NULL,
	@Subject NVARCHAR(MAX)=NULL
AS
BEGIN

	SET NOCOUNT ON;

    DECLARE @BCC NVARCHAR(200)
	SET @BCC = 'Arno.Feng@multek.com'
	
	INSERT INTO CCN_MailLog(MailTo,MailCC,MailBCC,Subject,Body) VALUES(@To,@CC,@BCC,@Subject,@Body)
	--EXEC msdb.dbo.sp_send_dbmail
	--	@profile_name='Multek-SQMSystem@cn.flextronics.com',
	--	@recipients=@To,
	--	@copy_recipients=@CC,
	--	@blind_copy_recipients=@BCC,
	--	@body=@Body, 
	--	@subject =@Subject,
	--	@body_format  =  'HTML'      
END





GO
