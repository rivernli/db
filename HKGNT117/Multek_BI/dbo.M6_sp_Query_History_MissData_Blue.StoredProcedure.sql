USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[M6_sp_Query_History_MissData_Blue]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[M6_sp_Query_History_MissData_Blue]
	-- Add the parameters for the stored procedure here
@Period	nvarchar(15)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE	@sqlString	NVARCHAR(MAX)
	DECLARE @TOP INT
	
	SET @Period = isnull(@period,'0')
	SET @TOP = CAST(@PERIOD AS INT)

    -- Insert statements for procedure here
	
	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('tempdb.##tempTable') AND TYPE = 'U')
		DROP TABLE #TEMPTABLE
		
	CREATE TABLE #tempTable
	(
		ID INT,
		PERIOD	NVARCHAR(50),
		[1] INT,[2] INT,[3] INT,[4] INT,[5] INT,[6] INT,[7] INT,[8] INT,[9] INT,[10] INT,
		[11] INT,[12] INT,[13] INT,[14] INT,[15] INT,[16] INT,[17] INT,[18] INT,[19] INT,[20] INT,
		[21] INT,[22] INT,[23] INT,[24] INT,[25] INT,[26] INT,[27] INT,[28] INT,[29] INT,[30] INT,
		[31] INT,[32] INT,[33] INT,[34] INT,[35] INT,[36] INT,[37] INT,[38] INT,[39] INT,[40] INT,
		[41] INT,[42] INT,[43] INT,[44] INT,[45] INT,[46] INT,[47] INT,[48] INT,[49] INT
	)
	
    IF @PERIOD = '0'
		BEGIN
			INSERT INTO #tempTable
			SELECT ID,CONVERT(NVARCHAR,PERIOD,111) PERIOD,[1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12],[13],[14],[15],[16],[17],[18],[19],[20],
			[21],[22],[23],[24],[25],[26],[27],[28],[29],[30],[31],[32],[33],[34],[35],[36],[37],[38],[39],[40],[41],
			[42],[43],[44],[45],[46],[47],[48],[49]
			FROM dbo.M6_Matrix_missData_Blue
		END
	IF @PERIOD <> '0'
		BEGIN
			SET @sqlString = 'INSERT INTO #tempTable SELECT ID,CONVERT(NVARCHAR,PERIOD,111) PERIOD,[1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12],[13],[14],[15],[16],[17],[18],[19],[20],
			[21],[22],[23],[24],[25],[26],[27],[28],[29],[30],[31],[32],[33],[34],[35],[36],[37],[38],[39],[40],[41],
			[42],[43],[44],[45],[46],[47],[48],[49] FROM (SELECT TOP '+@PERIOD+' * FROM dbo.M6_Matrix_missData_Blue ORDER BY ID DESC) AS D ORDER BY ID ASC'
			
			
			--SET @sqlString = 'SELECT * FROM (SELECT TOP '+@PERIOD+' * FROM dbo.M6_Matrix_Red ORDER BY ID DESC) AS D ORDER BY ID ASC'
			EXEC (@sqlString)
		END
		
	-- GET ADDTION INFORMATION 
	    INSERT INTO #tempTable
		SELECT TOP 1 ID,'当期遗漏' PERIOD,[1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12],[13],[14],[15],[16],[17],[18],[19],[20],
				[21],[22],[23],[24],[25],[26],[27],[28],[29],[30],[31],[32],[33],[34],[35],[36],[37],[38],[39],[40],[41],
				[42],[43],[44],[45],[46],[47],[48],[49]
				FROM dbo.M6_Matrix_missData_Blue ORDER BY ID DESC

		INSERT INTO #tempTable
		SELECT 0 AS ID,'历史最大遗漏' AS PERIOD,MAX([1]),MAX([2]),MAX([3]),MAX([4]),MAX([5]),MAX([6]),MAX([7]),MAX([8]),MAX([9]),MAX([10]),MAX([11]),MAX([12]),MAX([13]),MAX([14]),MAX([15]),MAX([16]),MAX([17]),MAX([18]),MAX([19]),MAX([20]),
				MAX([21]),MAX([22]),MAX([23]),MAX([24]),MAX([25]),MAX([26]),MAX([27]),MAX([28]),MAX([29]),MAX([30]),MAX([31]),MAX([32]),MAX([33]),MAX([34]),MAX([35]),MAX([36]),MAX([37]),MAX([38]),MAX([39]),MAX([40]),MAX([41]),
				MAX([42]),MAX([43]),MAX([44]),MAX([45]),MAX([46]),MAX([47]),MAX([48]),MAX([49])
				FROM dbo.M6_Matrix_missData_Blue

		INSERT INTO #tempTable
		SELECT	0 as ID,'当前出现次数' AS PERIOD,COUNT([1]),COUNT([2]),COUNT([3]),COUNT([4]),COUNT([5]),COUNT([6]),COUNT([7]),COUNT([8]),COUNT([9]),COUNT([10]),COUNT([11]),COUNT([12]),COUNT([13]),COUNT([14]),COUNT([15]),COUNT([16]),COUNT([17]),COUNT([18]),COUNT([19]),COUNT([20]),
				COUNT([21]),COUNT([22]),COUNT([23]),COUNT([24]),COUNT([25]),COUNT([26]),COUNT([27]),COUNT([28]),COUNT([29]),COUNT([30]),COUNT([31]),COUNT([32]),COUNT([33]),COUNT([34]),COUNT([35]),COUNT([36]),COUNT([37]),COUNT([38]),COUNT([39]),COUNT([40]),COUNT([41]),
				COUNT([42]),COUNT([43]),COUNT([44]),COUNT([45]),COUNT([46]),COUNT([47]),COUNT([48]),COUNT([49])
				FROM (SELECT TOP (@TOP) * FROM dbo.M6_Matrix_Blue ORDER BY ID DESC) AS A

		INSERT INTO #tempTable
		SELECT	0 AS ID,'历史出现次数' AS PERIOD,COUNT([1]),COUNT([2]),COUNT([3]),COUNT([4]),COUNT([5]),COUNT([6]),COUNT([7]),COUNT([8]),COUNT([9]),COUNT([10]),COUNT([11]),COUNT([12]),COUNT([13]),COUNT([14]),COUNT([15]),COUNT([16]),COUNT([17]),COUNT([18]),COUNT([19]),COUNT([20]),
				COUNT([21]),COUNT([22]),COUNT([23]),COUNT([24]),COUNT([25]),COUNT([26]),COUNT([27]),COUNT([28]),COUNT([29]),COUNT([30]),COUNT([31]),COUNT([32]),COUNT([33]),COUNT([34]),COUNT([35]),COUNT([36]),COUNT([37]),COUNT([38]),COUNT([39]),COUNT([40]),COUNT([41]),
				COUNT([42]),COUNT([43]),COUNT([44]),COUNT([45]),COUNT([46]),COUNT([47]),COUNT([48]),COUNT([49])
				FROM dbo.M6_Matrix_Blue

		UPDATE #tempTable SET ID = 0 FROM #tempTable WHERE PERIOD = '当期遗漏'

	SELECT * FROM #tempTable
	DROP TABLE #tempTable		
	
END

GO
