USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[EXR2_sp_Query_Total_Percentage]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[EXR2_sp_Query_Total_Percentage]
	@FYear   nvarchar(10),
	@FPeriod nvarchar(10),
	@Plant   nvarchar(15),
	@Type	 nvarchar(50)
AS
BEGIN
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE	@AmountMore FLOAT,@AmountMid FLOAT,@AmountLess FLOAT
	DECLARE	@sqlString	NVARCHAR(MAX)

	SET @FYear = ISNULL(@FYear,'')
	IF  @FYear = ''
		BEGIN
			RAISERROR('Year can not empty !',16,1)
			RETURN
		END

	SET @FPeriod = ISNULL(@FPeriod,'')
	SET @plant   = ISNULL(@plant  ,'')

--====================================================================================================================

	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#tempDetails') AND TYPE = 'U')
		DROP TABLE #tempDetails

	SELECT * INTO #tempDetails FROM dbo.EXR2_Details WHERE FYEAR = @FYear AND unitprice <> 0

	IF @FPeriod <> 'ALL'
		BEGIN
			DELETE #tempDetails WHERE PERIOD <> @FPeriod
		END

	IF @plant <> 'ALL'
		BEGIN
			DELETE #tempDetails WHERE PLANT <> @plant
		END

	ALTER TABLE #tempDetails ADD PERCENTAGE FLOAT
	UPDATE #tempDetails SET PERCENTAGE = CAST((t$cesu/unitprice) AS FLOAT)

--====================================================================================================================

	IF @TYPE = 'SalesAmount'
		BEGIN
			SELECT @AmountLess = SUM(salesamount) FROM #tempDetails WHERE  PERCENTAGE < 0.5
			SELECT @AmountMid  = SUM(salesamount) FROM #tempDetails WHERE  PERCENTAGE >= 0.5 AND PERCENTAGE < 0.65
			SELECT @AmountMore = SUM(salesamount) FROM #tempDetails WHERE  PERCENTAGE >= 0.65
		END
	IF @TYPE = 'SQFT'
		BEGIN
			SELECT @AmountLess = SUM([ShipmentArea(SQFT)]) FROM #tempDetails WHERE  PERCENTAGE < 0.5
			SELECT @AmountMid  = SUM([ShipmentArea(SQFT)]) FROM #tempDetails WHERE  PERCENTAGE >= 0.5 AND PERCENTAGE < 0.65
			SELECT @AmountMore = SUM([ShipmentArea(SQFT)]) FROM #tempDetails WHERE  PERCENTAGE >= 0.65
		END
	IF @TYPE = 'Quantity'
		BEGIN
			SELECT @AmountLess = SUM(ShipmentQty) FROM #tempDetails WHERE  PERCENTAGE < 0.5
			SELECT @AmountMid  = SUM(ShipmentQty) FROM #tempDetails WHERE  PERCENTAGE >= 0.5 AND PERCENTAGE < 0.65
			SELECT @AmountMore = SUM(ShipmentQty) FROM #tempDetails WHERE  PERCENTAGE >= 0.65
		END
--====================================================================================================================

	SELECT @AmountLess AS LESS,cast(@AmountLess/(@AmountLess + @AmountMid + @AmountMore)*100 as decimal(18,2)) AS LESS_PER,@AmountMid AS MID,cast(@AmountMid/((@AmountLess + @AmountMid + @AmountMore))*100 as decimal(18,2)) AS MID_PER,@AmountMore AS MORE ,cast(@AmountMore /(@AmountLess + @AmountMid + @AmountMore)*100 as decimal(18,2)) AS MORE_PER ,(@AmountLess + @AmountMid + @AmountMore) AS  TOTAL

END

GO
