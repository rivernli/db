USE [AMD_Lab]
GO
/****** Object:  StoredProcedure [dbo].[AMD_sp_Update_User_Authority]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*============================================ AMD_sp_Update_User_Authority ===================================================================*/

CREATE PROCEDURE [dbo].[AMD_sp_Update_User_Authority]
	@UserID VARCHAR(50),
	@MenuID VARCHAR(50),
	@CanSee BIT
AS

SET NOCOUNT ON

UPDATE AMD_Authority
SET CanSee=@CanSee
WHERE UserID=@UserID
	AND MenuID=@MenuID

UPDATE AMD_Authority
SET CanSee=1
FROM AMD_Authority a,AMD_Users b
WHERE a.UserID=b.UserID
	AND b.Administrator=1


GO
