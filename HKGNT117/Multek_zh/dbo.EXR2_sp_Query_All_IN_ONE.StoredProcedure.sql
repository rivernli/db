USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[EXR2_sp_Query_All_IN_ONE]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ===========================================================================
-- Author:		<Author,Rivern Li>
-- Create date: <Create Date,2010/08/18,>
-- Description:	<Description,EXR2 all in one>
-- ===========================================================================
CREATE PROCEDURE [dbo].[EXR2_sp_Query_All_IN_ONE]
	@FYEAR   NVARCHAR(10),
	@PLANT   NVARCHAR(15),
	@TOP     INT
AS
BEGIN

	SET NOCOUNT ON;
	DECLARE	@sqlString NVARCHAR(MAX)

/*============================ Parameter checking ============================*/

	SET @FYEAR = ISNULL(@FYEAR,'')
	SET @PLANT = ISNULL(@PLANT,'')
	SET @TOP   = ISNULL(@TOP,0)

	IF @FYEAR = ''
		BEGIN
			RAISERROR('Please select parameter FYear !',16,1)	RETURN
		END

	IF @PLANT = ''
		BEGIN
			RAISERROR('Please select parameter Plant !',16,1)	RETURN
		END

/*============================ Prepare Data  =================================*/

	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#tempUnitPrice') AND TYPE = 'U')
		DROP TABLE #tempUnitPrice

	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#tempMATCost') AND TYPE = 'U')
		DROP TABLE #tempMATCost

	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#tempYearPeriod') AND TYPE = 'U')
		DROP TABLE #tempYearPeriod

	SELECT Plant,FYear,Project,OEM_Name,Operation,SaleAmount,P01,P02,P03,P04,P05,P06,P07,P08,P09,P10,P11,P12 INTO #tempUnitPrice FROM dbo.EXR2_Fixed_Unit_Selling_Price WHERE 1 <> 1
	SELECT Plant,FYear,Project,OEM_Name,Operation,SaleAmount,P01,P02,P03,P04,P05,P06,P07,P08,P09,P10,P11,P12 INTO #tempMATCost   FROM dbo.EXR2_Fixed_Unit_Selling_Price WHERE 1 <> 1

	IF @TOP <> 0
		INSERT INTO #tempUnitPrice SELECT TOP(@TOP) Plant,FYear,Project,OEM_Name,Operation,SaleAmount,P01,P02,P03,P04,P05,P06,P07,P08,P09,P10,P11,P12 FROM dbo.EXR2_Fixed_Unit_Selling_Price WHERE FYEAR = @FYEAR AND PLANT = @PLANT AND OPERATION = 'AVG PRICE'
	ELSE
		INSERT INTO #tempUnitPrice SELECT Plant,FYear,Project,OEM_Name,Operation,SaleAmount,P01,P02,P03,P04,P05,P06,P07,P08,P09,P10,P11,P12 FROM dbo.EXR2_Fixed_Unit_Selling_Price WHERE FYEAR = @FYEAR AND PLANT = @PLANT AND OPERATION = 'AVG PRICE'

	IF @TOP <> 0
		INSERT INTO #tempMATCost SELECT TOP(@TOP) Plant,FYear,Project,OEM_Name,Operation,SaleAmount,P01,P02,P03,P04,P05,P06,P07,P08,P09,P10,P11,P12 FROM dbo.EXR2_Fixed_Material_Cost WHERE FYEAR = @FYEAR AND PLANT = @PLANT
	ELSE
		INSERT INTO #tempMATCost SELECT Plant,FYear,Project,OEM_Name,Operation,SaleAmount,P01,P02,P03,P04,P05,P06,P07,P08,P09,P10,P11,P12 FROM dbo.EXR2_Fixed_Material_Cost WHERE FYEAR = @FYEAR AND PLANT = @PLANT

	SELECT PERIOD INTO #tempYearPeriod FROM dbo.EXR2_Details WHERE FYEAR = @FYEAR GROUP BY PERIOD

--	SELECT * FROM #tempMATCost
--	SELECT * FROM #tempUnitPrice

