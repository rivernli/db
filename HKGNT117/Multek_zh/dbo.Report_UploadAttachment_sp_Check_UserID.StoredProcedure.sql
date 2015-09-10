USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Report_UploadAttachment_sp_Check_UserID]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Report_UploadAttachment_sp_Check_UserID]   
		@Account NVARCHAR(50),
		@menuid VARCHAR(50)
AS

SET NOCOUNT ON
select 1 from Report_UploadAttachment_Authority WHERE UserID=@Account AND menuid=@menuid AND CanSee=1
/*
IF EXISTS(SELECT * FROM Report_UploadAttachment_Authority WHERE UserID=@Account AND menuid=@menuid AND CanSee=0)
	BEGIN
		RAISERROR('Sorry, you have not authority to access the system!',16,1)
		RETURN
	END
*/
GO
