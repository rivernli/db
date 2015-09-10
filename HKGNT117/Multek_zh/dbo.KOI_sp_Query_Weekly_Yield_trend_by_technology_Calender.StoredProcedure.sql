USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[KOI_sp_Query_Weekly_Yield_trend_by_technology_Calender]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
create PROCEDURE [dbo].[KOI_sp_Query_Weekly_Yield_trend_by_technology_Calender] 
	@Year_s VARCHAR(4),
	@Year_e VARCHAR(4),
	@Plant NVARCHAR(50),
	@technology NVARCHAR(50),
	@Unit VARCHAR(10)
AS

BEGIN
	SET NOCOUNT ON;
	DECLARE @sql NVARCHAR(MAX),@QuertString NVARCHAR(MAX) 

	SELECT T$ITEM INTO #TMP_Item FROM FactoryLoading.dbo.TFIATT006180 
	WHERE T$ATTR='type' AND T$ASTR IN (SELECT Technology FROM KOI_Technology_mapping WHERE Group_display=@technology) 

	IF @Plant='All'
		BEGIN
		SET @QuertString = ' AND T$PLNT<>''HK'' AND T$PLNT<>''12'' '
		END
	ELSE 
	IF @Plant='Allexclude2F'
		BEGIN
		SET @QuertString=' AND T$PLNT<>''HK'' AND T$PLNT<>''12'' and T$PLNT<>''2F'' '
		END
	ELSE 
		BEGIN
		SET @QuertString=' AND T$PLNT=(case '''+@Plant+''' WHEN ''B1'' THEN ''P2'' WHEN ''B2F'' THEN ''2F'' ELSE '''+@Plant+''' end) '
		END

set @sql='select CONVERT(VARCHAR,[Year])+''.''+CONVERT(VARCHAR,right(100+calenderWeek,2)) AS [Year],
ISNULL(CASE Yield_Percentage WHEN 0 THEN 0 ELSE FGin_sqft*(1-Yield_Percentage)/Yield_Percentage END,0) as Scrap_sqft,
FGin_sqft,ISNULL(Yield_Percentage,0) as Yield_Percentage
 from 
(
SELECT 
CalenderYear as [Year],calenderWeek,
(SELECT ISNULL(SUM('+@Unit+'),0) from TFSOLP107180 
WHERE T$ITEM IN (SELECT * FROM #TMP_Item) '+@QuertString+' AND T$Date BETWEEN CalenderDateFrom AND CalenderDateTo) as FGin_sqft,

(select CASE SUM(Ydas_Yied) WHEN ''0'' THEN ''0'' ELSE ISNULL(SUM(T$YDAS)/SUM(Ydas_Yied),0) END from 
(
	(
		SELECT CASE ISNULL(T$YIED,0) WHEN ''0'' THEN ''0''  ELSE ISNULL(T$YDAS/T$YIED,0) END as Ydas_Yied, ISNULL(T$YDAS,0) as T$YDAS 
		from TFSOLP108180 		
		where T$PRDT IN (SELECT * FROM #TMP_Item) AND T$OUDT BETWEEN CalenderDateFrom and CalenderDateTo AND T$YIED<>0 AND T$PLNT='''+@Plant+'''
	) 
) a) Yield_Percentage

FROM vw_KOI_Calender_Week 
WHERE CalenderYear between '''+@Year_s+''' AND '''+@Year_e+'''
GROUP BY CalenderYear,calenderWeek,CalenderDateFrom, CalenderDateTo  
) tb ORDER BY Year,calenderWeek  '

EXEC(@sql) 

END


GO
