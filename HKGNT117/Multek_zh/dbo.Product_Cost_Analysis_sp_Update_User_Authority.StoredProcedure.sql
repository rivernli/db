USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Product_Cost_Analysis_sp_Update_User_Authority]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create PROCEDURE [dbo].[Product_Cost_Analysis_sp_Update_User_Authority]
	@UserID VARCHAR(50),
	@MenuID VARCHAR(50),
	@CanSee BIT
AS

SET NOCOUNT ON

UPDATE Product_Cost_Analysis_Authority
SET CanSee=@CanSee
WHERE UserID=@UserID
	AND MenuID=@MenuID

UPDATE Product_Cost_Analysis_Authority
SET CanSee=1
FROM Product_Cost_Analysis_Authority a,Product_Cost_Analysis_Users b
WHERE a.UserID=b.UserID
	AND b.Administrator=1






GO
