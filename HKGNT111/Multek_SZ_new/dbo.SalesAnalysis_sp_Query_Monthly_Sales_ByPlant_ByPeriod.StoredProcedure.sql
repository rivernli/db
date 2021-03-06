USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[SalesAnalysis_sp_Query_Monthly_Sales_ByPlant_ByPeriod]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SalesAnalysis_sp_Query_Monthly_Sales_ByPlant_ByPeriod] 
	-- Add the parameters for the stored procedure here
	@Type VARCHAR(50),
	@Year CHAR(4),
	@Period INT,
	@Site VARCHAR(3)='Chi',
	@Plant VARCHAR(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    -- Insert statements for procedure here

	CREATE TABLE #Temp (Sales NUMERIC(19,2))

	DECLARE @SQLString VARCHAR(MAX),@ReportCode VARCHAR(3)
	
	SET @ReportCode=(CASE @Type WHEN 'PlantSales' THEN '101' WHEN 'VVI' THEN '102' WHEN 'SAMPLE' THEN '103' WHEN 'TOOLING' THEN '104' WHEN 'RMA' THEN '105' WHEN 'OTHERSALES' THEN '106' WHEN 'JVM' THEN '107' WHEN 'SCRAP' THEN '108' ELSE '' END)

	SET @SQLString='INSERT INTO #Temp SELECT M'+CONVERT(VARCHAR(2),@Period)+' AS Amount FROM SalesAnalysis_uvw_Amount_Fiscal WHERE ReportCode='+''''+@ReportCode+''''+' AND Site='+''''+@Site+''''+' AND Plant='+''''+@Plant+''''+' AND Year='+''''+@Year+''''

	EXECUTE (@SQLString)
	
	IF EXISTS(SELECT * FROM #Temp)
		BEGIN
			SELECT * FROM #Temp
		END
	ELSE
		BEGIN
			INSERT INTO #Temp (Sales) VALUES(0)
		END
		
	SELECT * FROM #Temp
END
GO
