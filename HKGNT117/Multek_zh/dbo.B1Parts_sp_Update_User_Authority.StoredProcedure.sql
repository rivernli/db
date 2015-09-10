USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[B1Parts_sp_Update_User_Authority]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[B1Parts_sp_Update_User_Authority]
	@UserID VARCHAR(50),
	@MenuID VARCHAR(50),
	@CanSee BIT
AS

SET NOCOUNT ON

UPDATE B1Parts_Authority
SET CanSee=@CanSee
WHERE UserID=@UserID
	AND MenuID=@MenuID

UPDATE B1Parts_Authority
SET CanSee=1
FROM B1Parts_Authority a,B1Parts_Users b
WHERE a.UserID=b.UserID
	AND b.Administrator=1









GO
