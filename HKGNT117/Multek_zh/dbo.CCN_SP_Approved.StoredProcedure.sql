USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[CCN_SP_Approved]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[CCN_SP_Approved] 
	@CCNNo VARCHAR(50)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @Plant VARCHAR(10),@Creator VARCHAR(50),@ToNameList VARCHAR(500),@ToEmailList VARCHAR(1000)
	DECLARE @Subject NVARCHAR(MAX),@Body NVARCHAR(MAX),@CCEmailList VARCHAR(1000)
	
	IF EXISTS(SELECT * FROM CCN_Table WHERE CCNNo=@CCNNo)
		BEGIN
		
		SELECT @Plant=Plant,@Creator=Creator FROM CCN_Table WHERE CCNNo=@CCNNo
		
		SET @ToNameList='';
		SET @ToEmailList=''
		SET @CCEmailList=''
		
		SELECT @ToNameList=ISNULL(FullName,''),
			   @ToEmailList=ISNULL(EMailAddress,'') FROM CCN_User 
			WHERE Enabled = 1 AND LoginName = @Creator
				
		SELECT @CCEmailList=@CCEmailList+ISNULL(EmailAddress,'')+';' FROM CCN_User 
			WHERE Enabled = 1 AND
			((IsQAM=1 OR IsPEM=1) AND CHARINDEX(@Plant,Plant)>0)
			
		SET @Subject = 'A Closed CCN('+@CCNNo+') is approved in CCN system'
		SET @Body = '<font style="FONT-SIZE: 11pt; COLOR: #0070C0;">Dear '+@ToNameList+',<br><br>There is a closed CCN approved by your manager, thanks!</font><br><br><font style="FONT-SIZE: 11pt; COLOR: #0070C0;">Please click on the link below to access CCN system for details: <br /><a href="http://hkgnt117/CCN/Notification.aspx?Num='+@CCNNo+'" target="_blank">http://hkgnt117/CCN</a></font><br><br><font style="FONT-SIZE: 11pt; COLOR: red;">This is an automatically e-mail, please do not reply it! </font>'

		EXEC [CCN_SP_Send_Mail] @To=@ToEmailList,@CC=@CCEmailList,@Body=@Body,@Subject=@Subject
		
		END

END


GO
