USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Delivery_sp_Update_User_Authority]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




/*============================================ sp_Update_User_Authority ===================================================================*/

CREATE PROCEDURE [dbo].[Delivery_sp_Update_User_Authority]
	@UserID VARCHAR(50),
	@MenuID VARCHAR(50),
	@CanSee BIT
AS

SET NOCOUNT ON

UPDATE Delivery_System_Authority
SET CanSee=@CanSee
WHERE UserID=@UserID
	AND MenuID=@MenuID

UPDATE Delivery_System_Authority
SET CanSee=1
FROM Delivery_System_Authority a,Delivery_System_Users b
WHERE a.UserID=b.UserID
	AND b.Administrator=1







GO
