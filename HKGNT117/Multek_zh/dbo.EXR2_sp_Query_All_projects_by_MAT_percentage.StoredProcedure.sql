USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[EXR2_sp_Query_All_projects_by_MAT_percentage]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[EXR2_sp_Query_All_projects_by_MAT_percentage]
	@FYear   nvarchar(10),
	@FPeriod nvarchar(10),
	@plant   nvarchar(15),
	@top     nvarchar(10),
	@Type    nvarchar(30)
AS
BEGIN

	SET NOCOUNT ON;
	DECLARE @sqlString nvarchar(1000)
	SET @FPeriod = ISNULL(@FPeriod,'')
	SET @FPeriod = LTRIM(RTRIM(@FPeriod))

	IF @top = 0 
		SET @sqlString = 'SELECT * FROM dbo.EXR2_Fixed_All_projects_by_MAT_percentage WHERE FYear = '+''''+@FYear+''''+' and isnull(MATCost,0) > 0 AND ISNULL(UNITPRICE,0) > 0 '
	ELSE
		SET @sqlString = 'SELECT TOP '+@top+' * FROM dbo.EXR2_Fixed_All_projects_by_MAT_percentage WHERE FYear = '+''''+@FYear+''''+' and isnull(MATCost,0) > 0  AND ISNULL(UNITPRICE,0) > 0 '

	IF @FPeriod <> 'P'
		SET @sqlString = @sqlString +' AND Period = '+''''+@FPeriod+''''

	IF @plant <> 'ALL'
		SET @sqlString = @sqlString +' AND Plant = '+''''+@plant+''''

	IF @Type = 'MORE'
		SET @sqlString = @sqlString +' AND PERCENTAGE >=0.65  ORDER BY SalesAmount desc,OEM_NAME,PERCENTAGE DESC'

	IF @Type = 'LESS'
		SET @sqlString = @sqlString +' AND PERCENTAGE < 0.65 ORDER BY SalesAmount desc,PERCENTAGE DESC'

	IF @Type = 'ALL'
		SET @sqlString = @sqlString +' ORDER BY SalesAmount DESC,PERCENTAGE DESC'

	PRINT @sqlString
	EXECUTE(@sqlString)
END

GO
