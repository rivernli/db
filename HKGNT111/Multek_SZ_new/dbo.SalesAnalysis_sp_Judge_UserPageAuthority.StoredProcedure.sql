USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[SalesAnalysis_sp_Judge_UserPageAuthority]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SalesAnalysis_sp_Judge_UserPageAuthority]
	@UserID VARCHAR(50)=NULL,
	@Page VARCHAR(200)=NULL,
	@HaveAuthority BIT=NULL OUTPUT
AS

SET NOCOUNT ON

SET @Page=RIGHT(@Page,LEN(@Page)-CHARINDEX('/',@Page,2)+1)
SET @Page='~'+@Page

SET @HaveAuthority=0
IF EXISTS(SELECT a.* FROM SalesAnalysis_Authority a,SalesAnalysis_Menu m WHERE a.MenuID=m.ID AND a.UserID=@UserID AND m.Page=@Page AND a.CanSee=1)
	BEGIN
		SET @HaveAuthority=1
	END
GO
