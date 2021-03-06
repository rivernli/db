USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[EXR2_New_sp_AUTO_UPDATE_Details_bk0]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		<Author,Rivern Li>
-- Create date: <Create Date,2011-05-07,>
-- Description:	<Description,EXR2 auto update,>
/*
	dbo.TTIITM001180
	dbo.TFSCPP711180
	dbo.TFSBOM400180 
	dbo.TTCMCS044180 
*/
-- =============================================
CREATE PROCEDURE [dbo].[EXR2_New_sp_AUTO_UPDATE_Details_bk0]
	@Period_Start_date	DATETIME,
	@Period_End_date	DATETIME,
	@Operation_Type		NVARCHAR(15)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	SET NOCOUNT ON;
	DECLARE	@Fiscal_Year	NVARCHAR(10)
	DECLARE	@Fiscal_Period	NVARCHAR(5)

	IF @Period_Start_date = 0
		BEGIN
			RAISERROR('Sorry,the start date can not empty',16,1)
			RETURN
		END
	IF @Period_End_date = 0
		BEGIN
			RAISERROR('Sorry,the end date can not empty',16,1)
			RETURN
		END
    -- Used Table or view,make it as CTE table
		---TFSCPP71180----------------------------------------------------------------------------------
		IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#EXR2_Details_new') AND TYPE = 'U')
			DROP TABLE #EXR2_Details_new

		SELECT @Fiscal_Year = FiscalYearDesc, @Fiscal_Period = FiscalPeriodDesc FROM DataWarehouse.dbo.DW_DIM_Calender WHERE calenderDate = @Period_Start_date

		;WITH temp_tfscpp711180(T$PLNT,T$ITEM,T$PRIC,T$TQUA,T$AMNT,T$SQFT) AS 
		(
				SELECT		T$PLNT,
							T$ITEM,
							T$PRIC,
							SUM(T$TQUA)						   AS T$TQUA,
							CAST(SUM(T$AMNT) AS DECIMAL(18,4)) AS T$AMNT,
							CAST(SUM(T$SQFT) AS DECIMAL(18,4)) AS T$SQFT
				FROM		FactoryLoading.dbo.TFSCPP711180 	
				WHERE		T$PLNT <> '2F' AND T$PLNT <> 'HK'
				AND			T$ASDT BETWEEN @Period_Start_date AND @Period_End_date
				GROUP BY	T$PLNT,T$ITEM,T$PRIC
		)
		,	
		---ITEM_MATCH_OEM--------------------------------------------------------------------------------
		ITEM_MATCH_OEM(T$ITEM,T$CSGP,T$DSCA,T$CUPN) AS
		(
			SELECT		A.T$ITEM, 
						--A.T$COPR, 
						B.T$CSGP,
						B.T$DSCA,
						A.T$DSCA
			FROM        FactoryLoading.dbo.TTIITM001180 AS A INNER JOIN
						FactoryLoading.dbo.TTCMCS044180 AS B
						ON A.T$CSGS = B.T$CSGP

		)
		----TFSBOM400180---------------------------------------------------------------------------------
		,CTE_TFSBOM400_Before_Period_End_Date(T$PJNO,T$PLNT,T$SERN,T$CESU,T$CISU,T$TCIU,T$TCUU,T$BUSP) AS 
		(
			SELECT LEFT(A.T$PJNO,9) AS T$PJNO,
						A.T$PLNT,
						MAX(A.T$SERN) AS T$SERN,
						MIN(A.T$CESU) AS T$CESU,
						MIN(A.T$CISU) AS T$CISU,
						MIN(A.T$TCIU) AS T$TCIU,
						MIN(A.T$TCUU) AS T$TCUU,
						CAST(MIN(T$BUSP)/100 AS DECIMAL(18,4)) AS T$BUSP
						--MIN(dbo.EXR2_New_fun_standard_cost(T$PJNO,T$SERN)) AS T$COPR
						--(SELECT TOP 1 B.BOCOS FROM FactoryLoading.dbo.TFSBOM421180_unit AS B WHERE B.t$pjno = A.T$pjno AND B.t$sern = A.T$SERN ) AS T$COPR
			FROM FactoryLoading.dbo.TFSBOM400180  AS A
			WHERE A.T$LCDT < = CAST(@Period_End_date AS DATETIME)
			GROUP BY left(A.t$pjno,9),A.T$PLNT
		)
		,
		CTE_TFSBOM400_After_Period_End_Date(T$PJNO,T$PLNT,T$SERN,T$CESU,T$CISU,T$TCIU,T$TCUU,T$BUSP) AS 
		(
			SELECT LEFT(A.T$PJNO,9) AS T$PJNO,
						A.T$PLNT,
						MIN(A.T$SERN) AS T$SERN,
						MIN(A.T$CESU) AS T$CESU,
						MIN(A.T$CISU) AS T$CISU,
						MIN(A.T$TCIU) AS T$TCIU,
						MIN(A.T$TCUU) AS T$TCUU,
						CAST(MIN(T$BUSP)/100 AS DECIMAL(18,4)) AS T$BUSP
						--MIN(dbo.EXR2_New_fun_standard_cost(T$PJNO,T$SERN)) AS T$COPR
						--(SELECT TOP 1 B.BOCOS FROM FactoryLoading.dbo.TFSBOM421180_unit AS B WHERE B.t$pjno = A.T$pjno AND B.t$sern = A.T$SERN ) AS T$COPR
			FROM FactoryLoading.dbo.TFSBOM400180  AS A
			WHERE A.T$LCDT > CAST(@Period_End_date AS DATETIME)
			GROUP BY left(A.t$pjno,9),A.T$PLNT
		)
		,CTE_TFSBOM400180(T$PJNO,T$PLNT,T$SERN,T$CESU,T$CISU,T$TCIU,T$TCUU,T$BUSP,T$COPR) AS 
		(
			SELECT *,(SELECT TOP 1 B.BOCOS FROM FactoryLoading.dbo.TFSBOM421180_unit AS B WHERE LEFT(B.t$pjno,9) = A.T$pjno AND B.t$sern = A.T$SERN ) AS T$COPR
			FROM CTE_TFSBOM400_Before_Period_End_Date AS A
			UNION ALL
			SELECT *,(SELECT TOP 1 B.BOCOS FROM FactoryLoading.dbo.TFSBOM421180_unit AS B WHERE LEFT(B.t$pjno,9) = A.T$pjno AND B.t$sern = A.T$SERN ) AS T$COPR
			FROM CTE_TFSBOM400_After_Period_End_Date AS A
			WHERE T$PJNO NOT IN
				(
					SELECT T$PJNO FROM CTE_TFSBOM400_Before_Period_End_Date
				)
		)

	----GET 'FG OUT' FINAL DATA------------------------------------------------------------------------------------

			SELECT	'FG OUT'					 AS T$CATE,
					LTRIM(RTRIM(@Fiscal_Year))	 AS T$FYER,
					LTRIM(RTRIM(@Fiscal_Period)) AS T$FPRD,
					CASE	WHEN LTRIM(RTRIM(T711.T$PLNT)) = 'P1' THEN 'B1'
							WHEN LTRIM(RTRIM(T711.T$PLNT)) = 'P2' THEN 'B1'
							ELSE LTRIM(RTRIM(T711.T$PLNT)) 
					END
					AS T$PLNT,
					LTRIM(RTRIM(T711.T$ITEM))	AS T$ITEM,
					LTRIM(RTRIM(OEM.T$DSCA))	AS T$DSCA,
					''							AS T$TYPE,
					''							AS T$CODE,
					T711.T$TQUA,
					ROUND(T711.T$PRIC,2)		AS T$PRIC,
					ROUND(T711.T$AMNT,4)		AS T$AMNT,
					ROUND(T711.T$SQFT,4)		AS T$SQFT,
					ROUND(BOM.T$CESU,4)			AS T$CESU, 
					ROUND(BOM.T$CISU,4)			AS T$CISU,
					ROUND(BOM.T$TCIU,4)			AS T$TCIU,
					ROUND(BOM.T$TCUU,4)			AS T$TCUU,
					--CAST(OEM.T$COPR AS DECIMAL(18,4)) AS T$COPR,
					BOM.T$COPR,
					OEM.T$CUPN,
					BOM.T$BUSP,
					BOM.T$SERN
					--dbo.EXR2_GET_BOM_COST(T711.T$ITEM,T711.T$PLNT,@Period_End_date,'T$BUSP') AS T$BUSP,
					--CAST(dbo.EXR2_GET_BOM_COST(T711.T$ITEM,T711.T$PLNT,@Period_End_date,'T$SERN') AS INT) AS T$SERN
			INTO	#EXR2_Details_new
			FROM	temp_tfscpp711180 T711
					LEFT OUTER JOIN ITEM_MATCH_OEM AS OEM
						ON	T711.T$ITEM = OEM.T$ITEM
					LEFT OUTER JOIN CTE_TFSBOM400180 AS BOM
						ON T711.T$ITEM = LEFT(BOM.T$PJNO,8)	AND	T711.T$PLNT  = BOM.T$PLNT

		IF @Operation_Type = 'INSERT'
			BEGIN
				INSERT INTO DBO.EXR2_Details_new SELECT * FROM #EXR2_Details_new
			END
		IF @Operation_Type = 'QUERY'
			BEGIN
				SELECT * FROM #EXR2_Details_new
			END
	----SELECT 'INVOICE SALES'-----------------------------------------------------------------------------------------------------

END

















GO
