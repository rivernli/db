USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[KOI_sp_Query_Daily_DPPM_By_Unit]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[KOI_sp_Query_Daily_DPPM_By_Unit] 
	@ReportCode VARCHAR(20),
	@Date_s VARCHAR(10),
	@Date_e VARCHAR(10),
	@Plant NVARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @QueryString NVARCHAR(max) 
	SET @Plant=(CASE @Plant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' ELSE @Plant END)	
	

	--FY
--	IF @ReportCode='001'
--	BEGIN
		IF @Plant='All'
			BEGIN							
				select CONVERT(varchar(10),a.T$DATE,120) as  [Year],CASE ISNULL(SUM(a.T$DQUA),0) WHEN 0 THEN 0 ELSE ISNULL(SUM(b.T$OQTY),0)/ISNULL(SUM(a.T$DQUA),0)*cast(power(10,6) as bigint) END as Unit
				 from V_VWFSOLP105180 a
				 INNER JOIN V_VWFSOLP109180 b ON a.T$PLNT=b.Plant 
				 WHERE (a.T$PLNT='B1' OR a.T$PLNT='2F' OR a.T$PLNT='B3' OR a.T$PLNT='B4' OR a.T$PLNT='B5') 
				 AND (a.T$Date BETWEEN @Date_s AND @Date_e
				 OR a.T$HKDT BETWEEN @Date_s AND @Date_e )
				 AND b.T$Date BETWEEN @Date_s AND @Date_e group by a.T$DATE
			END
		ELSE 
			IF @Plant='Allexclude2F'
			BEGIN								
				select CONVERT(varchar(10),a.T$DATE,120) as  [Year],CASE ISNULL(SUM(a.T$DQUA),0) WHEN 0 THEN 0 ELSE ISNULL(SUM(b.T$OQTY),0)/ISNULL(SUM(a.T$DQUA),0)*cast(power(10,6) as bigint) END as Unit
				 from V_VWFSOLP105180 a
				 INNER JOIN V_VWFSOLP109180 b ON a.T$PLNT=b.Plant 
				 WHERE (a.T$PLNT='B1' OR a.T$PLNT='B3' OR a.T$PLNT='B4' OR a.T$PLNT='B5') 
				 AND (a.T$Date BETWEEN @Date_s AND @Date_e
				 OR a.T$HKDT BETWEEN @Date_s AND @Date_e )
				 AND b.T$Date BETWEEN @Date_s AND @Date_e  group by a.T$DATE
			END
			ELSE
			BEGIN		
				select CONVERT(varchar(10),a.T$DATE,120) as  [Year],CASE ISNULL(SUM(a.T$DQUA),0) WHEN 0 THEN 0 ELSE ISNULL(SUM(b.T$OQTY),0)/ISNULL(SUM(a.T$DQUA),0)*cast(power(10,6) as bigint) END as Unit
				 from V_VWFSOLP105180 a
				INNER JOIN V_VWFSOLP109180 b ON a.T$PLNT=b.Plant 
				 WHERE a.T$PLNT = @Plant 
				 AND (a.T$Date BETWEEN @Date_s AND @Date_e
				 OR a.T$HKDT BETWEEN @Date_s AND @Date_e )
				 AND b.T$Date BETWEEN @Date_s AND @Date_e group by a.T$DATE
			END

		
--	END
	--Calender
--	IF @ReportCode='002'
--	BEGIN
--		select CONVERT(varchar(10),T$DATE,120) as  [Year],
--		Unit=(CASE (SELECT ABS(ISNULL(SUM(T$DQUA),0)) FROM V_VWFSOLP105180 WHERE  T$PLNT = @Plant 
--		AND (T$Date = @Date OR T$HKDT = @Date)) WHEN 0 THEN 0	
--		ELSE (SELECT ABS(ISNULL(SUM(T$OQTY),0)) FROM V_VWFSOLP109180 WHERE  Plant = @Plant
--		AND T$Date = @Date)/
--		(SELECT ABS(ISNULL(SUM(T$DQUA),0)) FROM V_VWFSOLP105180 WHERE  T$PLNT = @Plant
--		AND T$Date = @Date)
--		END)*cast(power(10,6) as bigint)  
--	END

--select CONVERT(varchar(10),T$DATE,120) as  [Year],
--				Unit=(CASE (SELECT ABS(ISNULL(SUM(T$DQUA),0)) FROM V_VWFSOLP105180 WHERE  T$PLNT = @Plant 
--				AND (T$Date BETWEEN @Date_s AND @Date_e OR T$HKDT BETWEEN @Date_s AND @Date_e )) WHEN 0 THEN 0	
--				ELSE (SELECT ABS(ISNULL(SUM(T$OQTY),0)) FROM V_VWFSOLP109180 WHERE  Plant = @Plant
--				AND T$Date BETWEEN @Date_s AND @Date_e)/
--				(SELECT ABS(ISNULL(SUM(T$DQUA),0)) FROM V_VWFSOLP105180 WHERE  T$PLNT = @Plant
--				AND (T$Date BETWEEN @Date_s AND @Date_e OR T$HKDT BETWEEN @Date_s AND @Date_e ))
--				END)*cast(power(10,6) as bigint)  
END






GO
