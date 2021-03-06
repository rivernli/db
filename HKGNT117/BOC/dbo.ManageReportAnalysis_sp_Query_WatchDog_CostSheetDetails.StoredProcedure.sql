USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[ManageReportAnalysis_sp_Query_WatchDog_CostSheetDetails]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Sun Zhang>
-- Create date: <4/13/2011>
-- Description:	<Watch_Dog>
-- =============================================
CREATE PROCEDURE [dbo].[ManageReportAnalysis_sp_Query_WatchDog_CostSheetDetails]
@Plant		nvarchar(10),
@Project	nvarchar(30),
@FYear		nvarchar(10),
@FPeriod	nvarchar(10)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE	@sqlString		NVARCHAR(MAX),@Period INT
	DECLARE	@Confirm_date	DATETIME

	SET @Plant	 = ISNULL(@Plant,  '')
	SET @Project = ISNULL(@Project,'')
	SET @FYear	 = ISNULL(@FYear,  '')
	SET @FPeriod = ISNULL(@FPeriod,'')

	IF len(@FPeriod) = 3
		SET @Period = SUBSTRING(@FPeriod,2,2)
	ELSE
		SET @Period = SUBSTRING(@FPeriod,2,1)

	SELECT @Confirm_date = calenderDate FROM ce3p1179.dbo.Calender WHERE FiscalYearDesc = @FYear AND FiscalPeriod = @Period

	IF @Plant = 'B1' 
		SET @Plant = 'P2'
	
	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#tempbom') AND TYPE = 'U')
		DROP TABLE #tempbom

	SELECT * INTO #tempbom FROM FactoryLoading.dbo.TFSBOM400180  WHERE 1 <> 1

	INSERT INTO #tempbom
	SELECT TOP 1 * FROM FactoryLoading.dbo.TFSBOM400180 
	WHERE T$PLNT = @Plant
	AND T$PJNO LIKE @Project+'%'
	AND	T$STAT = 2
	AND	T$LCDT <= @Confirm_date
	ORDER BY T$LCDT DESC

	IF NOT EXISTS(SELECT * FROM #tempbom)
		BEGIN
			INSERT INTO #tempbom
			SELECT TOP 1 * FROM FactoryLoading.dbo.TFSBOM400180 
			WHERE T$PLNT = @Plant
			AND T$PJNO LIKE @Project+'%'
			AND	T$STAT = 2
			AND	T$LCDT >= @Confirm_date
			ORDER BY T$LCDT	ASC
		END

	SELECT * FROM #tempbom
END

GO
