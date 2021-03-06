USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[ManageReportAnalysis_sp_Query_Percentage_Detail]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- ============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ManageReportAnalysis_sp_Query_Percentage_Detail]
	@FYear		NVARCHAR(10),
	@FPeriod	NVARCHAR(10),
	@plant		NVARCHAR(15),
	@Project	NVARCHAR(35)
AS
BEGIN

	SET NOCOUNT ON;
	
	DECLARE		@FISCAL_YEAR	NVARCHAR(10)
	DECLARE		@FISCAL_PERIOD	NVARCHAR(10)
	DECLARE		@PERIOD_START_DATE DATETIME

	SET @FYear	 = ISNULL(@FYear,'')
	SET @FPeriod = ISNULL(@FPeriod,'')
	SET @plant   = ISNULL(@plant,'')
	SET @Project = ISNULL(@Project,'')

	SET @FISCAL_YEAR	  = cast(cast(RIGHT(@FYear,4) as int) - 1 as nvarchar(10))

	IF (LEFT(RIGHT(@FPeriod,4),1)) = '('		--(P1)
		SET @FISCAL_PERIOD = LEFT(RIGHT(@FPeriod,2),1)
	ELSE										--(P10)
		SET @FISCAL_PERIOD =  LEFT(RIGHT(@FPeriod,3),2)

-- =========================  Get details data  =========================
	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb..#tempfscpp711') AND TYPE = 'U')
		DROP TABLE #tempfscpp711
	SELECT T$PLNT,T$ITEM,T$ORNO,T$PONO,T$COTP,T$PRIC,T$TQUA,T$AMNT INTO #tempfscpp711 FROM FactoryLoading.dbo.TFSCPP711180 where 1 <> 1

	IF @plant = 'B1'
		BEGIN
			INSERT INTO #tempfscpp711
			SELECT T$PLNT,T$ITEM,T$ORNO,T$PONO,T$COTP,T$PRIC,T$TQUA,T$AMNT FROM FactoryLoading.dbo.TFSCPP711180 
			WHERE  T$YEAR = @FISCAL_YEAR AND T$PRNO = @FISCAL_PERIOD 
			AND    T$ITEM = @Project AND T$PLNT = 'P2'
		END
	ELSE
		BEGIN
			INSERT INTO #tempfscpp711
			SELECT T$PLNT,T$ITEM,T$ORNO,T$PONO,T$COTP,T$PRIC,T$TQUA,T$AMNT FROM FactoryLoading.dbo.TFSCPP711180 
			WHERE  T$YEAR = @FISCAL_YEAR AND T$PRNO = @FISCAL_PERIOD 
			AND    T$ITEM = @Project AND T$PLNT = @plant
		END

	ALTER TABLE #tempfscpp711 ADD OEM_Name NVARCHAR(55)
	UPDATE #tempfscpp711 SET OEM_Name = (SELECT x.OEM_Name FROM dbo.CostItemMatchOEM as x WHERE x.item = #tempfscpp711.T$ITEM)

	ALTER TABLE #tempfscpp711 ADD COST FLOAT

	UPDATE #tempfscpp711 set COST = FactoryLoading.dbo.ManageReportAnalysis_sp_Query_Material_Cost(@Project,@plant,RIGHT(@FYear,4),@FISCAL_PERIOD,'EXCLUDE')

	ALTER TABLE #tempfscpp711 ADD CostVsPrice FLOAT
	UPDATE #tempfscpp711 set CostVsPrice = CAST(COST/CASE T$PRIC WHEN 0 THEN 1 ELSE T$PRIC END AS DECIMAL(18,4))

-- =========================  Get Result data  =========================

	SELECT * FROM #tempfscpp711 

END


GO
