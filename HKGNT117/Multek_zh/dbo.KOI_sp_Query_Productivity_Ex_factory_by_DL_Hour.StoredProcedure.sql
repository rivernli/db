USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[KOI_sp_Query_Productivity_Ex_factory_by_DL_Hour]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[KOI_sp_Query_Productivity_Ex_factory_by_DL_Hour]
	@Report VARCHAR(20)=NULL, 
	@Year_s VARCHAR(10)=NULL,
	@Year_e VARCHAR(10)=NULL,
	@M_s VARCHAR(5)=NULL,
	@M_e VARCHAR(5)=NULL,
	@Plant VARCHAR(20)=NULL 

AS
SET NOCOUNT ON 

DECLARE @sqlstring NVARCHAR(MAX), @QuertString NVARCHAR(MAX), @PeriodString NVARCHAR(MAX) 

SET @Plant=(CASE @Plant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' ELSE @Plant END)

IF @Report='Yearly'
	BEGIN 
		--Yearly
		SET @QuertString = ' AND [Year] BETWEEN '''+@Year_s+''' AND '''+@Year_e+''' '; 
		IF @Plant = 'Allexclude2F' 
			 SET @QuertString = @QuertString+' AND (Plant=''P2'' OR Plant=''B3'' OR Plant=''B4'') '; 
		 ELSE 
		IF @Plant = 'All' 
			 SET @QuertString = @QuertString+' AND (Plant=''P2'' OR Plant=''2F'' OR Plant=''B3'' OR Plant=''B4'')' ; 
		 ELSE
		IF @Plant <> 'All' 
			  SET @QuertString = @QuertString+' AND Plant='''+@Plant+'''' ; 

		EXEC('select ''FY''+[Year] as [Year],
		SUM(M1+M2+M3+M4+M5+M6+M7+M8+M9+M10+M11+M12) AS Efficiency 
		 from (
		SELECT [Year],
			(CASE (SELECT ISNULL(SUM(WorkingHours),0) FROM KOI_InputByHR WHERE Period=''1'' AND KOI_InputByHR.Plant=(CASE DistribitionReport.Plant WHEN ''P2'' THEN ''B1'' WHEN ''2F'' THEN ''B2F'' ELSE DistribitionReport.Plant END) AND Financey=[Year]) WHEN 0 THEN 0	
			ELSE M1/(SELECT ISNULL(SUM(WorkingHours),0) FROM KOI_InputByHR WHERE  Period=''1'' AND KOI_InputByHR.Plant=(CASE DistribitionReport.Plant WHEN ''P2'' THEN ''B1'' WHEN ''2F'' THEN ''B2F'' ELSE DistribitionReport.Plant END) AND Financey=[Year]) 
			END) AS M1,
			(CASE (SELECT ISNULL(SUM(WorkingHours),0) FROM KOI_InputByHR WHERE Period=''2'' AND KOI_InputByHR.Plant=(CASE DistribitionReport.Plant WHEN ''P2'' THEN ''B1'' WHEN ''2F'' THEN ''B2F'' ELSE DistribitionReport.Plant END) AND Financey=[Year]) WHEN 0 THEN 0	
			ELSE M2/(SELECT ISNULL(SUM(WorkingHours),0) FROM KOI_InputByHR WHERE  Period=''2'' AND KOI_InputByHR.Plant=(CASE DistribitionReport.Plant WHEN ''P2'' THEN ''B1'' WHEN ''2F'' THEN ''B2F'' ELSE DistribitionReport.Plant END) AND Financey=[Year]) 
			END) AS M2,
			(CASE (SELECT ISNULL(SUM(WorkingHours),0) FROM KOI_InputByHR WHERE Period=''3'' AND KOI_InputByHR.Plant=(CASE DistribitionReport.Plant WHEN ''P2'' THEN ''B1'' WHEN ''2F'' THEN ''B2F'' ELSE DistribitionReport.Plant END) AND Financey=[Year]) WHEN 0 THEN 0	
			ELSE M3/(SELECT ISNULL(SUM(WorkingHours),0) FROM KOI_InputByHR WHERE  Period=''3'' AND KOI_InputByHR.Plant=(CASE DistribitionReport.Plant WHEN ''P2'' THEN ''B1'' WHEN ''2F'' THEN ''B2F'' ELSE DistribitionReport.Plant END) AND Financey=[Year]) 
			END) AS M3,
			(CASE (SELECT ISNULL(SUM(WorkingHours),0) FROM KOI_InputByHR WHERE Period=''4'' AND KOI_InputByHR.Plant=(CASE DistribitionReport.Plant WHEN ''P2'' THEN ''B1'' WHEN ''2F'' THEN ''B2F'' ELSE DistribitionReport.Plant END) AND Financey=[Year]) WHEN 0 THEN 0	
			ELSE M4/(SELECT ISNULL(SUM(WorkingHours),0) FROM KOI_InputByHR WHERE  Period=''4'' AND KOI_InputByHR.Plant=(CASE DistribitionReport.Plant WHEN ''P2'' THEN ''B1'' WHEN ''2F'' THEN ''B2F'' ELSE DistribitionReport.Plant END) AND Financey=[Year]) 
			END) AS M4,
			(CASE (SELECT ISNULL(SUM(WorkingHours),0) FROM KOI_InputByHR WHERE Period=''5'' AND KOI_InputByHR.Plant=(CASE DistribitionReport.Plant WHEN ''P2'' THEN ''B1'' WHEN ''2F'' THEN ''B2F'' ELSE DistribitionReport.Plant END) AND Financey=[Year]) WHEN 0 THEN 0
			ELSE M5/(SELECT ISNULL(SUM(WorkingHours),0) FROM KOI_InputByHR WHERE  Period=''5'' AND KOI_InputByHR.Plant=(CASE DistribitionReport.Plant WHEN ''P2'' THEN ''B1'' WHEN ''2F'' THEN ''B2F'' ELSE DistribitionReport.Plant END) AND Financey=[Year])  
			END) AS M5,
			(CASE (SELECT ISNULL(SUM(WorkingHours),0) FROM KOI_InputByHR WHERE Period=''6'' AND KOI_InputByHR.Plant=(CASE DistribitionReport.Plant WHEN ''P2'' THEN ''B1'' WHEN ''2F'' THEN ''B2F'' ELSE DistribitionReport.Plant END) AND Financey=[Year]) WHEN 0 THEN 0
			ELSE M6/(SELECT ISNULL(SUM(WorkingHours),0) FROM KOI_InputByHR WHERE  Period=''6'' AND KOI_InputByHR.Plant=(CASE DistribitionReport.Plant WHEN ''P2'' THEN ''B1'' WHEN ''2F'' THEN ''B2F'' ELSE DistribitionReport.Plant END) AND Financey=[Year]) 
			END) AS M6,
			(CASE (SELECT ISNULL(SUM(WorkingHours),0) FROM KOI_InputByHR WHERE Period=''7'' AND KOI_InputByHR.Plant=(CASE DistribitionReport.Plant WHEN ''P2'' THEN ''B1'' WHEN ''2F'' THEN ''B2F'' ELSE DistribitionReport.Plant END) AND Financey=[Year]) WHEN 0 THEN 0
			ELSE M7/(SELECT ISNULL(SUM(WorkingHours),0) FROM KOI_InputByHR WHERE  Period=''7'' AND KOI_InputByHR.Plant=(CASE DistribitionReport.Plant WHEN ''P2'' THEN ''B1'' WHEN ''2F'' THEN ''B2F'' ELSE DistribitionReport.Plant END) AND Financey=[Year]) 
			END) AS M7,
			(CASE (SELECT ISNULL(SUM(WorkingHours),0) FROM KOI_InputByHR WHERE Period=''8'' AND KOI_InputByHR.Plant=(CASE DistribitionReport.Plant WHEN ''P2'' THEN ''B1'' WHEN ''2F'' THEN ''B2F'' ELSE DistribitionReport.Plant END) AND Financey=[Year]) WHEN 0 THEN 0
			ELSE M8/(SELECT ISNULL(SUM(WorkingHours),0) FROM KOI_InputByHR WHERE  Period=''8'' AND KOI_InputByHR.Plant=(CASE DistribitionReport.Plant WHEN ''P2'' THEN ''B1'' WHEN ''2F'' THEN ''B2F'' ELSE DistribitionReport.Plant END) AND Financey=[Year]) 
			END) AS M8,
			(CASE (SELECT ISNULL(SUM(WorkingHours),0) FROM KOI_InputByHR WHERE Period=''9'' AND KOI_InputByHR.Plant=(CASE DistribitionReport.Plant WHEN ''P2'' THEN ''B1'' WHEN ''2F'' THEN ''B2F'' ELSE DistribitionReport.Plant END) AND Financey=[Year]) WHEN 0 THEN 0
			ELSE M9/(SELECT ISNULL(SUM(WorkingHours),0) FROM KOI_InputByHR WHERE  Period=''9'' AND KOI_InputByHR.Plant=(CASE DistribitionReport.Plant WHEN ''P2'' THEN ''B1'' WHEN ''2F'' THEN ''B2F'' ELSE DistribitionReport.Plant END) AND Financey=[Year]) 
			END) AS M9,
			(CASE (SELECT ISNULL(SUM(WorkingHours),0) FROM KOI_InputByHR WHERE Period=''10'' AND KOI_InputByHR.Plant=(CASE DistribitionReport.Plant WHEN ''P2'' THEN ''B1'' WHEN ''2F'' THEN ''B2F'' ELSE DistribitionReport.Plant END) AND Financey=[Year]) WHEN 0 THEN 0 
			ELSE M10/(SELECT ISNULL(SUM(WorkingHours),0) FROM KOI_InputByHR WHERE  Period=''10'' AND KOI_InputByHR.Plant=(CASE DistribitionReport.Plant WHEN ''P2'' THEN ''B1'' WHEN ''2F'' THEN ''B2F'' ELSE DistribitionReport.Plant END) AND Financey=[Year]) 
			END) AS M10,
			(CASE (SELECT ISNULL(SUM(WorkingHours),0) FROM KOI_InputByHR WHERE Period=''11'' AND KOI_InputByHR.Plant=(CASE DistribitionReport.Plant WHEN ''P2'' THEN ''B1'' WHEN ''2F'' THEN ''B2F'' ELSE DistribitionReport.Plant END) AND Financey=[Year]) WHEN 0 THEN 0 
			ELSE M11/(SELECT ISNULL(SUM(WorkingHours),0) FROM KOI_InputByHR WHERE  Period=''11'' AND KOI_InputByHR.Plant=(CASE DistribitionReport.Plant WHEN ''P2'' THEN ''B1'' WHEN ''2F'' THEN ''B2F'' ELSE DistribitionReport.Plant END) AND Financey=[Year]) 
			END) AS M11,
			(CASE (SELECT ISNULL(SUM(WorkingHours),0) FROM KOI_InputByHR WHERE Period=''12'' AND KOI_InputByHR.Plant=(CASE DistribitionReport.Plant WHEN ''P2'' THEN ''B1'' WHEN ''2F'' THEN ''B2F'' ELSE DistribitionReport.Plant END) AND Financey=[Year]) WHEN 0 THEN 0 
			ELSE M12/(SELECT ISNULL(SUM(WorkingHours),0) FROM KOI_InputByHR WHERE  Period=''12'' AND KOI_InputByHR.Plant=(CASE DistribitionReport.Plant WHEN ''P2'' THEN ''B1'' WHEN ''2F'' THEN ''B2F'' ELSE DistribitionReport.Plant END) AND Financey=[Year]) 
			END) AS M12 
		 FROM hkgnt111.Multek_SZ_New.dbo.DistribitionReport_Amount_Fiscal DistribitionReport
		 WHERE ReportCode=''001'' 
			   AND [Type]=''Shipment'' 
			   AND Site=''Chi''  '+@QuertString+' ) YearTemp group by [Year] ')

	END

IF @Report='Quarterly'
	BEGIN 
		--Quarterly		
		--SET @PeriodString = (CASE @Plant WHEN 'B1' THEN 'Period BETWEEN 1 and 3' WHEN '2' THEN 'Period BETWEEN 4 and 6' WHEN '3' THEN 'Period BETWEEN 7 and 9' WHEN '4' THEN 'Period BETWEEN 10 and 12' END)

		SET @QuertString = ' AND CONVERT(VARCHAR,[Year])+right(100+REPLACE(Quarterly,''M'',''''),2) BETWEEN '''+@Year_s+@M_s+''' AND '''+@Year_e+@M_e+''' '; 
		IF @Plant = 'Allexclude2F' 
			 SET @QuertString = @QuertString+' AND (Plant=''P2'' OR Plant=''B3'' OR Plant=''B4'') '; 
		 ELSE 
		IF @Plant = 'All' 
			 SET @QuertString = @QuertString+' AND (Plant=''P2'' OR Plant=''2F'' OR Plant=''B3'' OR Plant=''B4'')' ; 
		 ELSE
		IF @Plant <> 'All' 
			  SET @QuertString = @QuertString+' AND Plant='''+@Plant+'''' ; 

		SET @sqlstring ='
		SELECT IDENTITY(INT,1,1) AS [ID],Quarterly*4/13 AS Q,*
		INTO #temp
		from (
		select [Year],[YearMonth],Quarterly, 
		SUM(Efficiency) AS Efficiency 
		 from (		
		SELECT [Year],[Year]+''.''+right(100+REPLACE(Quarterly,''M'',''''),2) as [YearMonth],REPLACE(Quarterly,''M'','''') as Quarterly,
		(CASE (SELECT ISNULL(SUM(WorkingHours),0) FROM KOI_InputByHR WHERE KOI_InputByHR.Plant=(CASE unpvt.Plant WHEN ''P2'' THEN ''B1'' WHEN ''2F'' THEN ''B2F'' ELSE unpvt.Plant END) AND Period=REPLACE(Quarterly,''M'','''') AND Financey=[Year]) WHEN 0 THEN 0	
		ELSE FGOut/(SELECT ISNULL(SUM(WorkingHours),0) FROM KOI_InputByHR WHERE KOI_InputByHR.Plant=(CASE unpvt.Plant WHEN ''P2'' THEN ''B1'' WHEN ''2F'' THEN ''B2F'' ELSE unpvt.Plant END) AND Period=REPLACE(Quarterly,''M'','''') AND Financey=[Year])
		END) AS Efficiency  
		 from hkgnt111.Multek_SZ_New.dbo.DistribitionReport_Amount_Fiscal 
		unpivot 
		(
		FGOut for Quarterly in (M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12) 
		)
		as unpvt
		WHERE ReportCode=''001'' AND Type=''Shipment''
		 AND Site=''Chi'' '+@QuertString+') YearTemp group by [Year],[YearMonth],Quarterly ) Reporttemp ;
		select ''FY''+[Year]+''.''+convert(varchar(5),right(100+Q+1,2)) AS [Year],Sum(Efficiency) AS Efficiency from #temp group by [Year],Q order by [Year],Q ASC '

		exec(@sqlstring)
	END

IF @Report='Monthly'
	BEGIN 
		--Period
		SET @QuertString = ' AND CONVERT(VARCHAR,[Year])+right(100+REPLACE(Quarterly,''M'',''''),2) BETWEEN '''+@Year_s+@M_s+''' AND '''+@Year_e+@M_e+''' '; 
		IF @Plant = 'Allexclude2F' 
			 SET @QuertString = @QuertString+' AND (Plant=''P2'' OR Plant=''B3'' OR Plant=''B4'') '; 
		 ELSE 
		IF @Plant = 'All' 
			 SET @QuertString = @QuertString+' AND (Plant=''P2'' OR Plant=''2F'' OR Plant=''B3'' OR Plant=''B4'')' ; 
		 ELSE
		IF @Plant <> 'All' 
			  SET @QuertString = @QuertString+' AND Plant='''+@Plant+'''' ; 
		SET @sqlstring ='select [Year],
		SUM(Efficiency) AS Efficiency 
		 from ( 
		SELECT ''FY''+[Year]+''.''+right(100+REPLACE(Quarterly,''M'',''''),2) as [Year], 
		(CASE (SELECT ISNULL(SUM(WorkingHours),0) FROM KOI_InputByHR WHERE KOI_InputByHR.Plant=(CASE unpvt.Plant WHEN ''P2'' THEN ''B1'' WHEN ''2F'' THEN ''B2F'' ELSE unpvt.Plant END) AND Period=REPLACE(Quarterly,''M'','''') AND Financey=[Year]) WHEN 0 THEN 0	
		ELSE FGOut/(SELECT ISNULL(SUM(WorkingHours),0) FROM KOI_InputByHR WHERE KOI_InputByHR.Plant=(CASE unpvt.Plant WHEN ''P2'' THEN ''B1'' WHEN ''2F'' THEN ''B2F'' ELSE unpvt.Plant END) AND Period=REPLACE(Quarterly,''M'','''') AND Financey=[Year])
		END) AS Efficiency  
		from hkgnt111.Multek_SZ_New.dbo.DistribitionReport_Amount_Fiscal 
		unpivot 
		(
		FGOut for Quarterly in (M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12) 
		)
		as unpvt
		WHERE ReportCode=''001'' AND Type=''Shipment''
		 AND Site=''Chi'' '+@QuertString+') YearTemp group by [Year] '
	exec(@sqlstring) 
	END 








GO