/*============================ Logic  ============================*/

	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#tempResult') AND TYPE = 'U')
		DROP TABLE #tempResult

	SELECT Plant,FYear,Project,OEM_Name,Operation as Period,SaleAmount INTO #tempResult FROM dbo.EXR2_Fixed_Unit_Selling_Price where 1 <> 1

	ALTER TABLE #tempResult ADD Avg_Price   FLOAT
	ALTER TABLE #tempResult ADD MAT_Cost    FLOAT
	ALTER TABLE #tempResult ADD SPREAD	    FLOAT
	ALTER TABLE #tempResult ADD MAT_Percent FLOAT

	INSERT INTO #tempResult(Plant,FYear,Project,OEM_Name,Period,SaleAmount,Avg_Price) SELECT Plant,FYear,Project,OEM_Name,'P01',SaleAmount,P01 FROM #tempUnitPrice
	INSERT INTO #tempResult(Plant,FYear,Project,OEM_Name,Period,SaleAmount,Avg_Price) SELECT Plant,FYear,Project,OEM_Name,'P02',SaleAmount,P02 FROM #tempUnitPrice
	INSERT INTO #tempResult(Plant,FYear,Project,OEM_Name,Period,SaleAmount,Avg_Price) SELECT Plant,FYear,Project,OEM_Name,'P03',SaleAmount,P03 FROM #tempUnitPrice
	INSERT INTO #tempResult(Plant,FYear,Project,OEM_Name,Period,SaleAmount,Avg_Price) SELECT Plant,FYear,Project,OEM_Name,'P04',SaleAmount,P04 FROM #tempUnitPrice
	INSERT INTO #tempResult(Plant,FYear,Project,OEM_Name,Period,SaleAmount,Avg_Price) SELECT Plant,FYear,Project,OEM_Name,'P05',SaleAmount,P05 FROM #tempUnitPrice
	INSERT INTO #tempResult(Plant,FYear,Project,OEM_Name,Period,SaleAmount,Avg_Price) SELECT Plant,FYear,Project,OEM_Name,'P06',SaleAmount,P06 FROM #tempUnitPrice
	INSERT INTO #tempResult(Plant,FYear,Project,OEM_Name,Period,SaleAmount,Avg_Price) SELECT Plant,FYear,Project,OEM_Name,'P07',SaleAmount,P07 FROM #tempUnitPrice
	INSERT INTO #tempResult(Plant,FYear,Project,OEM_Name,Period,SaleAmount,Avg_Price) SELECT Plant,FYear,Project,OEM_Name,'P08',SaleAmount,P08 FROM #tempUnitPrice
	INSERT INTO #tempResult(Plant,FYear,Project,OEM_Name,Period,SaleAmount,Avg_Price) SELECT Plant,FYear,Project,OEM_Name,'P09',SaleAmount,P09 FROM #tempUnitPrice
	INSERT INTO #tempResult(Plant,FYear,Project,OEM_Name,Period,SaleAmount,Avg_Price) SELECT Plant,FYear,Project,OEM_Name,'P10',SaleAmount,P10 FROM #tempUnitPrice
	INSERT INTO #tempResult(Plant,FYear,Project,OEM_Name,Period,SaleAmount,Avg_Price) SELECT Plant,FYear,Project,OEM_Name,'P11',SaleAmount,P11 FROM #tempUnitPrice
	INSERT INTO #tempResult(Plant,FYear,Project,OEM_Name,Period,SaleAmount,Avg_Price) SELECT Plant,FYear,Project,OEM_Name,'P12',SaleAmount,P12 FROM #tempUnitPrice

	UPDATE #tempResult SET MAT_Cost = (SELECT X.P01 FROM #tempMATCost AS X WHERE X.Plant = #tempResult.PLANT AND X.FYear = #tempResult.FYear AND X.Project = #tempResult.Project) WHERE Period = 'P01'
	UPDATE #tempResult SET MAT_Cost = (SELECT X.P02 FROM #tempMATCost AS X WHERE X.Plant = #tempResult.PLANT AND X.FYear = #tempResult.FYear AND X.Project = #tempResult.Project) WHERE Period = 'P02'
	UPDATE #tempResult SET MAT_Cost = (SELECT X.P03 FROM #tempMATCost AS X WHERE X.Plant = #tempResult.PLANT AND X.FYear = #tempResult.FYear AND X.Project = #tempResult.Project) WHERE Period = 'P03'
	UPDATE #tempResult SET MAT_Cost = (SELECT X.P04 FROM #tempMATCost AS X WHERE X.Plant = #tempResult.PLANT AND X.FYear = #tempResult.FYear AND X.Project = #tempResult.Project) WHERE Period = 'P04'
	UPDATE #tempResult SET MAT_Cost = (SELECT X.P05 FROM #tempMATCost AS X WHERE X.Plant = #tempResult.PLANT AND X.FYear = #tempResult.FYear AND X.Project = #tempResult.Project) WHERE Period = 'P05'
	UPDATE #tempResult SET MAT_Cost = (SELECT X.P06 FROM #tempMATCost AS X WHERE X.Plant = #tempResult.PLANT AND X.FYear = #tempResult.FYear AND X.Project = #tempResult.Project) WHERE Period = 'P06'
	UPDATE #tempResult SET MAT_Cost = (SELECT X.P07 FROM #tempMATCost AS X WHERE X.Plant = #tempResult.PLANT AND X.FYear = #tempResult.FYear AND X.Project = #tempResult.Project) WHERE Period = 'P07'
	UPDATE #tempResult SET MAT_Cost = (SELECT X.P08 FROM #tempMATCost AS X WHERE X.Plant = #tempResult.PLANT AND X.FYear = #tempResult.FYear AND X.Project = #tempResult.Project) WHERE Period = 'P08'
	UPDATE #tempResult SET MAT_Cost = (SELECT X.P09 FROM #tempMATCost AS X WHERE X.Plant = #tempResult.PLANT AND X.FYear = #tempResult.FYear AND X.Project = #tempResult.Project) WHERE Period = 'P09'
	UPDATE #tempResult SET MAT_Cost = (SELECT X.P10 FROM #tempMATCost AS X WHERE X.Plant = #tempResult.PLANT AND X.FYear = #tempResult.FYear AND X.Project = #tempResult.Project) WHERE Period = 'P10'
	UPDATE #tempResult SET MAT_Cost = (SELECT X.P11 FROM #tempMATCost AS X WHERE X.Plant = #tempResult.PLANT AND X.FYear = #tempResult.FYear AND X.Project = #tempResult.Project) WHERE Period = 'P11'
	UPDATE #tempResult SET MAT_Cost = (SELECT X.P12 FROM #tempMATCost AS X WHERE X.Plant = #tempResult.PLANT AND X.FYear = #tempResult.FYear AND X.Project = #tempResult.Project) WHERE Period = 'P12'

