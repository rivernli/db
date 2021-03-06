USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[KOI_sp_Query_Yearly_Attrition_rate_vs_MRB_rate]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[KOI_sp_Query_Yearly_Attrition_rate_vs_MRB_rate] 
	@ReportCode VARCHAR(3), 
	@Year_s VARCHAR(4),
	@Year_e VARCHAR(4),
	@Plant NVARCHAR(50) 

AS
BEGIN
	SET NOCOUNT ON;
	IF @ReportCode='001'	
		select 'FY'+[Year] as [Year], ISNULL(SUM(Attrition_rate),0) as Attrition_rate, ISNULL(SUM(MRB_rate),0) as MRB_rate from KOI_Yearly_Attrition_rate_vs_MRB_rate  
		WHERE ReportCode=@ReportCode AND [Year] BETWEEN @Year_s AND @Year_e AND Plant=@Plant 
		GROUP BY [Year]
	ELSE 
		select [Year],ISNULL(SUM(Attrition_rate),0) as Attrition_rate, ISNULL(SUM(MRB_rate),0) as MRB_rate from KOI_Yearly_Attrition_rate_vs_MRB_rate   
		WHERE ReportCode=@ReportCode AND [Year] BETWEEN @Year_s AND @Year_e AND Plant=@Plant 
		GROUP BY [Year]
 

END












GO
