USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[KOI_sp_Query_Quarterly_Attrition_rate_vs_MRB_rate]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 

create PROCEDURE [dbo].[KOI_sp_Query_Quarterly_Attrition_rate_vs_MRB_rate] 
	@ReportCode VARCHAR(3),
	@Year_s VARCHAR(10),
	@Year_e VARCHAR(10),
	@Plant NVARCHAR(50) 
AS
BEGIN
	SET NOCOUNT ON;

	IF @ReportCode='001'
		select 'FY'+[Year]+'.'+CONVERT(VARCHAR,right(100+Quarter,2)) as [Year],ISNULL(SUM(Attrition_Rate),0) AS Attrition_Rate,ISNULL(SUM(MRB_rate),0) AS MRB_rate 
		from KOI_Quarterly_Attrition_rate_vs_MRB_rate  
		WHERE ReportCode=@ReportCode AND CONVERT(VARCHAR,[Year])+right(100+Quarter,2) BETWEEN @Year_s AND @Year_e AND Plant=@Plant 
		GROUP BY [Year],Quarter 
	ELSE 
		select [Year]+'.'+CONVERT(VARCHAR,right(100+Quarter,2)) as [Year],ISNULL(SUM(Attrition_Rate),0) AS Attrition_Rate,ISNULL(SUM(MRB_rate),0) AS MRB_rate 
		from KOI_Quarterly_Attrition_rate_vs_MRB_rate  
		WHERE ReportCode=@ReportCode AND CONVERT(VARCHAR,[Year])+right(100+Quarter,2) BETWEEN @Year_s AND @Year_e AND Plant=@Plant  
		GROUP BY [Year],Quarter 
END

 
GO
