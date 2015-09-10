USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[Cost_sp_Update_User_Authority]    Script Date: 2014/11/12 17:02:02 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[Cost_sp_Update_User_Authority]
	@UserID VARCHAR(50),
	@MenuID VARCHAR(50),
	@CanSee BIT
AS

SET NOCOUNT ON

UPDATE Cost_Authority
SET CanSee=@CanSee
WHERE UserID=@UserID
	AND MenuID=@MenuID
GO
