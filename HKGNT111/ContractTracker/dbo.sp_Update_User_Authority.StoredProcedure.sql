USE [ContractTracker]
GO
/****** Object:  StoredProcedure [dbo].[sp_Update_User_Authority]    Script Date: 11/06/2014 15:55:54 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Update_User_Authority]
	@UserID VARCHAR(50),
	@MenuID VARCHAR(50),
	@CanSee BIT
AS

SET NOCOUNT ON

UPDATE Authority
SET CanSee=@CanSee
WHERE UserID=@UserID
	AND MenuID=@MenuID
GO
