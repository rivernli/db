USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Query_Role_User]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Query_Role_User]
	-- Add the parameters for the stored procedure here
	@MenuID VARCHAR(50),
	@UserID VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    SELECT a.*
    FROM (
			SELECT a.UserID,b.BDM +'('+b.UserID+')' AS UserName,a.CanSee
			FROM ShipmentReport_Authority a,ShipmentReport_Users b
			WHERE a.UserID=b.UserID
				AND a.MenuID=@MenuID
				AND a.UserID<>@UserID
		 ) a
	--ORDER BY a.UserID,b.BDM
	ORDER BY a.CanSee DESC,a.UserName
END
GO
