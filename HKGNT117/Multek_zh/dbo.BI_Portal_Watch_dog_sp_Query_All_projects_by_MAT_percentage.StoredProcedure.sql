USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[BI_Portal_Watch_dog_sp_Query_All_projects_by_MAT_percentage]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[BI_Portal_Watch_dog_sp_Query_All_projects_by_MAT_percentage]
@Type			NVARCHAR(30)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @sqlString		NVARCHAR(1000)
	DECLARE @Current_FYear	NVARCHAR(10)
	DECLARE	@Last_Period	NVARCHAR(10)
	DECLARE	@FYear			NVARCHAR(10)
	DECLARE	@FPeriod		NVARCHAR(10)
	DECLARE	@plant			NVARCHAR(15)
	DECLARE	@top			NVARCHAR(10)

	/*========================================================================================================*/
    -- Get Gurrent Finance Period
		SELECT @Current_FYear = FiscalYearDesc , @Last_Period = FiscalPeriod FROM ce3p1179.dbo.Calender WHERE CONVERT(CHAR,calenderDate,102) = CONVERT(CHAR,GETDATE(),102)

		SET @Last_Period = @Last_Period - 1
		IF	@Last_Period = 0
			BEGIN
				SET	@Last_Period = 'P12'
				SET @Current_FYear = 'FY'+CAST((CAST(RIGHT(@Current_FYear,4)AS INT) - 1) AS NVARCHAR(4))
			END
		ELSE
			BEGIN
				IF CAST(@Last_Period AS INT) < 10
					SET @Last_Period = 'P0'+CAST(@Last_Period AS NVARCHAR(3))
				ELSE
					SET @Last_Period = 'P' +CAST(@Last_Period AS NVARCHAR(3))
			END

	/*========================================================================================================*/
	SET @FYear = @Current_FYear
	SET @FPeriod = @Last_Period
	SET @FPeriod = ISNULL(@FPeriod,'')
	SET @FPeriod = LTRIM(RTRIM(@FPeriod))
	SET @plant = 'ALL'
	SET @top = 25
--	SET @Type = 'MORE'

	IF @top = 0 
		SET @sqlString = 'SELECT * FROM dbo.EXR2_Fixed_All_projects_by_MAT_percentage WHERE FYear = '+''''+@FYear+''''+' and isnull(MATCost,0) > 0 AND ISNULL(UNITPRICE,0) > 0 '
	ELSE
		SET @sqlString = 'SELECT TOP '+@top+' * FROM dbo.EXR2_Fixed_All_projects_by_MAT_percentage WHERE FYear = '+''''+@FYear+''''+' and isnull(MATCost,0) > 0  AND ISNULL(UNITPRICE,0) > 0 '

	IF @FPeriod <> 'P'
		SET @sqlString = @sqlString +' AND Period = '+''''+@FPeriod+''''

	IF @plant <> 'ALL'
		SET @sqlString = @sqlString +' AND Plant = '+''''+@plant+''''

	IF @Type = 'MORE'
		--SET @sqlString = @sqlString +' AND PERCENTAGE >=0.65  ORDER BY SalesAmount desc,OEM_NAME,PERCENTAGE DESC'  -- 2012-08-13 add one condition amount > 5K
		SET @sqlString = @sqlString +' AND PERCENTAGE >=0.65 and SalesAmount > 5000 ORDER BY SalesAmount desc,OEM_NAME,PERCENTAGE DESC'

	IF @Type = 'LESS'
		SET @sqlString = @sqlString +' AND PERCENTAGE < 0.65 ORDER BY SalesAmount desc,PERCENTAGE DESC'

	IF @Type = 'ALL'
		SET @sqlString = @sqlString +' ORDER BY SalesAmount DESC,PERCENTAGE DESC'

	PRINT @sqlString
	EXECUTE(@sqlString)
END



GO
