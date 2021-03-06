USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[M6_sp_auto_analysis_Relation_must_exists - step 4]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[M6_sp_auto_analysis_Relation_must_exists - step 4]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE	@LOOP INT
	DECLARE @sqlString NVARCHAR(MAX)
	
	TRUNCATE TABLE dbo.M6_Relation_must_exists
	
	SET @LOOP = 1
	WHILE @LOOP < 50
		BEGIN
			IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('tempdb.#mainTable') AND TYPE = 'U')
				DROP TABLE #mainTable
			CREATE TABLE #mainTable (AUTOID INT IDENTITY,ID INT,VALUE INT)
			
			SET @sqlString = 'INSERT INTO #mainTable(ID,VALUE) SELECT ID,'+CAST(@LOOP AS NVARCHAR(2))+' FROM dbo.M6_Matrix_Red WHERE ['+CAST(@LOOP AS NVARCHAR(2))+'] = '+CAST(@LOOP AS NVARCHAR(2))
			EXEC (@sqlString)
			
			UPDATE #mainTable SET ID = ID + 1

			INSERT INTO dbo.M6_Relation_must_exists
			SELECT @LOOP,COUNT([1]),COUNT([2]),COUNT([3]),COUNT([4]),COUNT([5]),COUNT([6]),COUNT([7]),COUNT([8]),COUNT([9]),COUNT([10])
						,COUNT([11]),COUNT([12]),COUNT([13]),COUNT([14]),COUNT([15]),COUNT([16]),COUNT([17]),COUNT([18]),COUNT([19]),COUNT([20])
						,COUNT([21]),COUNT([22]),COUNT([23]),COUNT([24]),COUNT([25]),COUNT([26]),COUNT([27]),COUNT([28]),COUNT([29]),COUNT([30])
						,COUNT([31]),COUNT([32]),COUNT([33]),COUNT([34]),COUNT([35]),COUNT([36]),COUNT([37]),COUNT([38]),COUNT([39]),COUNT([40])
						,COUNT([41]),COUNT([42]),COUNT([43]),COUNT([44]),COUNT([45]),COUNT([46]),COUNT([47]),COUNT([48]),COUNT([49])
			FROM	dbo.M6_Matrix_Red WHERE ID IN (SELECT ID FROM #mainTable)
			
			DROP TABLE #mainTable
			SET @LOOP = @LOOP + 1
		END
END

GO
