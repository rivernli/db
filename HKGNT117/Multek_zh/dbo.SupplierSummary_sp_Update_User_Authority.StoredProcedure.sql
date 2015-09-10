USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[SupplierSummary_sp_Update_User_Authority]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create PROCEDURE [dbo].[SupplierSummary_sp_Update_User_Authority]
	@UserID VARCHAR(50),
	@MenuID VARCHAR(50),
	@CanSee BIT
AS

SET NOCOUNT ON

UPDATE SupplierSummary_Authority
SET CanSee=@CanSee
WHERE UserID=@UserID
	AND MenuID=@MenuID

UPDATE SupplierSummary_Authority
SET CanSee=1
FROM SupplierSummary_Authority a,SupplierSummary_Users b
WHERE a.UserID=b.UserID
	AND b.Administrator=1







GO
