USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[SQM_sp_Update_User_Authority]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SQM_sp_Update_User_Authority]
	@UserID VARCHAR(50),
	@MenuID VARCHAR(50),
	@CanSee BIT
AS

SET NOCOUNT ON

UPDATE SQM_System_Authority
SET CanSee=@CanSee
WHERE UserID=@UserID
	AND MenuID=@MenuID

UPDATE SQM_System_Authority
SET CanSee=1
FROM SQM_System_Authority a,SQM_System_Users b
WHERE a.UserID=b.UserID
	AND b.Administrator=1





GO
