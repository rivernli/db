USE [AMD_Lab]
GO
/****** Object:  StoredProcedure [dbo].[Monthly_Cu_Tensile_Strength_sp_Update_User_Authority]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 

create PROCEDURE [dbo].[Monthly_Cu_Tensile_Strength_sp_Update_User_Authority]
	@UserID VARCHAR(50),
	@MenuID VARCHAR(50),
	@CanSee BIT
AS

SET NOCOUNT ON

UPDATE Monthly_Cu_Tensile_Strength_Authority
SET CanSee=@CanSee
WHERE UserID=@UserID
	AND MenuID=@MenuID

UPDATE Monthly_Cu_Tensile_Strength_Authority
SET CanSee=1
FROM Monthly_Cu_Tensile_Strength_Authority a,Monthly_Cu_Tensile_Strength_Users b
WHERE a.UserID=b.UserID
	AND b.Administrator=1







GO
