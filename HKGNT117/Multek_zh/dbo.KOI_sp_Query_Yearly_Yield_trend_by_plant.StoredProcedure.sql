USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[KOI_sp_Query_Yearly_Yield_trend_by_plant]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 
CREATE PROCEDURE [dbo].[KOI_sp_Query_Yearly_Yield_trend_by_plant] 
	@ReportCode VARCHAR(3), 
	@Year_s VARCHAR(4),
	@Year_e VARCHAR(4),
	@Plant NVARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON;
	IF @ReportCode='001' 
	select 'FY'+[Year] as [Year],ISNULL(SUM(Scrap_sqft),0) AS Scrap_sqft,ISNULL(SUM(FGin_sqft),0) AS FGin_sqft,ISNULL(SUM(Yield_Percentage),0) AS Yield_Percentage from KOI_Yearly_Yield_trend_by_plant   
	WHERE ReportCode=@ReportCode AND [Year] BETWEEN @Year_s AND @Year_e AND Plant=@Plant  
	 GROUP BY [Year]
	ELSE
	select [Year],ISNULL(SUM(Scrap_sqft),0) AS Scrap_sqft,ISNULL(SUM(FGin_sqft),0) AS FGin_sqft,ISNULL(SUM(Yield_Percentage),0) AS Yield_Percentage from KOI_Yearly_Yield_trend_by_plant   
	WHERE ReportCode=@ReportCode AND [Year] BETWEEN @Year_s AND @Year_e AND Plant=@Plant  
	 GROUP BY [Year]

END













GO
