USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_Update_UserAuthority]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DistributionReport_sp_Update_UserAuthority]
	@UserID VARCHAR(50),
	@MenuID VARCHAR(50),
	@CanSee BIT
AS

SET NOCOUNT ON

UPDATE DistributionReport_Authority
SET CanSee=@CanSee
WHERE UserID=@UserID
	AND MenuID=@MenuID

UPDATE DistributionReport_Authority
SET CanSee=1
FROM DistributionReport_Authority a,DistributionReport_Users b
WHERE a.UserID=b.UserID
	AND b.Administrator=1
GO
