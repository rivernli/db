USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[B1Parts_sp_Query_UserMenu_Authority]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create PROCEDURE [dbo].[B1Parts_sp_Query_UserMenu_Authority]
	@MenuID	 	VARCHAR(200)=NULL
AS
SET NOCOUNT ON

	BEGIN
		select a.UserID,a.BDM,b.User_Right from B1Parts_Users a,B1Parts_Authority b WHERE a.UserID=b.UserID AND b.MenuID=@MenuID ORDER BY BDM ASC
	END


GO
