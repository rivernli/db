USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[UMS_sp_Judge_User_Page_Authority]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[UMS_sp_Judge_User_Page_Authority]
	@UserID VARCHAR(50)=NULL,
	@Page VARCHAR(200)=NULL,
	@HaveAuthority BIT=NULL OUTPUT
AS

SET NOCOUNT ON

SET @Page=RIGHT(@Page,LEN(@Page)-CHARINDEX('/',@Page,2)+1)
SET @Page='~'+@Page

SET @HaveAuthority=0
IF EXISTS(SELECT a.* FROM UMS_Authority a,UMS_Menu m WHERE a.MenuID=m.ID AND a.UserID=@UserID AND m.Page=@Page AND a.CanSee=1)
	BEGIN
		SET @HaveAuthority=1
	END




GO
