USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[M6_auto_analysis_Releation - step 3]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[M6_auto_analysis_Releation - step 3] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE	@LOOP INT
	DECLARE @sqlString NVARCHAR(MAX)

	TRUNCATE TABLE dbo.M6_Matrix_Relation

    -- Insert statements for procedure here
    
    SET @LOOP = 1
    WHILE @LOOP <=49
		BEGIN
			--IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID=OBJECT_ID('tempdb.#Temp') AND TYPE = 'U')
			--	DROP TABLE #Temp
			
			SET @sqlString = 'INSERT INTO dbo.M6_Matrix_Relation([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12],[13],[14],[15],[16],[17],[18],[19],[20],[21],[22],[23],[24],[25],[26],[27],[28],[29],[30],[31],[32],[33],[34],[35],[36],[37],[38],[39],[40],[41],[42],[43],[44],[45],[46],[47],[48],[49])
								SELECT	COUNT([1]) AS [1],COUNT([2]) AS [2],COUNT([3]) AS [3],COUNT([4]) AS [4],COUNT([5]) AS [5],COUNT([6]) AS [6],COUNT([7]) AS [7],
									COUNT([8]) AS [8],COUNT([9]) AS [9],COUNT([10]) AS [10],COUNT([11]) AS [11],COUNT([12]) AS [12],COUNT([13]) AS [13],COUNT([14]) AS [14],
									COUNT([15]) AS [15],COUNT([16]) AS [16],COUNT([17]) AS [17],COUNT([18]) AS [18],COUNT([19]) AS [19],COUNT([20]) AS [20],COUNT([21]) AS [21],
									COUNT([22]) AS [22],COUNT([23]) AS [23],COUNT([24]) AS [24],COUNT([25]) AS [25],COUNT([26]) AS [26],COUNT([27]) AS [27],COUNT([28]) AS [28],
									COUNT([29]) AS [29],COUNT([30]) AS [30],COUNT([31]) AS [31],COUNT([32]) AS [32],COUNT([33]) AS [33],COUNT([34]) AS [34],COUNT([35]) AS [35],
									COUNT([36]) AS [36],COUNT([37]) AS [37],COUNT([38]) AS [38],COUNT([39]) AS [39],COUNT([40]) AS [40],COUNT([41]) AS [41],COUNT([42]) AS [42],
									COUNT([43]) AS [43],COUNT([44]) AS [44],COUNT([45]) AS [45],COUNT([46]) AS [46],COUNT([47]) AS [47],COUNT([48]) AS [48],COUNT([49]) AS [49]
							FROM dbo.M6_Matrix_Red where ['+CAST(@LOOP AS NVARCHAR(2))+']='+CAST(@LOOP AS NVARCHAR(2))+' group by ['+CAST(@LOOP AS NVARCHAR(2))+']'
			EXEC(@sqlString)
			SET @LOOP = @LOOP + 1
		END
END

GO
