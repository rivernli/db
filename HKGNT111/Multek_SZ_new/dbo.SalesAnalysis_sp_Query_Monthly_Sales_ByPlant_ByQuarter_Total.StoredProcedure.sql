USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[SalesAnalysis_sp_Query_Monthly_Sales_ByPlant_ByQuarter_Total]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SalesAnalysis_sp_Query_Monthly_Sales_ByPlant_ByQuarter_Total] 
	-- Add the parameters for the stored procedure here
	@Type VARCHAR(30),
	@Year CHAR(4),
	@Site VARCHAR(3)='Chi',
	@Plant VARCHAR(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    -- Insert statements for procedure here
    DECLARE @ReportCode VARCHAR(3)
    
	SET @ReportCode=(CASE @Type WHEN 'PlantSales' THEN '201' WHEN 'VVI' THEN '202' WHEN 'SAMPLE' THEN '203' WHEN 'TOOLING' THEN '204' WHEN 'RMA' THEN '205' WHEN 'OTHERSALES' THEN '206' WHEN 'JVM' THEN '207' WHEN 'SCRAP' THEN '208' ELSE '' END)

	SELECT M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12 
	INTO #Temp
	FROM SalesAnalysis_uvw_Amount_Fiscal 
	WHERE ReportCode =@ReportCode 
		AND Site=@Site 
		AND Plant=@Plant 
		AND Year=@Year
		
	IF @@ROWCOUNT>0
		BEGIN
			SELECT * FROM #Temp
		END
	ELSE
		BEGIN
			SELECT 0 AS M1,0 AS M2,0 AS M3,0 AS M4,0 AS M5,0 AS M6,0 AS M7,0 AS M8,0 AS M9,0 AS M10,0 AS M11,0 AS M12
		END

END
GO
