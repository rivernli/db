USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Query_2D_Report_Role]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Query_2D_Report_Role]
	-- Add the parameters for the stored procedure here
	@Code VARCHAR(2)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    SELECT a.*
    FROM (
	SELECT a.UserID,c.BDM+' ('+c.UserID+')' AS UserName ,ISNULL((SELECT e.CanUpload FROM ShipmentReport_2d_Report_Upload_Authority e WHERE e.ReportCode=d.Code AND e.UserID=a.UserID),0) AS CanUpload
	FROM ShipmentReport_Authority a,ShipmentReport_Menu b,ShipmentReport_Users c,ShipmentReport_2D_Report d
	WHERE a.MenuID=b.ID
		AND a.UserID=c.UserID
		AND b.Description=d.Description
		AND d.Code=@Code
		AND a.CanSee=1
		) a
	ORDER BY a.CanUpload DESC,a.UserName
	

END
GO
