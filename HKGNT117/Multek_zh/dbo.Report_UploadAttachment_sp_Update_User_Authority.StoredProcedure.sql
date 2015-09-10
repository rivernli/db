USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Report_UploadAttachment_sp_Update_User_Authority]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create PROCEDURE [dbo].[Report_UploadAttachment_sp_Update_User_Authority]
	@UserID VARCHAR(50),
	@MenuID VARCHAR(50),
	@CanSee BIT
AS

SET NOCOUNT ON

UPDATE Report_UploadAttachment_Authority
SET CanSee=@CanSee
WHERE UserID=@UserID
	AND MenuID=@MenuID

UPDATE Report_UploadAttachment_Authority
SET CanSee=1
FROM Report_UploadAttachment_Authority a,Report_UploadAttachment_Users b
WHERE a.UserID=b.UserID
	AND b.Administrator=1







GO
