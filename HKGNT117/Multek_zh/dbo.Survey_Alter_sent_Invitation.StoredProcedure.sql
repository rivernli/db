USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Survey_Alter_sent_Invitation]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Survey_Alter_sent_Invitation] 
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @To NVARCHAR(MAX),@Cc NVARCHAR(MAX),@Bcc NVARCHAR(MAX),@Subject NVARCHAR(MAX),@Body NVARCHAR(MAX),@Email NVARCHAR(200)
	DECLARE	@AlterDate	NVARCHAR(5)

	Select @AlterDate = CAST(right(CONVERT(varchar(100), GETDATE(), 12),4) AS NVARCHAR(5))

	--IF @AlterDate = '0605' OR @AlterDate = '1205'		--Cynthia 2012/12/5 request cancel 1205 , only keep 06/05
	IF @AlterDate = '0605' 
		BEGIN
			SET @Body = N'<html>'
			SET @Body = @Body + N'<body>'
			SET @Body = @Body + N'<font face=Verdana color=green size=3><b>Dear Customer Survey Admin:</b></font><br><hr></br>'
			SET @Body = @Body + N'<font face=Verdana color=green size=2> It’s time to send out Automotive survey...</font>'
			SET @Body = @Body + N'<br/>'
			SET @Body = @Body + N'<br/>'
			SET @Body = @Body + N'<font face=Verdana color=green size=2>Click <a href='+''''+'http://hkgapp02.hk.multek.com:8888/marketing/AutoSurvery/CustM.aspx'+''''+'>here</a>  to Login admin Tools.</font></b><br/>'
			SET @Body = @Body + N'<br/>'
			SET @Body = @Body + N'<br/>'
			SET @Body = @Body + N'<font face=Verdana color=green size=2>Thanks!</font></b>'
			SET @Body = @Body + N'</body>'
			SET @Body = @Body + N'</html>'

			--SET @To		 = 'virginia.ip@hk.multek.com'   -- 2013/06/05 SY Leung request modify it
			SET @To		 = 'cynthia.yang@multek.com'
			SET @Cc		 = 'doris.leung@multek.com;Christy.Li@multek.com'
			SET @BCC	 = 'RIVERN.LI@MULTEK.com;Peter.xu@multek.com'
			SET @Subject = 'It’s time to send out Automotive survey'

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
