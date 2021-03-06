USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[VI_Report_sp_Query_DistributionYears]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[VI_Report_sp_Query_DistributionYears] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT  TOP 5 CalenderYear AS DistributionYears
	From DataWarehouse.dbo.DW_DIM_Calender
	GROUP BY CalenderYear
	ORDER BY CalenderYear DESC
	END 


GO
