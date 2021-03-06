USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[EXR2_New_sp_AUTO_UPDATE_Details]    Script Date: 2014/11/12 17:12:16 ******/
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
CREATE PROCEDURE [dbo].[EXR2_New_sp_AUTO_UPDATE_Details]
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
		---TFSBOM400180---------------------------------------------------------------------------------
		,CTE_TFSBOM400_Before_Period_End_Date(T$PJNO,T$PLNT,T$SERN,T$CESU,T$CISU,T$TCIU,T$TCUU,T$BUSP,T$COPR) AS 
		(
			SELECT M.T$PJNO,M.T$PLNT,M.T$SERN,M.T$CESU,M.T$CISU,M.T$TCIU,M.T$TCUU,CAST(M.T$BUSP/100 AS DECIMAL(18,4)) AS T$BUSP,n.BOCOS AS T$COPR 
			FROM FactoryLoading.dbo.TFSBOM400180 AS m,FactoryLoading.dbo.TFSBOM421180_unit AS n
			WHERE LEFT(m.T$PJNO,9) +M.T$PJNO+ CAST(m.t$sern AS NVARCHAR(3)) in
				(
					SELECT LEFT(A.T$PJNO,9)+MAX(A.T$PJNO)+CAST(MAX(A.T$SERN) AS NVARCHAR(3))
					FROM FactoryLoading.dbo.TFSBOM400180  AS A
					WHERE A.T$LCDT < CAST(@Period_End_date AS DATETIME)
					GROUP BY LEFT(A.T$PJNO,9)
				)
			AND M.T$PJNO = N.T$PJNO AND M.T$SERN = N.T$SERN
		)
		,
		CTE_TFSBOM400_After_Period_End_Date(T$PJNO,T$PLNT,T$SERN,T$CESU,T$CISU,T$TCIU,T$TCUU,T$BUSP,T$COPR) AS 
		(
			SELECT M.T$PJNO,M.T$PLNT,M.T$SERN,M.T$CESU,M.T$CISU,M.T$TCIU,M.T$TCUU,CAST(M.T$BUSP/100 AS DECIMAL(18,4)) AS T$BUSP,n.BOCOS AS T$COPR 
			FROM FactoryLoading.dbo.TFSBOM400180 AS m,FactoryLoading.dbo.TFSBOM421180_unit AS n
			WHERE LEFT(m.T$PJNO,9) +M.T$PJNO+ CAST(m.t$sern AS NVARCHAR(3)) in
				(
					SELECT LEFT(A.T$PJNO,9)+MAX(A.T$PJNO)+CAST(MIN(A.T$SERN) AS NVARCHAR(3))
					FROM FactoryLoading.dbo.TFSBOM400180  AS A
					WHERE A.T$LCDT >= CAST(@Period_End_date AS DATETIME)
					GROUP BY LEFT(A.T$PJNO,9)
				)
			AND M.T$PJNO = N.T$PJNO AND M.T$SERN = N.T$SERN
		)
		,CTE_TFSBOM400180(T$PJNO,T$PLNT,T$SERN,T$CESU,T$CISU,T$TCIU,T$TCUU,T$BUSP,T$COPR) AS 
		(
			SELECT * FROM CTE_TFSBOM400_Before_Period_End_Date AS A
			UNION ALL
			SELECT * FROM CTE_TFSBOM400_After_Period_End_Date AS A
			WHERE T$PJNO NOT IN
				(
					SELECT T$PJNO FROM CTE_TFSBOM400_Before_Period_End_Date
				)
		)
		---- surfinishing & technology ----------------------------------------------------------------------------
		,CTE_Fiatt006_PRODUCT_TYPE(T$ITEM,T$ASTR) AS
		(
			SELECT T$ITEM,LTRIM(RTRIM(T$ASTR)) FROM FACTORYLOADING.DBO.TFIATT006180 WHERE T$ATTR = 'TYPE'
		)

		,CTE_Fiatt006_SURFAINISING(T$ITEM,T$ASTR) AS
		(
			SELECT T$ITEM,LTRIM(RTRIM(T$ASTR)) FROM FACTORYLOADING.DBO.TFIATT006180 WHERE T$ATTR = 'SURF'
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
					PTYPE.T$ASTR				AS T$TYPE,
					SURF.T$ASTR					AS T$CODE,
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
					LEFT OUTER JOIN ITEM_MATCH_OEM AS OEM	ON	T711.T$ITEM = OEM.T$ITEM
					LEFT OUTER JOIN CTE_TFSBOM400180 AS BOM	ON T711.T$ITEM = LEFT(BOM.T$PJNO,8)	AND	T711.T$PLNT  = BOM.T$PLNT
					LEFT OUTER JOIN CTE_Fiatt006_PRODUCT_TYPE AS PTYPE ON PTYPE.T$ITEM = T711.T$ITEM
					LEFT OUTER JOIN CTE_Fiatt006_SURFAINISING AS SURF ON SURF.T$ITEM = T711.T$ITEM

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