--	UPDATE #tempResult SET MAT_Cost = 0 WHERE MAT_Cost  IS NULL
--	UPDATE #tempResult SET Avg_Price= 0 WHERE Avg_Price IS NULL
	UPDATE #tempResult SET MAT_Cost = CAST(MAT_Cost  AS DECIMAL(18,2)) WHERE MAT_Cost  IS NOT NULL
	UPDATE #tempResult SET Avg_Price= CAST(Avg_Price AS DECIMAL(18,2)) WHERE Avg_Price IS NOT NULL
	UPDATE #tempResult SET SPREAD = Avg_Price - MAT_Cost WHERE MAT_Cost IS NOT NULL AND Avg_Price IS NOT NULL
	UPDATE #tempResult SET MAT_Percent = CAST((MAT_Cost / Avg_Price)*100 AS DECIMAL(18,2)) WHERE Avg_Price <> 0

--	DELETE #tempResult WHERE MAT_Cost = 0 AND Avg_Price = 0

/*============================ Show result ===================================================================*/

	SELECT * FROM #tempResult WHERE PERIOD IN (SELECT PERIOD FROM #tempYearPeriod) ORDER BY SALEAMOUNT DESC,PROJECT,Period ASC

--	Get spread result

	SELECT Plant,FYear,Project,OEM_Name,P01,P02,P03,P04,P05,P06,P07,P08,P09,P10,P11,P12 
	FROM (SELECT Plant,FYear,Project,OEM_Name,PERIOD,SPREAD FROM #tempResult) P PIVOT (SUM(SPREAD) FOR PERIOD IN (P01,P02,P03,P04,P05,P06,P07,P08,P09,P10,P11,P12)) AS PVT

--	Get spread result
	SELECT Plant,FYear,Project,OEM_Name,P01,P02,P03,P04,P05,P06,P07,P08,P09,P10,P11,P12 
	FROM (SELECT Plant,FYear,Project,OEM_Name,PERIOD,MAT_Percent FROM #tempResult) P PIVOT (SUM(MAT_Percent) FOR PERIOD IN (P01,P02,P03,P04,P05,P06,P07,P08,P09,P10,P11,P12)) AS PVT


END




GO
