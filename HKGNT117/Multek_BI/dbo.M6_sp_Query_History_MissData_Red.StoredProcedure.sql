USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[M6_sp_Query_History_MissData_Red]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[M6_sp_Query_History_MissData_Red]
	-- Add the parameters for the stored procedure here
@Period	nvarchar(15)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE	@sqlString	NVARCHAR(MAX)
	
	SET @Period = isnull(@period,'0')

    -- Insert statements for procedure here
	
--	SELECT * INTO #result FROM dbo.M6_Matrix_Red WHERE 1 <> 1 
	
    IF @PERIOD = '0'
		BEGIN
			SELECT ID,CONVERT(NVARCHAR,PERIOD,111) PERIOD,[1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12],[13],[14],[15],[16],[17],[18],[19],[20],
			[21],[22],[23],[24],[25],[26],[27],[28],[29],[30],[31],[32],[33],[34],[35],[36],[37],[38],[39],[40],[41],
			[42],[43],[44],[45],[46],[47],[48],[49]
			FROM dbo.M6_Matrix_missData_Red
		END
	IF @PERIOD <> '0'
		BEGIN
			SET @sqlString = 'SELECT ID,CONVERT(NVARCHAR,PERIOD,111) PERIOD,[1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12],[13],[14],[15],[16],[17],[18],[19],[20],
			[21],[22],[23],[24],[25],[26],[27],[28],[29],[30],[31],[32],[33],[34],[35],[36],[37],[38],[39],[40],[41],
			[42],[43],[44],[45],[46],[47],[48],[49] FROM (SELECT TOP '+@PERIOD+' * FROM dbo.M6_Matrix_missData_Red ORDER BY ID DESC) AS D ORDER BY ID ASC'
			
			
			--SET @sqlString = 'SELECT * FROM (SELECT TOP '+@PERIOD+' * FROM dbo.M6_Matrix_Red ORDER BY ID DESC) AS D ORDER BY ID ASC'
			EXEC (@sqlString)
		END
		
	--SELECT * FROM #result ORDER BY ID ASC
END

GO
