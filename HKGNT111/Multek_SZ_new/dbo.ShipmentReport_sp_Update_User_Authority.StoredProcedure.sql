USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Update_User_Authority]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Update_User_Authority]
	@UserID VARCHAR(50),
	@MenuID VARCHAR(50),
	@CanSee BIT
AS

SET NOCOUNT ON

UPDATE ShipmentReport_Authority
SET CanSee=@CanSee
WHERE UserID=@UserID
	AND MenuID=@MenuID

UPDATE ShipmentReport_Authority
SET CanSee=1
FROM ShipmentReport_Authority a,ShipmentReport_Users b
WHERE a.UserID=b.UserID
	AND b.Administrator=1
GO
