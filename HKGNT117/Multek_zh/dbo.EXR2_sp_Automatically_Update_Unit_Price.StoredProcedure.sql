USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[EXR2_sp_Automatically_Update_Unit_Price]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[EXR2_sp_Automatically_Update_Unit_Price]
AS
	BEGIN

	/* ====================   Update Unit Price  ==================== */

		DECLARE	@SQL_String NVARCHAR(MAX),@Count_Year INT,@FYear nvarchar(20)

		IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('tempdb.#TEMP_YEAR') AND TYPE = 'U')
			DROP TABLE #TEMP_YEAR

		SELECT FYear INTO #TEMP_YEAR FROM dbo.EXR2_DetailS GROUP BY FYear
		ALTER TABLE #TEMP_YEAR ADD ID INT IDENTITY
		SELECT @Count_Year = MAX(ID) FROM #TEMP_YEAR

		--
		IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('tempdb.#TEMP_Mul_Unit_Price') AND TYPE = 'U')
			DROP TABLE #TEMP_Mul_Unit_Price

		SELECT * into #TEMP_Mul_Unit_Price FROM dbo.EXR2_DetailS A 
		OUTER APPLY(SELECT munitprice= STUFF(REPLACE(REPLACE(
					(
						SELECT DISTINCT cast(unitprice as nvarchar(10)) as mUnitPrice FROM dbo.EXR2_DetailS N
						WHERE project = A.project
						and Fyear = A.FYear
						and Period = A.Period
						and Plant = A.Plant
						FOR XML AUTO
					), '<N mUnitPrice="', ','), '"/>', ''), 1, 1, '')
		)N
		--select * from #TEMP_Mul_Unit_Price 
		--
		CREATE INDEX FYear  ON #TEMP_Mul_Unit_Price(FYear)
		CREATE INDEX Plant  ON #TEMP_Mul_Unit_Price(Plant)
		CREATE INDEX period ON #TEMP_Mul_Unit_Price(Period)

		TRUNCATE TABLE dbo.EXR2_Fixed_Unit_Selling_Price

		WHILE @Count_Year > 0
			BEGIN
				SELECT @FYear = FYear FROM #TEMP_YEAR WHERE ID = @Count_Year

				-- UPdate Unit price
				INSERT INTO dbo.EXR2_Fixed_Unit_Selling_Price(Plant,FYear,Project,Operation) SELECT Plant,FYear,project,'Unit Price' FROM dbo.EXR2_DetailS WHERE FYear = @FYear GROUP BY plant,FYear,project
				UPDATE dbo.EXR2_Fixed_Unit_Selling_Price SET OEM_NAME = (select X.OEM_Name from dbo.COMMON_ItemMatchOEM AS X where X.item = project)
				UPDATE dbo.EXR2_Fixed_Unit_Selling_Price SET SaleAmount = (SELECT SUM(X.SalesAmount) FROM dbo.EXR2_DetailS AS X WHERE X.FYear = @FYear AND X.Project = EXR2_Fixed_Unit_Selling_Price.Project) where FYear = @FYear
				UPDATE dbo.EXR2_Fixed_Unit_Selling_Price SET P01 = (SELECT top 1 munitprice FROM #TEMP_Mul_Unit_Price AS X WHERE X.FYear = @FYear AND X.Plant = EXR2_Fixed_Unit_Selling_Price.plant and X.Project = EXR2_Fixed_Unit_Selling_Price.Project and X.Period = 'P01') where FYear = @FYear
				UPDATE dbo.EXR2_Fixed_Unit_Selling_Price SET P02 = (SELECT top 1 munitprice FROM #TEMP_Mul_Unit_Price AS X WHERE X.FYear = @FYear AND X.Plant = EXR2_Fixed_Unit_Selling_Price.plant and X.Project = EXR2_Fixed_Unit_Selling_Price.Project and X.Period = 'P02') where FYear = @FYear
				UPDATE dbo.EXR2_Fixed_Unit_Selling_Price SET P03 = (SELECT top 1 munitprice FROM #TEMP_Mul_Unit_Price AS X WHERE X.FYear = @FYear AND X.Plant = EXR2_Fixed_Unit_Selling_Price.plant and X.Project = EXR2_Fixed_Unit_Selling_Price.Project and X.Period = 'P03') where FYear = @FYear
				UPDATE dbo.EXR2_Fixed_Unit_Selling_Price SET P04 = (SELECT top 1 munitprice FROM #TEMP_Mul_Unit_Price AS X WHERE X.FYear = @FYear AND X.Plant = EXR2_Fixed_Unit_Selling_Price.plant and X.Project = EXR2_Fixed_Unit_Selling_Price.Project and X.Period = 'P04') where FYear = @FYear
				UPDATE dbo.EXR2_Fixed_Unit_Selling_Price SET P05 = (SELECT top 1 munitprice FROM #TEMP_Mul_Unit_Price AS X WHERE X.FYear = @FYear AND X.Plant = EXR2_Fixed_Unit_Selling_Price.plant and X.Project = EXR2_Fixed_Unit_Selling_Price.Project and X.Period = 'P05') where FYear = @FYear
				UPDATE dbo.EXR2_Fixed_Unit_Selling_Price SET P06 = (SELECT top 1 munitprice FROM #TEMP_Mul_Unit_Price AS X WHERE X.FYear = @FYear AND X.Plant = EXR2_Fixed_Unit_Selling_Price.plant and X.Project = EXR2_Fixed_Unit_Selling_Price.Project and X.Period = 'P06') where FYear = @FYear
				UPDATE dbo.EXR2_Fixed_Unit_Selling_Price SET P07 = (SELECT top 1 munitprice FROM #TEMP_Mul_Unit_Price AS X WHERE X.FYear = @FYear AND X.Plant = EXR2_Fixed_Unit_Selling_Price.plant and X.Project = EXR2_Fixed_Unit_Selling_Price.Project and X.Period = 'P07') where FYear = @FYear
				UPDATE dbo.EXR2_Fixed_Unit_Selling_Price SET P08 = (SELECT top 1 munitprice FROM #TEMP_Mul_Unit_Price AS X WHERE X.FYear = @FYear AND X.Plant = EXR2_Fixed_Unit_Selling_Price.plant and X.Project = EXR2_Fixed_Unit_Selling_Price.Project and X.Period = 'P08') where FYear = @FYear
				UPDATE dbo.EXR2_Fixed_Unit_Selling_Price SET P09 = (SELECT top 1 munitprice FROM #TEMP_Mul_Unit_Price AS X WHERE X.FYear = @FYear AND X.Plant = EXR2_Fixed_Unit_Selling_Price.plant and X.Project = EXR2_Fixed_Unit_Selling_Price.Project and X.Period = 'P09') where FYear = @FYear
				UPDATE dbo.EXR2_Fixed_Unit_Selling_Price SET P10 = (SELECT top 1 munitprice FROM #TEMP_Mul_Unit_Price AS X WHERE X.FYear = @FYear AND X.Plant = EXR2_Fixed_Unit_Selling_Price.plant and X.Project = EXR2_Fixed_Unit_Selling_Price.Project and X.Period = 'P10') where FYear = @FYear
				UPDATE dbo.EXR2_Fixed_Unit_Selling_Price SET P11 = (SELECT top 1 munitprice FROM #TEMP_Mul_Unit_Price AS X WHERE X.FYear = @FYear AND X.Plant = EXR2_Fixed_Unit_Selling_Price.plant and X.Project = EXR2_Fixed_Unit_Selling_Price.Project and X.Period = 'P11') where FYear = @FYear
				UPDATE dbo.EXR2_Fixed_Unit_Selling_Price SET P12 = (SELECT top 1 munitprice FROM #TEMP_Mul_Unit_Price AS X WHERE X.FYear = @FYear AND X.Plant = EXR2_Fixed_Unit_Selling_Price.plant and X.Project = EXR2_Fixed_Unit_Selling_Price.Project and X.Period = 'P12') where FYear = @FYear

				-- Update Avg price
				INSERT INTO EXR2_Fixed_Unit_Selling_Price(Plant,FYear,Project,Operation,OEM_NAME,SaleAmount) SELECT Plant,FYear,Project,'AVG Price',OEM_NAME,SaleAmount FROM dbo.EXR2_Fixed_Unit_Selling_Price WHERE FYEAR = @FYear
				UPDATE dbo.EXR2_Fixed_Unit_Selling_Price SET P01 = (SELECT SUM(X.SalesAmount)/SUM(X.ShipmentQty) FROM #TEMP_Mul_Unit_Price AS X WHERE X.FYear = @FYear AND X.Plant = EXR2_Fixed_Unit_Selling_Price.plant and X.Project = EXR2_Fixed_Unit_Selling_Price.Project and X.Period = 'P01') where FYear = @FYear AND operation = 'AVG Price'
				UPDATE dbo.EXR2_Fixed_Unit_Selling_Price SET P02 = (SELECT SUM(X.SalesAmount)/SUM(X.ShipmentQty) FROM #TEMP_Mul_Unit_Price AS X WHERE X.FYear = @FYear AND X.Plant = EXR2_Fixed_Unit_Selling_Price.plant and X.Project = EXR2_Fixed_Unit_Selling_Price.Project and X.Period = 'P02') where FYear = @FYear AND operation = 'AVG Price'
				UPDATE dbo.EXR2_Fixed_Unit_Selling_Price SET P03 = (SELECT SUM(X.SalesAmount)/SUM(X.ShipmentQty) FROM #TEMP_Mul_Unit_Price AS X WHERE X.FYear = @FYear AND X.Plant = EXR2_Fixed_Unit_Selling_Price.plant and X.Project = EXR2_Fixed_Unit_Selling_Price.Project and X.Period = 'P03') where FYear = @FYear AND operation = 'AVG Price'
				UPDATE dbo.EXR2_Fixed_Unit_Selling_Price SET P04 = (SELECT SUM(X.SalesAmount)/SUM(X.ShipmentQty) FROM #TEMP_Mul_Unit_Price AS X WHERE X.FYear = @FYear AND X.Plant = EXR2_Fixed_Unit_Selling_Price.plant and X.Project = EXR2_Fixed_Unit_Selling_Price.Project and X.Period = 'P04') where FYear = @FYear AND operation = 'AVG Price'
				UPDATE dbo.EXR2_Fixed_Unit_Selling_Price SET P05 = (SELECT SUM(X.SalesAmount)/SUM(X.ShipmentQty) FROM #TEMP_Mul_Unit_Price AS X WHERE X.FYear = @FYear AND X.Plant = EXR2_Fixed_Unit_Selling_Price.plant and X.Project = EXR2_Fixed_Unit_Selling_Price.Project and X.Period = 'P05') where FYear = @FYear AND operation = 'AVG Price'
				UPDATE dbo.EXR2_Fixed_Unit_Selling_Price SET P06 = (SELECT SUM(X.SalesAmount)/SUM(X.ShipmentQty) FROM #TEMP_Mul_Unit_Price AS X WHERE X.FYear = @FYear AND X.Plant = EXR2_Fixed_Unit_Selling_Price.plant and X.Project = EXR2_Fixed_Unit_Selling_Price.Project and X.Period = 'P06') where FYear = @FYear AND operation = 'AVG Price'
				UPDATE dbo.EXR2_Fixed_Unit_Selling_Price SET P07 = (SELECT SUM(X.SalesAmount)/SUM(X.ShipmentQty) FROM #TEMP_Mul_Unit_Price AS X WHERE X.FYear = @FYear AND X.Plant = EXR2_Fixed_Unit_Selling_Price.plant and X.Project = EXR2_Fixed_Unit_Selling_Price.Project and X.Period = 'P07') where FYear = @FYear AND operation = 'AVG Price'
				UPDATE dbo.EXR2_Fixed_Unit_Selling_Price SET P08 = (SELECT SUM(X.SalesAmount)/SUM(X.ShipmentQty) FROM #TEMP_Mul_Unit_Price AS X WHERE X.FYear = @FYear AND X.Plant = EXR2_Fixed_Unit_Selling_Price.plant and X.Project = EXR2_Fixed_Unit_Selling_Price.Project and X.Period = 'P08') where FYear = @FYear AND operation = 'AVG Price'
				UPDATE dbo.EXR2_Fixed_Unit_Selling_Price SET P09 = (SELECT SUM(X.SalesAmount)/SUM(X.ShipmentQty) FROM #TEMP_Mul_Unit_Price AS X WHERE X.FYear = @FYear AND X.Plant = EXR2_Fixed_Unit_Selling_Price.plant and X.Project = EXR2_Fixed_Unit_Selling_Price.Project and X.Period = 'P09') where FYear = @FYear AND operation = 'AVG Price'
				UPDATE dbo.EXR2_Fixed_Unit_Selling_Price SET P10 = (SELECT SUM(X.SalesAmount)/SUM(X.ShipmentQty) FROM #TEMP_Mul_Unit_Price AS X WHERE X.FYear = @FYear AND X.Plant = EXR2_Fixed_Unit_Selling_Price.plant and X.Project = EXR2_Fixed_Unit_Selling_Price.Project and X.Period = 'P10') where FYear = @FYear AND operation = 'AVG Price'
				UPDATE dbo.EXR2_Fixed_Unit_Selling_Price SET P11 = (SELECT SUM(X.SalesAmount)/SUM(X.ShipmentQty) FROM #TEMP_Mul_Unit_Price AS X WHERE X.FYear = @FYear AND X.Plant = EXR2_Fixed_Unit_Selling_Price.plant and X.Project = EXR2_Fixed_Unit_Selling_Price.Project and X.Period = 'P11') where FYear = @FYear AND operation = 'AVG Price'
				UPDATE dbo.EXR2_Fixed_Unit_Selling_Price SET P12 = (SELECT SUM(X.SalesAmount)/SUM(X.ShipmentQty) FROM #TEMP_Mul_Unit_Price AS X WHERE X.FYear = @FYear AND X.Plant = EXR2_Fixed_Unit_Selling_Price.plant and X.Project = EXR2_Fixed_Unit_Selling_Price.Project and X.Period = 'P12') where FYear = @FYear AND operation = 'AVG Price'

				SET @Count_Year = @Count_Year - 1
			END

	/* ====================  Update EXR2_Fixed_All_projects_by_MAT_percentage  ==================== */
		IF NOT EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'MULTEK_ZH.dbo.EXR2_Fixed_All_projects_by_MAT_percentage') AND TYPE = 'U')
			BEGIN
				SELECT FYear,Period,t$cupn,Plant,'' as OEM_NAME,Project,t$cesu AS MATCost,UnitPrice,ShipmentQty,SalesAmount,t$cesu AS PERCENTAGE INTO EXR2_Fixed_All_projects_by_MAT_percentage FROM dbo.EXR2_DetailS WHERE 1 <> 1
				ALTER TABLE EXR2_Fixed_All_projects_by_MAT_percentage ALTER COLUMN OEM_NAME NVARCHAR(50)
			END

		TRUNCATE TABLE dbo.EXR2_Fixed_All_projects_by_MAT_percentage

		INSERT INTO dbo.EXR2_Fixed_All_projects_by_MAT_percentage
		SELECT FYear,Period,t$cupn,Plant,'' as OEM_NAME,Project,t$cesu AS MATCost,CAST(UnitPrice AS DECIMAL(18,2)),ShipmentQty,CAST(SalesAmount AS DECIMAL(18,2)),cast(isnull(t$cesu,0) / case isnull(UnitPrice,0) when 0 then 1 else UnitPrice end  as decimal(18,4)) AS PERCENTAGE 
		FROM dbo.EXR2_DetailS

		UPDATE dbo.EXR2_Fixed_All_projects_by_MAT_percentage SET OEM_NAME = (select X.OEM_Name from dbo.COMMON_ItemMatchOEM AS X where X.item = project)

	/* ====================  Update EXR2_Fixed_All_OEMS_by_MAT_percentage  ==================== */
--		IF NOT EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'MULTEK_ZH.dbo.EXR2_Fixed_ALL_OEMS_By_MAT_Percentage') AND TYPE = 'U')
--			BEGIN
--				SELECT FYear,Period,Plant,'' as OEM_NAME,Project,t$cesu AS MATCost,UnitPrice,ShipmentQty,SalesAmount,t$cesu AS PERCENTAGE INTO EXR2_Fixed_ALL_OEMS_By_MAT_Percentage FROM dbo.EXR2_DetailS WHERE 1 <> 1
--				ALTER TABLE EXR2_Fixed_ALL_OEMS_By_MAT_Percentage ALTER COLUMN OEM_NAME NVARCHAR(50)
--			END
--
--		IF NOT EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#temp_by_OEM') AND TYPE = 'U'))
--			drop
--
--		INSERT INTO dbo.EXR2_Fixed_ALL_OEMS_By_MAT_Percentage
--		SELECT FYear,Period,Plant,'' as OEM_NAME,Project,t$cesu AS MATCost,CAST(UnitPrice AS DECIMAL(18,2)),ShipmentQty,CAST(SalesAmount AS DECIMAL(18,2)),cast(isnull(t$cesu,0) / case isnull(UnitPrice,0) when 0 then 1 else UnitPrice end  as decimal(18,4)) AS PERCENTAGE 
--		FROM dbo.EXR2_DetailS

	END
GO
