USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Report_UploadAttachment_sp_Query_UserMenu_Authority]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create PROCEDURE [dbo].[Report_UploadAttachment_sp_Query_UserMenu_Authority]
	@MenuID	 	VARCHAR(200)=NULL
AS
SET NOCOUNT ON

	BEGIN
		select a.UserID,a.BDM,b.User_Right from Report_UploadAttachment_Users a,Report_UploadAttachment_Authority b WHERE a.UserID=b.UserID AND b.MenuID=@MenuID ORDER BY BDM ASC
	END


GO
