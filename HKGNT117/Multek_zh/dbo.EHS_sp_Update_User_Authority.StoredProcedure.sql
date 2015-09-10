USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[EHS_sp_Update_User_Authority]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[EHS_sp_Update_User_Authority]
	@UserID VARCHAR(50),
	@MenuID VARCHAR(50),
	@CanSee BIT
AS

SET NOCOUNT ON

UPDATE EHS_Authority
SET CanSee=@CanSee
WHERE UserID=@UserID
	AND MenuID=@MenuID

UPDATE EHS_Authority
SET CanSee=1
FROM EHS_Authority a,EHS_Users b
WHERE a.UserID=b.UserID
	AND b.Administrator=1










GO
