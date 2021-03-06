USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[KOI_sp_Query_Target]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 

CREATE PROCEDURE [dbo].[KOI_sp_Query_Target] 
	@Report VARCHAR(10), 
	@Year_s VARCHAR(10),
	@Year_e VARCHAR(10),
	@Plant NVARCHAR(50),
	@Sale NVARCHAR(50)
AS
BEGIN	
	SET @Plant = (select CASE @Plant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' ELSE @Plant END)
	SET @Sale = (select CASE @Sale WHEN 'FGIn' THEN 'Output' WHEN 'FGOut' THEN 'Shipment' WHEN 'Invoice' THEN 'Outbound' END)
	
	IF @Report='Yearly'	
	BEGIN
		select [Year],ISNULL(SUM(M1+M2+M3+M4+M5+M6+M7+M8+M9+M10+M11+M12),0) AS Target from V_VW_DistributionReport_Forecast 
		where [Site]='Chi' AND [Year] BETWEEN @Year_s AND @Year_e AND Plant=@Plant AND [Type]=@Sale 
		GROUP BY [Year] 
	END	

	IF @Report='Quarterly'	
	BEGIN

		SELECT Quarterly*4/13 AS Q,* INTO #Target_Q_temp
		from (
		select [Year],[YearMonth],Quarterly, 
		ISNULL(SUM(Target),0) AS Target 
		 from (		
		SELECT [Year],[Year]+'.'+right(100+REPLACE(Quarterly,'M',''),2) as [YearMonth],REPLACE(Quarterly,'M','') as Quarterly,
		Target 
		 from V_VW_DistributionReport_Forecast
		unpivot 
		(
		Target for Quarterly in (M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12) 
		)
		as unpvt
		WHERE [Site]='Chi' AND CONVERT(VARCHAR,[Year])+right(100+REPLACE(Quarterly,'M',''),2) BETWEEN @Year_s AND @Year_e 
		  AND Plant=@Plant AND [Type]=@Sale ) 
		YearTemp group by [Year],[YearMonth],Quarterly ) T_Q_temp 

		select [Year]+'.'+CONVERT(VARCHAR,right(100+Q+1,2)) AS [Year],Sum(Target) AS Target from #Target_Q_temp 
		where [Year]+CONVERT(VARCHAR,right(100+Q+1,2)) BETWEEN @Year_s AND @Year_e  
		group by [Year],Q order by [Year],Q ASC 

	END

	IF @Report='Monthly'	
	BEGIN

		select [Year],CONVERT(VARCHAR,right(100+Quarterly,2)), 
		ISNULL(SUM(Target),0) AS Target 
		 from (		
		SELECT [Year],REPLACE(Quarterly,'M','') as Quarterly,
		Target 
		 from V_VW_DistributionReport_Forecast
		unpivot 
		(
		Target for Quarterly in (M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12) 
		)
		as unpvt
		WHERE [Site]='Chi' AND CONVERT(VARCHAR,[Year])+right(100+REPLACE(Quarterly,'M',''),2) BETWEEN @Year_s AND @Year_e 
		  AND Plant=@Plant AND [Type]=@Sale ) 
		YearTemp group by [Year],Quarterly order by [Year] ASC ,Quarterly ASC 

	END


END
GO
