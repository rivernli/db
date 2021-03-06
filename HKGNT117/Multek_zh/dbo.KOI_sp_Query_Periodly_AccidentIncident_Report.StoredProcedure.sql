USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[KOI_sp_Query_Periodly_AccidentIncident_Report]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 

CREATE PROCEDURE [dbo].[KOI_sp_Query_Periodly_AccidentIncident_Report] 
	@Year_s VARCHAR(50),
	@Year_e VARCHAR(50),
	@Plant NVARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON;

	select 'FY'+[Year]+'.'+CONVERT(VARCHAR,right(100+Period,2)) as [Year],
	ISNULL(SUM(WorkingHours),0) AS WorkingHours,
	ISNULL(SUM(Incident),0) AS Incident,
	ISNULL(SUM(First_aid),0) AS First_aid,
	ISNULL(SUM(Total_Accidents),0) AS Total_Accidents,
	ISNULL(SUM(Recordable_Accidents),0) AS Recordable_Accidents,
	ISNULL(SUM(LWD_Accidents),0) AS LWD_Accidents,
	ISNULL(SUM(Disabled),0) AS Disabled,
	ISNULL(SUM(Fatal),0) AS Fatal,
	ISNULL(SUM(Recordable_Accident_Rate),0) AS Recordable_Accident_Rate,
	ISNULL(SUM(LWD_Accident_Rate),0) AS LWD_Accident_Rate,
	ISNULL(SUM(Lost_Working_Days),0) AS Lost_Working_Days,
	ISNULL(SUM(Medical_Expense),0) AS Medical_Expense,
	ISNULL(SUM(Manpower_Loss),0) AS Manpower_Loss,
	ISNULL(SUM(Total_Loss),0) AS Total_Loss,
	ISNULL(SUM(Total_Loss_per_Case),0) AS Total_Loss_per_Case,
	ISNULL(SUM(Severity_Rate),0) AS Severity_Rate,
	ISNULL(SUM(Injury_Rate_per_200k_WH),0) AS Injury_Rate_per_200k_WH

    from KOI_Periodly_AccidentIncident_Report   
	WHERE  CONVERT(VARCHAR,[Year])+right(100+Period,2) BETWEEN @Year_s AND @Year_e AND Plant=@Plant 
	 GROUP BY [Year],Period 



END






GO
