USE [Multek_ZH_New]
GO
/****** Object:  StoredProcedure [dbo].[sp_MRBST_Sycn_TargetLine]    Script Date: 11/06/2014 15:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_MRBST_Sycn_TargetLine]
AS	
	INSERT INTO MRBST_TargetLine(PeriodDesc,FOC,TL,[BaseLineDollar],[TargetLineDollar],[BaseLineSqft],[TargetLineSqft],[BaseLineInSqft],[TargetLineInSqft],[BaseLineOut],[TargetLineOut],[BaseLineIn],[TargetLineIn])
	SELECT *,0,0,0,0,0,0,0,0,0,0 FROM (
		SELECT FiscalPeriodDesc PeriodDesc, 'Fiscal' FOC, 'Monthly' TL FROM MRBST_Calender 
			WHERE FiscalYear > 2007 GROUP BY FiscalPeriodDesc
		UNION ALL 
		SELECT FiscalQuarterDesc, 'Fiscal', 'Quarterly' FROM MRBST_Calender 
			WHERE FiscalYear > 2007 GROUP BY FiscalQuarterDesc
		UNION ALL 
		SELECT FiscalYearDesc, 'Fiscal', 'Yearly' FROM MRBST_Calender 
			WHERE FiscalYear > 2007 GROUP BY FiscalYearDesc
		UNION ALL
		SELECT CAST(CalenderYear AS VARCHAR) , 'Calendar', 'Yearly' FROM MRBST_Calender 
			WHERE CalenderYear > 2007 GROUP BY CalenderYear
		UNION ALL 
		SELECT CalenderQuarterDesc, 'Calendar', 'Quarterly' FROM MRBST_Calender 
			WHERE CalenderYear > 2007 GROUP BY CalenderQuarterDesc
		UNION ALL
		SELECT CalenderMonthDesc, 'Calendar', 'Monthly' FROM MRBST_Calender 
			WHERE CalenderYear > 2007 GROUP BY CalenderMonthDesc
		UNION ALL 
		SELECT SuggestionString, 'Technology', 'Technology' FROM MRBST_Suggestion WHERE SuggestionType = 'Technology'
	) AS A WHERE NOT EXISTS(SELECT * FROM MRBST_TargetLine WHERE PeriodDesc=A.PeriodDesc AND FOC=A.FOC AND TL=A.TL) 
	ORDER BY FOC, PeriodDesc
GO
