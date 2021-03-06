USE [ContractTracker]
GO
/****** Object:  StoredProcedure [dbo].[sp_Check_UserID]    Script Date: 11/06/2014 15:55:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Check_UserID]   
		@Domain VARCHAR(50),
		@Account VARCHAR(50)
AS

SET NOCOUNT ON

DECLARE @UserID VARCHAR(50)

SET @UserID=LTRIM(RTRIM(@Domain))+'\'+LTRIM(RTRIM(@Account))

IF NOT EXISTS(SELECT * FROM Users WHERE UserID=@UserID)
	BEGIN
		RAISERROR('Sorry, you have not authority to access the system!',16,1)
		RETURN
	END
IF EXISTS(SELECT * FROM Users WHERE UserID=@UserID AND Enable=0)
	BEGIN
		RAISERROR('Sorry, you have not authority to access the system!',16,1)
		RETURN
	END
GO
