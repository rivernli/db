USE [multekChi_Realtime]
GO
/****** Object:  StoredProcedure [dbo].[Plant_Forecasting_and_Daily_Bookings_Review_Request_by_Alan]    Script Date: 11/06/2014 15:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Plant_Forecasting_and_Daily_Bookings_Review_Request_by_Alan]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	--GET Final result
		IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('tempdb.#Result') AND TYPE = 'U')
			DROP TABLE #Result

		CREATE TABLE #Result
		(
			PLANT			VARCHAR(5),
			OEM				VARCHAR(30),
			SHIPCUS			VARCHAR(35),
			SALESMAN		VARCHAR(30),
			fFORECAST		DECIMAL(18,0),
			fQTDShipment	DECIMAL(18,0),
			fBacklog		DECIMAL(18,0),
			forder			DECIMAL(18,0),
			fDelta			DECIMAL(18,0),
			sFORECAST		DECIMAL(18,0),
			sTDShipment		DECIMAL(18,0),
			sBacklog		DECIMAL(18,0),
			sorder			DECIMAL(18,0),
			sDelta			DECIMAL(18,0),
			tFORECAST		DECIMAL(18,0),
			tQTDShipment	DECIMAL(18,0),
			tBacklog		DECIMAL(18,0),
			torder			DECIMAL(18,0),
			tDelta			DECIMAL(18,0),
			FORECAST		DECIMAL(18,0),
			QTDShipment		DECIMAL(18,0),
			Backlog			DECIMAL(18,0),
			oorder			DECIMAL(18,0),
			Delta			DECIMAL(18,0),
		)

	-- GET SHIPMENT DATA
		IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('tempdb.#tempShipment') AND TYPE = 'U')
			DROP TABLE #tempShipment

		SELECT	PLANT,
				[OEM NAME],
				SHCUSTNAME,
				SALESMAN,
				--(
				--	SELECT FORECAST FROM
				--	(
				--		SELECT PLANT ,MONTH,FORECAST 
				--		FROM 
				--		(
				--			SELECT PLANT,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12 
				--			FROM [MULTEK_SZ_NEW].[DBO].[DISTRIBUTIONREPORT_FORECAST] 
				--			WHERE TYPE = 'SHIPMENT' 
				--			AND YEAR = B.FISCALYEAR 
				--			AND PLANT = A.PLANT
				--		) P
				--		UNPIVOT
				--		(
				--			FORECAST FOR MONTH IN
				--			(M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12)
				--		) AS UNPVT
				--	) T1
				--	WHERE MONTH = 'M'+CAST(B.FiscalPeriod AS VARCHAR)
				--) AS FORCAST,
				SHDOLS_LOC AS QTD_SHIPMENT,
				0 AS BACKLOG,
				SHDATE,
				FISCALYEAR,
				FISCALPERIOD,
				FISCALQUARTER
				INTO #tempShipment
		FROM [DBO].[VCR_SHIPPED_ALL_CHINA] AS A LEFT JOIN [MULTEK_SZ_NEW].[DBO].[CALENDAR] AS B ON A.SHDATE = CONVERT(VARCHAR(10),B.CALENDERDATE,120)
		WHERE SHDATE BETWEEN 
		(
			SELECT FISCALQUARTERFROM  FROM [MULTEK_SZ_NEW].[DBO].[CALENDAR] WHERE CALENDERDATE = CONVERT(VARCHAR(10),GETDATE(),120)
		)
		AND
		(
			SELECT FISCALQUARTERTO  FROM [MULTEK_SZ_NEW].[DBO].[CALENDAR] WHERE CALENDERDATE = CONVERT(VARCHAR(10),GETDATE(),120)
		)

	-- GET backlog DATA
		IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('tempdb.#tempBacklog') AND TYPE = 'U')
			DROP TABLE #tempBacklog

		SELECT B.T$PLNT,A.T$ECDT,T$CUNM,A.T$NAMA,SUM(T$AMNT) AS T$AMNT
		INTO #tempBacklog
		FROM [HKGNT117].[MULTEKCHI_REALTIME].[DBO].[VW_TFSOLP100180] A INNER JOIN
                      [HKGNT117].[MULTEKCHI_REALTIME].[DBO].[TFSCPP201180] AS B ON A.T$CWAR = B.T$CWAR
		GROUP BY B.T$PLNT,A.T$ECDT,T$CUNM,A.T$NAMA

	-- GET FORECAST DATA
		IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('tempdb.#tempForecast') AND TYPE = 'U')
			DROP TABLE #tempForecast

		SELECT * INTO #tempForecast FROM
		(
			SELECT PLANT ,MONTH,FORECAST 
			FROM 
			(
				SELECT PLANT,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12 
				FROM [MULTEK_SZ_NEW].[DBO].[DISTRIBUTIONREPORT_FORECAST] 
				WHERE TYPE = 'SHIPMENT' 
				AND YEAR = (SELECT FISCALYEAR  FROM [MULTEK_SZ_NEW].[DBO].[CALENDAR] WHERE CALENDERDATE = CONVERT(VARCHAR(10),GETDATE(),120))
			) P
			UNPIVOT
			(
				FORECAST FOR MONTH IN
				(M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12)
			) AS UNPVT
		) T1
		

END
GO
