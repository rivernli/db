USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[QualityReport_sp_Update_User_Authority]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[QualityReport_sp_Update_User_Authority]
	@UserID VARCHAR(50),
	@MenuID VARCHAR(50),
	@CanSee BIT
AS

SET NOCOUNT ON

UPDATE QualityReport_Authority
SET CanSee=@CanSee
WHERE UserID=@UserID
	AND MenuID=@MenuID
GO
