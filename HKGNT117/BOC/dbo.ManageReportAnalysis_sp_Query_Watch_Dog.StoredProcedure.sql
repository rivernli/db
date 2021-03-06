USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[ManageReportAnalysis_sp_Query_Watch_Dog]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Sun Zhang>
-- Create date: <4/13/2011>
-- Description:	<Watch_Dog>
-- =============================================
CREATE PROCEDURE [dbo].[ManageReportAnalysis_sp_Query_Watch_Dog]
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
	SET @top = 10
--	SET @Type = 'MORE'

	IF @top = 0 
		SET @sqlString = 'SELECT *,cast(isnull(t$cesu,0) / case isnull(UnitPrice,0) when 0 then 1 else UnitPrice end  as decimal(18,4)) AS PERCENTAGE,(select X.OEM_Name from dbo.CostItemMatchOEM AS X where X.item = project)AS OEM_NAME FROM dbo.CostDetail WHERE FYear = '+''''+@FYear+''''+' and isnull(t$cesu,0) > 0 AND ISNULL(UNITPRICE,0) > 0 '
	ELSE
		SET @sqlString = 'SELECT TOP '+@top+' *,cast(isnull(t$cesu,0) / case isnull(UnitPrice,0) when 0 then 1 else UnitPrice end  as decimal(18,4)) AS PERCENTAGE,(select X.OEM_Name from dbo.CostItemMatchOEM AS X where X.item = project)AS OEM_NAME FROM dbo.CostDetail WHERE FYear = '+''''+@FYear+''''+' and isnull(t$cesu,0) > 0  AND ISNULL(UNITPRICE,0) > 0 '

	IF @FPeriod <> 'P'
		SET @sqlString = @sqlString +' AND Period = '+''''+@FPeriod+''''

	IF @plant <> 'ALL'
		SET @sqlString = @sqlString +' AND Plant = '+''''+@plant+''''

	IF @Type = 'MORE'
		SET @sqlString = @sqlString +' AND cast(isnull(t$cesu,0) / case isnull(UnitPrice,0) when 0 then 1 else UnitPrice end  as decimal(18,4)) >=0.65  ORDER BY SalesAmount desc,OEM_NAME,PERCENTAGE DESC'

	IF @Type = 'LESS'
		SET @sqlString = @sqlString +' AND cast(isnull(t$cesu,0) / case isnull(UnitPrice,0) when 0 then 1 else UnitPrice end  as decimal(18,4)) < 0.65 ORDER BY SalesAmount desc,PERCENTAGE DESC'

	IF @Type = 'ALL'
		SET @sqlString = @sqlString +' ORDER BY SalesAmount DESC,PERCENTAGE DESC'

	PRINT @sqlString
	EXECUTE(@sqlString)
END

GO
