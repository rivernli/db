USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[EXR2_sp_Automatically_Update_Material_Cost]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[EXR2_sp_Automatically_Update_Material_Cost]
AS
	BEGIN

	/* ====================   Update Unit Price  ==================== */

		TRUNCATE TABLE dbo.EXR2_Fixed_Material_Cost

		-- UPdate MAT Cost
		INSERT INTO dbo.EXR2_Fixed_Material_Cost(Plant,FYear,Project,OEM_Name,Operation,SaleAmount) SELECT Plant,FYear,project,OEM_Name,'MAT Cost',SaleAmount FROM dbo.EXR2_Fixed_Unit_Selling_Price WHERE Operation = 'Unit Price'

		UPDATE dbo.EXR2_Fixed_Material_Cost SET P01 = (SELECT TOP 1 X.t$cesu FROM EXR2_Details AS X WHERE X.Plant = EXR2_Fixed_Material_Cost.plant and X.Project = EXR2_Fixed_Material_Cost.Project and X.Period = 'P01' and X.FYear = EXR2_Fixed_Material_Cost.FYear)
		UPDATE dbo.EXR2_Fixed_Material_Cost SET P02 = (SELECT top 1 X.t$cesu FROM EXR2_Details AS X WHERE X.Plant = EXR2_Fixed_Material_Cost.plant and X.Project = EXR2_Fixed_Material_Cost.Project and X.Period = 'P02' and X.FYear = EXR2_Fixed_Material_Cost.FYear) --where FYear = @FYear
		UPDATE dbo.EXR2_Fixed_Material_Cost SET P03 = (SELECT top 1 X.t$cesu FROM EXR2_Details AS X WHERE X.Plant = EXR2_Fixed_Material_Cost.plant and X.Project = EXR2_Fixed_Material_Cost.Project and X.Period = 'P03' and X.FYear = EXR2_Fixed_Material_Cost.FYear) --where FYear = @FYear
		UPDATE dbo.EXR2_Fixed_Material_Cost SET P04 = (SELECT top 1 X.t$cesu FROM EXR2_Details AS X WHERE X.Plant = EXR2_Fixed_Material_Cost.plant and X.Project = EXR2_Fixed_Material_Cost.Project and X.Period = 'P04' and X.FYear = EXR2_Fixed_Material_Cost.FYear) --where FYear = @FYear
		UPDATE dbo.EXR2_Fixed_Material_Cost SET P05 = (SELECT top 1 X.t$cesu FROM EXR2_Details AS X WHERE X.Plant = EXR2_Fixed_Material_Cost.plant and X.Project = EXR2_Fixed_Material_Cost.Project and X.Period = 'P05' and X.FYear = EXR2_Fixed_Material_Cost.FYear) --where FYear = @FYear
		UPDATE dbo.EXR2_Fixed_Material_Cost SET P06 = (SELECT top 1 X.t$cesu FROM EXR2_Details AS X WHERE X.Plant = EXR2_Fixed_Material_Cost.plant and X.Project = EXR2_Fixed_Material_Cost.Project and X.Period = 'P06' and X.FYear = EXR2_Fixed_Material_Cost.FYear) --where FYear = @FYear
		UPDATE dbo.EXR2_Fixed_Material_Cost SET P07 = (SELECT top 1 X.t$cesu FROM EXR2_Details AS X WHERE X.Plant = EXR2_Fixed_Material_Cost.plant and X.Project = EXR2_Fixed_Material_Cost.Project and X.Period = 'P07' and X.FYear = EXR2_Fixed_Material_Cost.FYear) --where FYear = @FYear
		UPDATE dbo.EXR2_Fixed_Material_Cost SET P08 = (SELECT top 1 X.t$cesu FROM EXR2_Details AS X WHERE X.Plant = EXR2_Fixed_Material_Cost.plant and X.Project = EXR2_Fixed_Material_Cost.Project and X.Period = 'P08' and X.FYear = EXR2_Fixed_Material_Cost.FYear) --where FYear = @FYear
		UPDATE dbo.EXR2_Fixed_Material_Cost SET P09 = (SELECT top 1 X.t$cesu FROM EXR2_Details AS X WHERE X.Plant = EXR2_Fixed_Material_Cost.plant and X.Project = EXR2_Fixed_Material_Cost.Project and X.Period = 'P09' and X.FYear = EXR2_Fixed_Material_Cost.FYear) --where FYear = @FYear
		UPDATE dbo.EXR2_Fixed_Material_Cost SET P10 = (SELECT top 1 X.t$cesu FROM EXR2_Details AS X WHERE X.Plant = EXR2_Fixed_Material_Cost.plant and X.Project = EXR2_Fixed_Material_Cost.Project and X.Period = 'P10' and X.FYear = EXR2_Fixed_Material_Cost.FYear) --where FYear = @FYear
		UPDATE dbo.EXR2_Fixed_Material_Cost SET P11 = (SELECT top 1 X.t$cesu FROM EXR2_Details AS X WHERE X.Plant = EXR2_Fixed_Material_Cost.plant and X.Project = EXR2_Fixed_Material_Cost.Project and X.Period = 'P11' and X.FYear = EXR2_Fixed_Material_Cost.FYear) --where FYear = @FYear
		UPDATE dbo.EXR2_Fixed_Material_Cost SET P12 = (SELECT top 1 X.t$cesu FROM EXR2_Details AS X WHERE X.Plant = EXR2_Fixed_Material_Cost.plant and X.Project = EXR2_Fixed_Material_Cost.Project and X.Period = 'P12' and X.FYear = EXR2_Fixed_Material_Cost.FYear) --where FYear = @FYear

		-- Update MAT + MRB COST
		INSERT INTO dbo.EXR2_Fixed_Material_Cost(Plant,FYear,Project,OEM_Name,Operation,SaleAmount) SELECT Plant,FYear,project,OEM_Name,'MAT MRB Cost',SaleAmount FROM dbo.EXR2_Fixed_Unit_Selling_Price  WHERE Operation = 'Unit Price'

		UPDATE dbo.EXR2_Fixed_Material_Cost SET P01 = (SELECT top 1 X.t$cisu FROM EXR2_Details AS X WHERE X.Plant = EXR2_Fixed_Material_Cost.plant and X.Project = EXR2_Fixed_Material_Cost.Project and X.Period = 'P01' and X.FYear = EXR2_Fixed_Material_Cost.FYear) where Operation = 'MAT MRB Cost'
		UPDATE dbo.EXR2_Fixed_Material_Cost SET P02 = (SELECT top 1 X.t$cisu FROM EXR2_Details AS X WHERE X.Plant = EXR2_Fixed_Material_Cost.plant and X.Project = EXR2_Fixed_Material_Cost.Project and X.Period = 'P02' and X.FYear = EXR2_Fixed_Material_Cost.FYear) where Operation = 'MAT MRB Cost'
		UPDATE dbo.EXR2_Fixed_Material_Cost SET P03 = (SELECT top 1 X.t$cisu FROM EXR2_Details AS X WHERE X.Plant = EXR2_Fixed_Material_Cost.plant and X.Project = EXR2_Fixed_Material_Cost.Project and X.Period = 'P03' and X.FYear = EXR2_Fixed_Material_Cost.FYear) where Operation = 'MAT MRB Cost'
		UPDATE dbo.EXR2_Fixed_Material_Cost SET P04 = (SELECT top 1 X.t$cisu FROM EXR2_Details AS X WHERE X.Plant = EXR2_Fixed_Material_Cost.plant and X.Project = EXR2_Fixed_Material_Cost.Project and X.Period = 'P04' and X.FYear = EXR2_Fixed_Material_Cost.FYear) where Operation = 'MAT MRB Cost'
		UPDATE dbo.EXR2_Fixed_Material_Cost SET P05 = (SELECT top 1 X.t$cisu FROM EXR2_Details AS X WHERE X.Plant = EXR2_Fixed_Material_Cost.plant and X.Project = EXR2_Fixed_Material_Cost.Project and X.Period = 'P05' and X.FYear = EXR2_Fixed_Material_Cost.FYear) where Operation = 'MAT MRB Cost'
		UPDATE dbo.EXR2_Fixed_Material_Cost SET P06 = (SELECT top 1 X.t$cisu FROM EXR2_Details AS X WHERE X.Plant = EXR2_Fixed_Material_Cost.plant and X.Project = EXR2_Fixed_Material_Cost.Project and X.Period = 'P06' and X.FYear = EXR2_Fixed_Material_Cost.FYear) where Operation = 'MAT MRB Cost'
		UPDATE dbo.EXR2_Fixed_Material_Cost SET P07 = (SELECT top 1 X.t$cisu FROM EXR2_Details AS X WHERE X.Plant = EXR2_Fixed_Material_Cost.plant and X.Project = EXR2_Fixed_Material_Cost.Project and X.Period = 'P07' and X.FYear = EXR2_Fixed_Material_Cost.FYear) where Operation = 'MAT MRB Cost'
		UPDATE dbo.EXR2_Fixed_Material_Cost SET P08 = (SELECT top 1 X.t$cisu FROM EXR2_Details AS X WHERE X.Plant = EXR2_Fixed_Material_Cost.plant and X.Project = EXR2_Fixed_Material_Cost.Project and X.Period = 'P08' and X.FYear = EXR2_Fixed_Material_Cost.FYear) where Operation = 'MAT MRB Cost'
		UPDATE dbo.EXR2_Fixed_Material_Cost SET P09 = (SELECT top 1 X.t$cisu FROM EXR2_Details AS X WHERE X.Plant = EXR2_Fixed_Material_Cost.plant and X.Project = EXR2_Fixed_Material_Cost.Project and X.Period = 'P09' and X.FYear = EXR2_Fixed_Material_Cost.FYear) where Operation = 'MAT MRB Cost'
		UPDATE dbo.EXR2_Fixed_Material_Cost SET P10 = (SELECT top 1 X.t$cisu FROM EXR2_Details AS X WHERE X.Plant = EXR2_Fixed_Material_Cost.plant and X.Project = EXR2_Fixed_Material_Cost.Project and X.Period = 'P10' and X.FYear = EXR2_Fixed_Material_Cost.FYear) where Operation = 'MAT MRB Cost'
		UPDATE dbo.EXR2_Fixed_Material_Cost SET P11 = (SELECT top 1 X.t$cisu FROM EXR2_Details AS X WHERE X.Plant = EXR2_Fixed_Material_Cost.plant and X.Project = EXR2_Fixed_Material_Cost.Project and X.Period = 'P11' and X.FYear = EXR2_Fixed_Material_Cost.FYear) where Operation = 'MAT MRB Cost'
		UPDATE dbo.EXR2_Fixed_Material_Cost SET P12 = (SELECT top 1 X.t$cisu FROM EXR2_Details AS X WHERE X.Plant = EXR2_Fixed_Material_Cost.plant and X.Project = EXR2_Fixed_Material_Cost.Project and X.Period = 'P12' and X.FYear = EXR2_Fixed_Material_Cost.FYear) where Operation = 'MAT MRB Cost'
	END
GO
