USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_Query_Layer]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DistributionReport_sp_Query_Layer] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	/*
	SELECT Lays AS Name
	FROM ShipmentReport_uvw_Shipped_All
	WHERE Lays >0
	GROUP BY Lays
	ORDER BY Lays
	*/

	SELECT Lay as name FROM DistributionReport_Lay ORDER BY LEN(Lay),Lay
END
GO
