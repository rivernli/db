USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[KOI_sp_Query_Quarterly_Productivity_Image_Layer]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[KOI_sp_Query_Quarterly_Productivity_Image_Layer] 
	@Year_s VARCHAR(10),
	@Year_e VARCHAR(10),	
	@Sale NVARCHAR(50),
	@Plant NVARCHAR(50) 
AS
BEGIN
	SET NOCOUNT ON;

	select 'FY'+[Year]+'.'+CONVERT(VARCHAR,right(100+Quarter,2)) as [Year],
	ISNULL(SUM(WorkingHours),0) AS [DL Working Hours (WH)],ISNULL(SUM(Headcount),0) AS [Headcount(AVE)],ISNULL(SUM(ALC),0) AS ALC,
	ISNULL(SUM(FGOut_sqft),0) AS [FG out (sqft)],ISNULL(SUM(Efficiency),0) AS Efficiency 
	from KOI_Quarterly_Productivity_Image_Layer  
	WHERE CONVERT(VARCHAR,[Year])+right(100+Quarter,2) BETWEEN @Year_s AND @Year_e AND Plant=@Plant AND Sale=@Sale 
	GROUP BY [Year],Quarter 

END












GO
