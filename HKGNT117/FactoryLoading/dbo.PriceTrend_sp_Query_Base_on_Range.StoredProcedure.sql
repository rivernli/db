USE [FactoryLoading]
GO
/****** Object:  StoredProcedure [dbo].[PriceTrend_sp_Query_Base_on_Range]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Rivern Li>
-- Create date: <Create Date,2010/03/26,>
-- Description:	<Description,Purchase Report,>
-- =============================================
CREATE PROCEDURE [dbo].[PriceTrend_sp_Query_Base_on_Range]
	@Plant					NVARCHAR(5),
	@YearFROM				INT,
	@YearTo					INT,
	@PeriodFROM				INT,
	@PeriodTo				INT,
	@Base_on_FYear			INT,
	@Base_on_FPeriod		INT,
	@Range					INT,
	@Item					nvarchar(50),
	@OEM					nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;

--****************************** Valiable declaration section ***************************
--declaration

	DECLARE @DateFROM		DATETIME
	DECLARE @DateTo			DATETIME
	DECLARE @Temp_Fyear		INT
	DECLARE @Temp_Period	INT
	DECLARE @Period_Count	INT
	DECLARE @sqlString		NVARCHAR(max)
	DECLARE	@LoopCount		INT,@Loop	INT
	DECLARE	@TempYear		INT
	DECLARE	@TempPeriod		INT
	DECLARE	@TempYear1		INT
	DECLARE	@TempPeriod1	INT
	DECLARE @tempField		nvarchar(1000)
	DECLARE	@START_TIME		DATETIME
	DECLARE	@START_END		DATETIME

--	SET @START_TIME = GETDATE()
--	print '1:'
--	PRINT @START_TIME 
--****************************** field section ******************************************

	SET @Plant				=	ISNULL(@Plant,'')
	SET @YearFROM			=	ISNULL(@yearFROM,0)
	SET @YearTo				=	ISNULL(@YearTo,0)
	SET @PeriodFROM			=	ISNULL(@PeriodFROM,0)
	SET @PeriodTo			=	ISNULL(@PeriodTo,0)
	SET @Base_on_FYear		=	ISNULL(@Base_on_FYear,0)
	SET @Base_on_FPeriod	=	ISNULL(@Base_on_FPeriod,0)
	SET @Range				=	ISNULL(@Range,0)
	SET	@TempYear			=   @YearFROM
	SET @TempPeriod			=   @PeriodFROM
	SET	@TempYear1			=   @YearFROM
	SET @TempPeriod1		=   @PeriodFROM
	SET @Item				=	ISNULL(@ITEM,'')
	SET @OEM				=   ISNULL(@OEM,'')

--****************************** choice section ******************************************

	IF @YearFROM > @YearTo
		BEGIN
			RAISERROR('Year To can not less Year FROM !',16,1)
			RETURN
		END

	IF @YearFROM = @YearTo AND @PeriodFROM > @PeriodTo
		BEGIN
			RAISERROR('Period issue,please check it !',16,1)
			RETURN
		END		

	IF @YearFROM = 0 OR @YearTo = 0 
		BEGIN
			RAISERROR('Year cannot be empty!',16,1)
			RETURN
		END

	IF @PeriodFROM = 0 OR @PeriodTo = 0
		BEGIN
			RAISERROR('Period cannot be empty!',16,1)
			RETURN
		END	

	IF @Range = 0
		BEGIN
			RAISERROR('Please enter a Range which more the 1 !',16,1)
			RETURN
		END			

--****************************** Variable section ******************************************

	IF @YearFROM = @YearTo
		SET @Loop = @PeriodTo - @PeriodFROM + 1

	IF @YearFROM < @YearTo
		SET @Loop = (@YearTo - @YearFROM) * 12 - @PeriodFROM + @PeriodTo + 1

	SET @LoopCount = @Loop

	IF	@plant = 'B1'
		SET @plant = 'P'

--****************************** Function section ******************************************
-- Get Data to temp table 

	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'temp..#saleperiod') AND TYPE = 'U')
		DROP TABLE #saleperiod

	CREATE TABLE #saleperiod(Item NVARCHAR(50),Price FLOAT,Customer	NVARCHAR(50),Delivery NVARCHAR(50),Delivery_Term NVARCHAR(50),Del_Qty FLOAT,FYear INT,FPeriod INT)
	CREATE INDEX INDEX_YEAR   ON #saleperiod(FYear)
	CREATE INDEX INDEX_Period ON #saleperiod(FPeriod)
	CREATE INDEX INDEX_Item   ON #saleperiod(Item)

	WHILE @Loop > 0 
		BEGIN
			-- Get Period Start Date & End Date
			SELECT @DateFROM = T$STDT FROM dbo.TTFGLD005180 WHERE T$YEAR = @tempYear AND T$PRNO = @tempPeriod AND T$PTYP = 1
			SET @TempPeriod = @TempPeriod + 1
			IF  @TempPeriod > 12
				BEGIN
					SET @TempYear = @TempYear + 1
					SET @TempPeriod = 1
				END
			SELECT @DateTo   = t$stdt FROM dbo.TTFGLD005180 WHERE T$YEAR = @TempYear AND T$PRNO = @TempPeriod AND T$PTYP = 1
			SET @DateTo = @DateTo - 1 

			-- Get Data to temp table 
			IF @PLANT <> 'ALL'
				BEGIN
					INSERT INTO #saleperiod
					SELECT A.T$ITEM,A.T$PRIC,ISNULL(A.T$CUNO,''),ISNULL(A.T$CDEL,''),ISNULL(B.T$CDEC,'') AS Delivery_Term,sum(A.T$TQUA) as Del_Qty,@tempYear1 as Year,@tempPeriod1 as Period
					FROM dbo.TFSCPP711180 AS A
					LEFT JOIN dbo.TTDSLS040180 as b on b.t$orno = a.t$orno
					WHERE A.T$ASDT between @DateFROM AND @DateTo
					AND	  A.T$ITEM LIKE '%'+LTRIM(RTRIM(@Item))+'%'
					AND   A.T$ITEM NOT LIKE 'TTC%'
					AND   A.T$ITEM NOT LIKE 'TCC%'
					AND   A.T$COTP <> 'RPL'
					AND	  A.T$PLNT like @plant+'%'
					GROUP BY A.T$ITEM,A.T$PRIC,ISNULL(A.T$CUNO,''),ISNULL(A.T$CDEL,''),ISNULL(B.T$CDEC,'')
					ORDER BY A.T$ITEM,A.T$PRIC,ISNULL(A.T$CUNO,''),ISNULL(A.T$CDEL,''),ISNULL(B.T$CDEC,'')
				END
			ELSE
				BEGIN
					INSERT INTO #saleperiod
					SELECT A.T$ITEM,A.T$PRIC,ISNULL(A.T$CUNO,''),ISNULL(A.T$CDEL,''),ISNULL(B.T$CDEC,'') AS Delivery_Term,sum(A.T$TQUA) as Del_Qty,@tempYear1 as Year,@tempPeriod1 as Period
					FROM dbo.TFSCPP711180 AS A
					LEFT JOIN dbo.TTDSLS040180 as b on b.t$orno = a.t$orno
					WHERE A.T$ASDT between @DateFROM AND @DateTo
					AND	  A.T$ITEM LIKE '%'+LTRIM(RTRIM(@Item))+'%'
					AND   A.T$ITEM NOT LIKE 'TTC%'
					AND   A.T$ITEM NOT LIKE 'TCC%'
					AND   A.T$COTP <> 'RPL'
					GROUP BY A.T$ITEM,A.T$PRIC,ISNULL(A.T$CUNO,''),ISNULL(A.T$CDEL,''),ISNULL(B.T$CDEC,'')
					ORDER BY A.T$ITEM,A.T$PRIC,ISNULL(A.T$CUNO,''),ISNULL(A.T$CDEL,''),ISNULL(B.T$CDEC,'')
				END
			SET @Loop   = @Loop - 1
			SET @TempPeriod1 = @TempPeriod1 + 1
			IF  @TempPeriod1 > 12
				BEGIN
					SET @TempYear1 = @TempYear1 + 1
					SET @TempPeriod1 = 1
				END
		END

--print '2:'
--SET @START_END = GETDATE()
--print   DATEDIFF(ms,   @START_TIME,   getdate()) 
-- Get Period range Data to Temp Table 

	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#tfscpp711180_range') AND TYPE = 'U')
		DROP TABLE #tfscpp711180_range

	-- Get Range Date range , Date FROM , Date to
	SET	@TempYear	= @Base_on_FYear
	SET @TempPeriod	= @Base_on_FPeriod

	-- Find Period to last date 
	SET @TempPeriod = @TempPeriod + 1
	IF  @TempPeriod > 12
		BEGIN
			SET @TempYear   = @TempYear + 1
			SET @TempPeriod = 1
		END

	SELECT @DateFROM = T$STDT FROM dbo.TTFGLD005180 WHERE T$YEAR = @tempYear AND T$PRNO = @tempPeriod AND T$PTYP = 1
	SET @DateFROM = @DateFROM - 1

	SET @Loop = @Range

	WHILE @Loop > 0
		BEGIN
			SET @TempPeriod = @TempPeriod - 1
			IF  @TempPeriod = 0
				BEGIN
					SET @TempYear   = @TempYear - 1
					SET @TempPeriod = 12
				END
			SET @Loop = @Loop - 1
		END

	SELECT @DateTo   = T$STDT FROM dbo.TTFGLD005180 WHERE T$YEAR = @TempYear AND T$PRNO = @TempPeriod AND T$PTYP = 1

	SELECT	A.T$ITEM,A.T$ASDT,A.T$PRIC INTO	#tfscpp711180_range FROM dbo.TFSCPP711180 AS A
	WHERE	A.T$ASDT BETWEEN @DateTo AND @DateFROM
	AND		A.T$ITEM NOT LIKE 'TTC%'
	AND		A.T$ITEM NOT LIKE 'TCC%'
	AND		A.T$COTP <> 'RPL'
	AND		A.T$PRIC <> 0
	GROUP BY A.T$ITEM,A.T$ASDT,A.T$PRIC

--print '3:'
--print   DATEDIFF(ms,   @START_TIME,   getdate()) 
-- Integrate difference price to one column in same period , For example "2.3,2.6"

	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#temp1') AND TYPE = 'U')
		DROP TABLE #temp1

	SELECT * INTO #temp1 FROM #saleperiod A
	OUTER APPLY(SELECT unitPrice = STUFF(REPLACE(REPLACE(
					(
						select distinct cast(price as nvarchar(10)) as unitPrice FROM #saleperiod N
						where  Item     = A.Item
						and	   Fyear    = A.Fyear
						and	   Fperiod  = A.Fperiod
						and	   Customer = A.Customer
						and	   Delivery = A.Delivery
						and	   Delivery_Term = A.Delivery_Term
						FOR XML AUTO
					), '<N UnitPrice="', ','), '"/>', ''), 1, 1, ''), 
					DelQuantity = stuff(replace(replace(
					(
						select cast(Del_Qty as nvarchar(20)) as DelQuantity FROM #saleperiod N
						where  Item     = A.Item
						and	   Fyear    = A.Fyear
						and	   Fperiod  = A.Fperiod
						and	   Customer = A.Customer
						and	   Delivery = A.Delivery
						and	   Delivery_Term = A.Delivery_Term
						FOR XML AUTO
					), '<N DelQuantity="', ','), '"/>', ''), 1, 1, '')
				)N

	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#tempSaleperiod') AND TYPE = 'U')
		DROP TABLE #tempSaleperiod

	SELECT DISTINCT FYear,FPeriod,Item,Customer,Delivery,Delivery_Term,unitPrice AS price,DelQuantity AS Del_Qty
	INTO #tempSaleperiod
	FROM #temp1

--print '4:'
--print   DATEDIFF(ms,   @START_TIME,   getdate()) 
--select * from #tempSaleperiod

-- Povit data to P01,P02,P03... Format

	SET	   @TempYear	   = @YearFrom
	SET    @TempPeriod     = @PeriodFrom
	SET	   @Loop		   = @LoopCount

	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#saleperiodResult') AND TYPE = 'U')
		DROP TABLE #saleperiodResult

	CREATE TABLE #saleperiodResult(Item	NVARCHAR(50),Customer NVARCHAR(50),Delivery	NVARCHAR(50),Delivery_Term	NVARCHAR(50))
	INSERT INTO  #saleperiodResult(Item,Customer,Delivery,Delivery_Term) SELECT DISTINCT a.Item,a.Customer,a.Delivery,a.Delivery_Term FROM #tempSaleperiod AS a
	ALTER TABLE #saleperiodResult ADD OEM_NAME NVARCHAR(100)
	UPDATE #saleperiodResult SET OEM_NAME = (SELECT X.T$DESC FROM DataWarehouse.dbo.Item_OEM AS X WHERE X.T$ITEM = #saleperiodResult.ITEM)
	CREATE INDEX PK_ITEM ON #saleperiodResult(ITEM)
	CREATE INDEX PK_Customer ON #saleperiodResult(Customer)
	CREATE INDEX PK_Delivery ON #saleperiodResult(Delivery)
	CREATE INDEX PK_ITEM ON #tempSaleperiod(ITEM)
	CREATE INDEX PK_Customer ON #tempSaleperiod(Customer)
	CREATE INDEX PK_Delivery ON #tempSaleperiod(Delivery)

	WHILE @Loop > 0
		BEGIN
			-- DYNAMIC ADD PERIOD FIELD 
			SET @tempField = 'FY'+cast(@TempYear AS NVARCHAR(5))+'P'+cast(@TempPeriod AS NVARCHAR(5))+'_Price'
			SET @sqlString = 'ALTER TABLE #saleperiodResult ADD '+@tempField+' NVARCHAR(100)'
			EXECUTE(@sqlString)

			SET @sqlString = 
			'UPDATE #saleperiodResult 
			SET '+@tempField+'=b.Price 
			FROM #saleperiodResult as a,#tempSaleperiod as b 
			where a.Item = b.Item 
			AND a.Customer = b.Customer 
			AND a.Delivery = b.Delivery 
			AND a.Delivery_Term = b.Delivery_Term 
			AND a.'+@tempField+' is null 
			AND b.price not in (select '+@tempField+' FROM #saleperiodResult as c where c.Item = b.item AND '+@tempField+' = b.price)
			AND b.FYear='+cast(@TempYear AS NVARCHAR(5))+' 
			AND b.FPeriod = '+cast(@TempPeriod AS NVARCHAR(5))
			EXECUTE(@sqlString)

			SET @tempField = 'FY'+cast(@TempYear AS NVARCHAR(5))+'P'+cast(@TempPeriod AS NVARCHAR(5))+'_Del_Qty'
			SET @sqlString = 'ALTER TABLE #saleperiodResult add '+@tempField+' nvarchar(100)'
			EXECUTE(@sqlString)

			SET @sqlString = 
			'UPDATE #saleperiodResult 
			SET '+@tempField+'=b.Del_Qty 
			FROM #saleperiodResult as a,#tempSaleperiod as b 
			WHERE a.Item = b.Item 
			AND a.Customer = b.Customer 
			AND a.Delivery = b.Delivery 
			AND a.Delivery_Term = b.Delivery_Term 
			AND a.'+@tempField+' is null 
			AND b.Del_Qty not in (select FY'+cast(@TempYear AS NVARCHAR(5))+'P'+cast(@TempPeriod AS NVARCHAR(5))+'_Del_Qty FROM #saleperiodResult as c where c.Item = b.item AND '+@tempField+' = b.price)
			AND b.FYear   = '+cast(@TempYear   AS NVARCHAR(5))+' 
			AND b.FPeriod = '+cast(@TempPeriod AS NVARCHAR(5))
			EXECUTE(@sqlString)

			SET @TempPeriod = @TempPeriod + 1
			IF @TempPeriod > 12
				BEGIN
					SET @TempYear = @TempYear + 1
					SET @TempPeriod = 1
				END
			SET @Loop = @Loop - 1
		END

--print '5:'
--print   DATEDIFF(ms,   @START_TIME,   getdate()) 
---- GET DIFFERENCE DATA TO TEMP TABLE

	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'temp..#tempDifference') AND TYPE = 'U')
		DROP TABLE #tempDifference

	SELECT Item,SUM(ISNULL(Price,0) * ISNULL(Del_Qty,0)) AS SalesAmount,0 AS BaseOnPrice,SUM(ISNULL(Del_Qty,0)) AS Del_Qty,0.00 AS Defference
	INTO #tempDifference FROM #saleperiod
	GROUP BY Item

	ALTER TABLE #tempDifference ALTER COLUMN BaseOnPrice FLOAT
	ALTER TABLE #tempDifference ALTER COLUMN Defference  FLOAT

	UPDATE #tempDifference SET BaseOnPrice = ISNULL((SELECT TOP 1 T$PRIC FROM #tfscpp711180_range AS X WHERE X.T$ITEM = #tempDifference.ITEM ORDER BY T$ASDT DESC),0)
	UPDATE #tempDifference SET Defference  = CAST((ISNULL(SalesAmount,0) - ISNULL(BaseOnPrice,0) * ISNULL(Del_Qty,0)) AS DECIMAL(18,2))

	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'temp..#tempDifferenceSort') AND TYPE = 'U')
		DROP TABLE #tempDifferenceSort

	SELECT * INTO #tempDifferenceSort FROM #tempDifference WHERE 1 <> 1
	ALTER   TABLE #tempDifferenceSort  ADD ID INT IDENTITY
	INSERT  INTO  #tempDifferenceSort(ITEM,BaseOnPrice,Defference) SELECT Item,BaseOnPrice,Defference FROM #tempDifference ORDER BY Defference DESC

--print '6:'
--print   DATEDIFF(ms,   @START_TIME,   getdate()) 
-- Show final result

	ALTER  TABLE #saleperiodResult ADD BaseOnPrice FLOAT
	ALTER  TABLE #saleperiodResult ADD Defference  FLOAT
	ALTER  TABLE #saleperiodResult ADD ID INT
	CREATE INDEX PK_ID ON #saleperiodResult (ID) 
	CREATE INDEX PK_BaseOnPrice ON #saleperiodResult (BaseOnPrice) 

	UPDATE #saleperiodResult SET ID = (SELECT ID FROM #tempDifferenceSort AS X WHERE X.Item = #saleperiodResult.Item)

	INSERT INTO #saleperiodResult(ID,Item,BaseOnPrice,Defference) SELECT ID,Item,BaseOnPrice,Defference FROM #tempDifferenceSort 
	UPDATE #saleperiodResult SET OEM_NAME = (SELECT X.T$DESC FROM DataWarehouse.dbo.Item_OEM AS X WHERE X.T$ITEM = #saleperiodResult.ITEM)

	SELECT * FROM #saleperiodResult 
	WHERE OEM_NAME LIKE N'%'+LTRIM(RTRIM(@OEM))+'%' 
--	AND ITEM LIKE N'%'+@ITEM+'%' 
--	AND (BaseOnPrice IS NOT NULL OR BaseOnPrice  <> 0)
	ORDER BY ID,baseOnPrice 

--print '7:'
--print   DATEDIFF(ms,   @START_TIME,   getdate()) 

END



GO
