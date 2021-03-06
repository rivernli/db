USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[ManageReportAnalysis_sp_QueryPurchaseTrend]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



/*=====================================================

 Author:		<Author,Rivern Li>
 Create date:   <Create Date,2010/03/10>
 Description:	<Description,Purchase Data Analysis,>

======================================================*/

CREATE PROCEDURE [dbo].[ManageReportAnalysis_sp_QueryPurchaseTrend]
	-- Add the parameters for the stored procedure here
	@Issue_batchNo			NVARCHAR(20),
	@Forecast_YearFrom		NVARCHAR(5),
	@Forecast_YearTo		NVARCHAR(5),
	@Forecast_PeriodFrom	NVARCHAR(5),
	@Forecast_PeriodTo		NVARCHAR(5),
	@Item_Group_From		NVARCHAR(5),
	@Item_Group_To			NVARCHAR(5),
	@Vendor_From			NVARCHAR(5),
	@Vendor_To				NVARCHAR(5),
	@Plant_From				NVARCHAR(5),
	@Plant_To				NVARCHAR(5)
	--@Type NVARCHAR(20)
AS
BEGIN
	SET NOCOUNT ON

/****************************** Valiable declaration section ***************************/
--declaration

		DECLARE @i				INT
		DECLARE @Loop			INT
		DECLARE @Temp_Fyear		INT
		DECLARE @Temp_Period	INT
		DECLARE	@Period_Count	INT
		DECLARE @sqlString		NVARCHAR(1000)

/****************************** field section ******************************************/

    -- Condition data check
		SET @Issue_batchNo =		ISNULL(@Issue_batchNo,'')
		SET @Forecast_YearFrom =	ISNULL(@Forecast_YearFrom,'')
		SET @Forecast_YearTo =		ISNULL(@Forecast_YearTo,'')
		SET @Forecast_PeriodFrom =	ISNULL(@Forecast_PeriodFrom,'')
		SET @Forecast_PeriodTo =	ISNULL(@Forecast_PeriodTo,'')
		SET @Item_Group_From =		ISNULL(@Item_Group_From,'')
		SET @Item_Group_To =		ISNULL(@Item_Group_To,'')
		SET @Vendor_From =			ISNULL(@Vendor_From,'')
		SET @Vendor_To =			ISNULL(@Vendor_To,'')
		SET @Plant_From =			ISNULL(@Plant_From,'')
		SET @Plant_To =				ISNULL(@Plant_To,'')

		IF @Forecast_YearFrom > @Forecast_YearTo
			BEGIN
				raiserror('Base On Range Error !',16,1)
				return
			END

		IF @Forecast_YearFrom = @Forecast_YearTo and cast(@Forecast_PeriodFrom as INT)> cast(@Forecast_PeriodTo as INT)
			BEGIN
				raiserror('Base On Range Error !',16,1)
				return
			END

		if @Forecast_YearFrom = '' or @Forecast_YearFrom = '0' or @Forecast_YearFrom is null OR @Forecast_YearTo = '' or @Forecast_YearTo = '0' or @Forecast_YearTo is null
			BEGIN
				RAISERROR('Year cannot be empty!',16,1)
				RETURN
			END

		IF @Forecast_PeriodFrom = '' OR @Forecast_PeriodFrom = '0' OR @Forecast_PeriodFrom IS NULL or @Forecast_PeriodTo = '' OR @Forecast_PeriodTo = '0' OR @Forecast_PeriodTo IS NULL
			BEGIN
				RAISERROR('Period cannot be empty!',16,1)
				RETURN
			END		

		IF @Item_Group_To IS NULL OR @Item_Group_To = ''
			SET @Item_Group_To = 'ZZZZZZ'

		IF @Vendor_To IS NULL OR @Vendor_To = ''
			SET @Vendor_To = 'ZZZZZZ'

		IF @Plant_To IS NULL OR @Plant_To = ''
			SET @Plant_To = 'ZZ'

	--Get Period Number
		SET @Temp_Fyear   = CAST(@Forecast_YearFrom AS INT)
		SET @Temp_Period  = CAST(@Forecast_PeriodFrom AS INT)
		SET @Period_Count = 0

		WHILE @Temp_Fyear <> @Forecast_YearTo OR @Temp_Period <> @Forecast_PeriodTo
			BEGIN
				IF @Temp_Period >= 12 
					BEGIN
						SET @Temp_Fyear = @Temp_Fyear + 1
						SET @Temp_Period = 1
					END
				ELSE
					BEGIN
						SET @Temp_Fyear = @Temp_Fyear
						SET @Temp_Period = @Temp_Period + 1
					END
				SET @Period_Count = @Period_Count + 1
			END

			--if @Period_Count = 0 
			SET @Period_Count = @Period_Count + 1

/****************************** Table declaration section *******************************/

	-- Get Data to temp table 
		if exists(select * from sysobjects where id = object_id(N'tempdb..#TFSPUR033180') and type = 'U')
			drop table #TFSPUR033180
		select * INTo #TFSPUR033180 from dbo.TFSPUR033180 where t$sern = @Issue_batchNo
		if not exists(select * from #TFSPUR033180)
			BEGIN
				RAISERROR('Batch# not found in issue history!',16,1)
				return
			END

		if exists(select * from sysobjects where id = object_id(N'tempdb..#TFSPUR034180_temp') and type = 'U')
			drop table #TFSPUR034180_temp
		select * INTo #TFSPUR034180_temp from dbo.TFSPUR034180 
		where t$sern = @Issue_batchNo 
		and	  t$suno between @Vendor_From AND @Vendor_To
		and	  rtrim(ltrim(t$citg)) between @Item_Group_From AND @Item_Group_To
		--and	  t$plnt between @Plant_From AND @Plant_To
		update #TFSPUR034180_temp set t$plnt = 'B1' where t$plnt = 'P2'
		if exists(select * from sysobjects where id = object_id(N'tempdb..#TFSPUR034180') and type = 'U')
			drop table #TFSPUR034180
		select * INTo #TFSPUR034180 from #TFSPUR034180_temp where #TFSPUR034180_temp.t$plnt between @Plant_From AND @Plant_To

		IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb..#TFSPUR035180') AND TYPE = 'U')
			DROP TABLE #TFSPUR035180
		select * INTo #TFSPUR035180 from dbo.TFSPUR035180 where t$year between @Forecast_YearFrom and @Forecast_YearTo
		update #TFSPUR035180 set t$plnt = 'B1' where t$plnt = 'P2'
		ALTER TABLE #TFSPUR035180 ADD DSCA NVARCHAR(20)
		UPDATE #TFSPUR035180 SET DSCA = (SELECT T$DSCA FROM dbo.TTCMCS023180 AS B WHERE ltrim(B.T$CITG) = ltrim(#TFSPUR035180.T$CITG))

		IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_id(N'tempdb..#TTCCOM020180') and TYPE = 'U')
			DROP TABLE #TTCCOM020180
		SELECT * INTO #TTCCOM020180 FROM dbo.TTCCOM020180

		IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_id(N'tempdb..#TTCMCS023180') and TYPE = 'U')
			DROP TABLE #TTCMCS023180
		SELECT * INTO #TTCMCS023180 FROM dbo.TTCMCS023180

		IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_id(N'tempdb..#TTDPUR_PRODUCTION_OUTPUT') and TYPE = 'U')
			DROP TABLE #TTDPUR_PRODUCTION_OUTPUT
		SELECT * INTO #TTDPUR_PRODUCTION_OUTPUT FROM dbo.TTDPUR_PRODUCTION_OUTPUT

/****************************** function section ******************************/

	-- Get basic data 

		if exists(select * from sysobjects where id = object_id(N'tempdb..#purchaseTrend') and type = 'U')
			drop table #purchaseTrend

		select a.t$sern as Batch,a.t$plnt,a.t$year as FYear,a.t$prod as FPeriod,a.t$item as PN,a.t$suno as Vendor_Code,c.T$NAMA as Vendor,a.t$citg as Item_Group,d.T$DSCA as Dsca,a.t$pric as Last_avg_Price,sum(a.t$iqty) as Qty ,sum(b.t$fqty*a.t$pric) as ForecastAmnt,sum(a.t$pric * a.t$iqty) as amnt_base_on_last,sum(a.t$cprc * a.t$iqty) as amnt_base_on_curr
		INTO #purchaseTrend 
		from #TFSPUR034180 as a left join #TFSPUR035180 as b 
		on b.t$item  = a.t$item 
		and b.t$year = a.t$year
		and	b.t$prod = a.t$prod
		and b.t$suno = a.t$suno			
		and b.t$citg = a.t$citg
		and b.t$plnt = a.t$plnt
		left join #TTCCOM020180 as c 
		on c.T$SUNO = a.T$SUNO
		left join #TTCMCS023180 as d
		on d.T$CITG = a.T$CITG
		and a.t$plnt between @Plant_From and @Plant_To
		group by a.t$sern,a.t$plnt,a.t$year,a.t$prod,a.t$item,a.t$suno,c.T$NAMA,a.t$citg ,d.T$DSCA,a.t$pric
		
--		select * from #purchaseTrend where Item_Group = ' IG201'

	-- Dynamic Get Forecast Data

		SET @Loop = 0
		SET @Temp_Fyear = @Forecast_YearFrom
		SET @Temp_Period = @Forecast_PeriodFrom

		WHILE @Loop < @Period_Count
			BEGIN
				-- Dynamic add Forecast field
				SET @sqlString = 'alter table #purchaseTrend add P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+'ForecastQty float'
				EXECUTE(@sqlString)
				SET @sqlString = 'alter table #purchaseTrend add P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+'ForecastPrice float'
				EXECUTE(@sqlString)
				SET @sqlString = 'alter table #purchaseTrend add P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+'ForecastAmount float'
				EXECUTE(@sqlString)
				SET @sqlString = 'alter table #purchaseTrend add P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+'SavingAmount float'
				EXECUTE(@sqlString)

				-- Dynamic add Actual Data
				SET @sqlString = 'alter table #purchaseTrend add P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+'ActualQty float'
				EXECUTE(@sqlString)
				SET @sqlString = 'alter table #purchaseTrend add P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+'ActualPrice float'
				EXECUTE(@sqlString)
				SET @sqlString = 'alter table #purchaseTrend add P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+'ActualAmount float'
				EXECUTE(@sqlString)
				SET @sqlString = 'alter table #purchaseTrend add P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+'ActualSavingAmount float'
				EXECUTE(@sqlString)

				-- Update Forecast data
				SET  @sqlString = 'UPDATE #purchaseTrend SET P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+'ForecastPrice = 
									(SELECT B.t$pric FROM #TFSPUR035180 AS B WHERE #purchaseTrend.PN = B.t$item AND #purchaseTrend.Vendor_Code = B.t$suno AND B.t$year = '+CAST(@Temp_Fyear AS NVARCHAR(5))
									+ ' AND B.t$prod = '+CAST(@Temp_Period AS NVARCHAR(5)) +' AND B.t$plnt = #purchaseTrend.t$plnt),

									P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+'ForecastQty = (SELECT B.t$fqty FROM #TFSPUR035180 AS B WHERE #purchaseTrend.PN = B.t$item AND #purchaseTrend.Vendor_Code = B.t$suno AND B.t$year = '+CAST(@Temp_Fyear AS NVARCHAR(5))
									+ ' AND B.t$prod = '+CAST(@Temp_Period AS NVARCHAR(5)) +'  AND B.t$plnt = #purchaseTrend.t$plnt)'
				EXECUTE(@sqlString)

				SET  @sqlString = 'UPDATE #purchaseTrend SET P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+'ForecastAmount = P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+'ForecastPrice * P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+'ForecastQty,

									P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+'SavingAmount = cast((P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+'ForecastPrice - Last_avg_Price) * Qty as decimal(18,2))'
				EXECUTE(@sqlString)

				SET @Temp_Period = @Temp_Period + 1
				IF @Temp_Period > 12
					BEGIN
						SET @Temp_Fyear = @Temp_Fyear + 1
						SET @Temp_Period = 1
					END

				SET @Loop = @Loop + 1
			END

--select * from #purchaseTrend

		-- Insert material data to result table
		DECLARE @Other_ItemGroup INT
		IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb..#RESULT') AND TYPE = 'U')
			DROP TABLE #RESULT
		SELECT Dsca INTO #RESULT FROM  #purchaseTrend	GROUP BY Dsca	ORDER BY Dsca
		INSERT INTO #RESULT(Dsca) values('TTL')

		select @Other_ItemGroup = count(*) from dbo.TTDPURItemGroup

		ALTER TABLE #RESULT ADD ID INT IDENTITY
		ALTER TABLE #RESULT ALTER COLUMN DSCA NVARCHAR(50)
		INSERT INTO #RESULT (DSCA) SELECT Itemgroup FROM dbo.TTDPURItemGroup order by id
		INSERT INTO #RESULT(Dsca)  VALUES('TTL To Sales')

		SET		@Loop		 = 0
		SET		@Temp_Fyear	 = @Forecast_YearFrom
		SET		@Temp_Period = @Forecast_PeriodFrom
		SET		@sqlString	 = ''
		DECLARE @othermaterialID INT

		SET    @othermaterialID = 0
		SELECT @othermaterialID = MAX(ID) FROM #RESULT
		IF @othermaterialID > 0
			SET @othermaterialID = @othermaterialID - @Other_ItemGroup

		/*====================== Update Manual enter material data =============================*/

		WHILE @Loop < @Period_Count
			BEGIN
			-- Forecast calculate
				-- Calculate amount base on before avage price forecast
				SET @sqlString = 'ALTER TABLE #RESULT ADD Amt_Base_avg_on_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+' decimal(18,0)'
				EXECUTE(@sqlString)

				SET @sqlString = 'ALTER TABLE #RESULT ADD Amt_Base_on_Forecast_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+' decimal(18,0)'
				EXECUTE(@sqlString)

				SET @sqlString = 'ALTER TABLE #RESULT ADD Amt_Saving_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+' float'
				EXECUTE(@sqlString)

				SET @sqlString = 'ALTER TABLE #RESULT ADD Amt_Saving_Percent_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+' NVARCHAR(20)'
				EXECUTE(@sqlString)

				-- Material  saving to Output  forecast
				SET @sqlString = 'ALTER TABLE #RESULT ADD Material_Saving_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+' NVARCHAR(20)'
				EXECUTE(@sqlString)

			-- Actual Data calculate
				SET @sqlString = 'ALTER TABLE #RESULT ADD Actual_Amt_Base_avg_on_last_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+' decimal(18,0)'
				EXECUTE(@sqlString)

				SET @sqlString = 'ALTER TABLE #RESULT ADD Actual_Amt_Base_on_Curr_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+' decimal(18,0)'
				EXECUTE(@sqlString)

				SET @sqlString = 'ALTER TABLE #RESULT ADD Actual_Amt_Saving_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+' float'
				EXECUTE(@sqlString)

				SET @sqlString = 'ALTER TABLE #RESULT ADD Actual_Amt_Saving_Percent_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+' NVARCHAR(20)'
				EXECUTE(@sqlString)

				-- Material  saving to Output  forecast
				SET @sqlString = 'ALTER TABLE #RESULT ADD Actual_Material_Saving_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+' NVARCHAR(20)'
				EXECUTE(@sqlString)

				SET  @sqlString = 'UPDATE #RESULT SET Amt_Base_avg_on_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+
								  ' = cast
										(
											(
												SELECT AMNT_Base_On_avg 
												FROM dbo.TTDPUROTHERS as b 
												WHERE b.ItemGroup = #RESULT.dsca 
												AND b.FYear = '+cast(@Temp_Fyear as NVARCHAR(10))+' 
												AND b.FPeriod = '+cast(@Temp_Period as NVARCHAR(10))+' 
												AND b.type = '+''''+'Forecast'+''''+'
												AND b.plant between '+''''+@Plant_From+''''+' and '+''''+@Plant_To+''''+'
											) as decimal(18,0)
										),'+
								  'Amt_Base_on_Forecast_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+
								  ' = cast
										(
											(
												SELECT AMNT_Base_On_Forecast 
												FROM dbo.TTDPUROTHERS as b 
												WHERE b.ItemGroup = #RESULT.dsca 
												AND b.FYear = '+cast(@Temp_Fyear as NVARCHAR(10))+' 
												AND b.FPeriod = '+cast(@Temp_Period as NVARCHAR(10))+' 
												AND b.type = '+''''+'Forecast'+''''+'
												AND b.plant between '+''''+@Plant_From+''''+' and '+''''+@Plant_To+''''+'
											) as decimal(18,0)
										) 
									WHERE ID >= '+CAST(@othermaterialID AS NVARCHAR(5))
				EXECUTE(@sqlString)
--					prINT @sqlString
--					prINT @othermaterialID
					
				SET  @sqlString = 'UPDATE #RESULT SET Amt_Saving_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5)) + 
								  ' = Amt_Base_avg_on_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+' - Amt_Base_on_Forecast_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+
								  ' WHERE ID >= '+CAST(@othermaterialID AS NVARCHAR(5))
				EXECUTE(@sqlString)

				SET  @sqlString = 'UPDATE #RESULT SET Amt_Saving_Percent_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+
								  ' = cast(cast(cast((Amt_Saving_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+'/Amt_Base_avg_on_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+') as decimal(18,4))*100 as decimal(18,2)) as NVARCHAR(19)) + '+''''+'%'+''''+
								  ' WHERE ID >= '+CAST(@othermaterialID AS NVARCHAR(5)) + ' AND Amt_Base_avg_on_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+' > 0'
				EXECUTE(@sqlString)
				--PRINT @sqlString
				-- Calculate actual amount 
				SET  @sqlString = 'UPDATE #RESULT SET Actual_Amt_Base_avg_on_last_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+
								  ' = cast((SELECT SUM(AMNT_Base_On_avg) from dbo.TTDPUROTHERS as b where b.ItemGroup = #RESULT.dsca and FYear = '+cast(@Temp_Fyear as NVARCHAR(10))+' and FPeriod = '+cast(@Temp_Period as NVARCHAR(10))+' AND PLANT BETWEEN '+''''+@Plant_From+''''+' AND '+''''+@Plant_To+''''+' and type = '+''''+'Forecast'+''''+' ) as decimal(18,0)),'+
								  'Actual_Amt_Base_on_Curr_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+
								  ' = cast((SELECT SUM(AMNT_Base_On_Forecast) from dbo.TTDPUROTHERS as b where b.ItemGroup = #RESULT.dsca and FYear = '+cast(@Temp_Fyear as NVARCHAR(10))+' and FPeriod = '+cast(@Temp_Period as NVARCHAR(10))+' AND PLANT BETWEEN '+''''+@Plant_From+''''+' AND '+''''+@Plant_To+''''+' and type = '+''''+'Forecast'+''''+') as decimal(18,0)) WHERE ID >= '+CAST(@othermaterialID AS NVARCHAR(5))
				EXECUTE(@sqlString)
				--PRINT @sqlString
				
				SET  @sqlString = 'UPDATE #RESULT SET Actual_Amt_Saving_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5)) + 
								  ' = Actual_Amt_Base_avg_on_last_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+' - Actual_Amt_Base_on_Curr_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+
								  ' WHERE ID >= '+CAST(@othermaterialID AS NVARCHAR(5))
				EXECUTE(@sqlString)

				SET  @sqlString = 'UPDATE #RESULT SET Actual_Amt_Saving_Percent_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+
								  ' = cast(cast(cast((Actual_Amt_Saving_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+'/Actual_Amt_Base_avg_on_last_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+') as decimal(18,4))*100 as decimal(18,2)) as NVARCHAR(19)) + '+''''+'%'+''''+
								  ' WHERE ID >= '+CAST(@othermaterialID AS NVARCHAR(5))+' AND Actual_Amt_Base_avg_on_last_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+'>0'
				EXECUTE(@sqlString)

				SET @Temp_Period = @Temp_Period + 1
				IF @Temp_Period > 12
					BEGIN
						SET @Temp_Fyear = @Temp_Fyear + 1
						SET @Temp_Period = 1
					END

				SET @Loop = @Loop + 1
			END
--	SELECT * FROM #RESULT ORDER BY ID

/*====================== Integration temp Data to final repor =============================*/

--SELECT * FROM #purchaseTrend WHERE DSCA = 'Board'

	-- INTegration temp Data to final repor
		--select * from #purchaseTrend

		SET @Loop = 0
		SET @Temp_Fyear = @Forecast_YearFrom
		SET @Temp_Period = @Forecast_PeriodFrom
		SET @sqlString = ''

		WHILE @Loop < @Period_Count
			BEGIN
			-- Forecast calculate
--				-- Calculate amount base on before avage price forecast
				SET  @sqlString = 'UPDATE #RESULT SET Amt_Base_avg_on_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+
								  ' = cast(
											(
												SELECT SUM(P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+'ForecastQty * Last_avg_Price) 
												FROM #purchaseTrend 
												WHERE #RESULT.Dsca = #purchaseTrend.Dsca
												GROUP BY Dsca
											) AS DECIMAL(18,0)
										   )
										WHERE #RESULT.ID < '+CAST(@othermaterialID AS NVARCHAR(5))
				EXECUTE(@sqlString)

				SET @sqlString = 'UPDATE #RESULT SET Amt_Base_on_Forecast_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+
								 '=(SELECT cast(sum(t$pric * t$fqty) as decimal(18,0)) FROM #TFSPUR035180 AS B 
								   WHERE B.T$YEAR = '+cast(@Temp_Fyear as nvarchar(5))+'
								   AND B.T$PROD = '+CAST(@Temp_Period as nvarchar(5))+'
								   AND B.DSCA = #RESULT.DSCA 
								   AND B.T$PLNT BETWEEN '+''''+@Plant_From+''''+' AND '+''''+@Plant_To+''''+')
								   WHERE #RESULT.ID < '+CAST(@othermaterialID AS NVARCHAR(5))
				--print @sqlString
--select *  FROM #TFSPUR035180
				EXECUTE(@sqlString)
				--select * FROM #TFSPUR035180 where t$plnt = 'b1' and t$citg = 'ig201'
				-- calculate saving amount = sum((before price - forecast price)* forecast qty)  forecast
				SET @sqlString = 'UPDATE #RESULT SET Amt_Saving_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5)) + 
								 ' = cast((Amt_Base_avg_on_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+' - Amt_Base_on_Forecast_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+') as decimal(18,6))
										WHERE #RESULT.ID < '+CAST(@othermaterialID AS NVARCHAR(5))
				EXECUTE(@sqlString)
				
				-- calculate saving amount percent  forecast
				SET @sqlString = 'UPDATE #RESULT SET Amt_Saving_PERCENT_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5)) + 
								 ' = cast(cast(cast((Amt_Base_avg_on_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+' - Amt_Base_on_Forecast_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+')/Amt_Base_avg_on_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+' as decimal(18,4))*100 as decimal(18,2)) as NVARCHAR(19))+'+''''+'%'+''''+
								'		WHERE #RESULT.ID < '+CAST(@othermaterialID AS NVARCHAR(5))
				EXECUTE(@sqlString)
				--prINT @sqlString

				SET  @sqlString = 'UPDATE #RESULT SET Actual_Amt_Base_avg_on_last_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+
								  ' = cast((SELECT SUM(#purchaseTrend.amnt_base_on_last) FROM #purchaseTrend WHERE #RESULT.Dsca = #purchaseTrend.Dsca and Fperiod = '+cast(@Temp_Period as NVARCHAR(10))+' GROUP BY #purchaseTrend.Dsca) as decimal(18,0))
										WHERE #RESULT.ID < '+CAST(@othermaterialID AS NVARCHAR(5))
				EXECUTE(@sqlString)

				-- Calculate amount base on forecast price forecast
				SET  @sqlString = 'UPDATE #RESULT SET Actual_Amt_Base_on_Curr_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+
								  ' = cast((SELECT SUM(#purchaseTrend.amnt_base_on_curr) FROM #purchaseTrend WHERE #RESULT.Dsca = #purchaseTrend.Dsca and Fperiod = '+cast(@Temp_Period as NVARCHAR(10))+'  GROUP BY Dsca) as decimal(18,0))
									WHERE #RESULT.ID < '+CAST(@othermaterialID AS NVARCHAR(5))
				EXECUTE(@sqlString)

				-- calculate saving amount = sum((before price - forecast price)* forecast qty)  forecast
				SET @sqlString = 'UPDATE #RESULT SET Actual_Amt_Saving_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5)) + 
								 ' = Actual_Amt_Base_avg_on_last_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+' - Actual_Amt_Base_on_Curr_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+'
										WHERE #RESULT.ID < '+CAST(@othermaterialID AS NVARCHAR(5))
				EXECUTE(@sqlString)
				
				-- calculate saving amount percent  forecast

				SET @sqlString = 'UPDATE #RESULT SET Actual_Amt_Saving_Percent_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5)) + 
								 ' = cast(
											cast(
													cast(
															(Actual_Amt_Saving_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+'
															/
															Actual_Amt_Base_avg_on_last_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+'
															)*100 as decimal(18,4)
														) as decimal(18,2)
												) as NVARCHAR(19)
											)+'+''''+'%'+''''+'
									WHERE #RESULT.ID < '+CAST(@othermaterialID AS NVARCHAR(5))+'
									AND Actual_Amt_Base_avg_on_last_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+'<> 0'
				EXECUTE(@sqlString)

			-- Calculate others data
				-- Update TTL Data 
				SET  @sqlString = 'UPDATE #RESULT SET Amt_Base_on_Forecast_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+
								  ' = cast((SELECT SUM(Amt_Base_on_Forecast_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+') FROM #RESULT WHERE #RESULT.Dsca <> '+''''+'TTL'+''''+' ) as decimal(18,0)) WHERE DSCA = '+''''+'TTL'+''''
				EXECUTE(@sqlString)

				SET  @sqlString = 'UPDATE #RESULT SET Amt_Base_avg_on_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+
								  ' = cast((SELECT SUM(Amt_Base_avg_on_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+') FROM #RESULT WHERE #RESULT.Dsca <> '+''''+'TTL'+''''+' ) as decimal(18,0)) WHERE DSCA = '+''''+'TTL'+''''
				EXECUTE(@sqlString)

				SET  @sqlString = 'UPDATE #RESULT SET Amt_Saving_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+
								  ' = cast((Amt_Base_avg_on_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+' - Amt_Base_on_Forecast_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+') as decimal(18,0)) WHERE DSCA = '+''''+'TTL'+''''
				EXECUTE(@sqlString)

				SET  @sqlString = 'UPDATE #RESULT SET Amt_Saving_Percent_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+
								  ' = cast(cast(cast((Amt_Base_avg_on_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+' - Amt_Base_on_Forecast_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+')/Amt_Base_avg_on_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+' as decimal(18,4))*100 as decimal(18,2)) as NVARCHAR(19)) + '+''''+'%'+''''+' WHERE DSCA = '+''''+'TTL'+''''
				EXECUTE(@sqlString)

				SET  @sqlString = 'UPDATE #RESULT SET Actual_Amt_Base_avg_on_last_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+
								  ' = cast((select sum(Actual_Amt_Base_avg_on_last_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+') FROM #RESULT WHERE #RESULT.Dsca <> '+''''+'TTL'+''''+' ) as decimal(18,0)) WHERE DSCA = '+''''+'TTL'+''''
				EXECUTE(@sqlString)

				SET  @sqlString = 'UPDATE #RESULT SET Actual_Amt_Base_on_Curr_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+
								  ' = cast((select sum(Actual_Amt_Base_on_Curr_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+') FROM #RESULT WHERE #RESULT.Dsca <> '+''''+'TTL'+''''+' ) as decimal(18,0)) WHERE DSCA = '+''''+'TTL'+''''
				EXECUTE(@sqlString)

				SET  @sqlString = 'UPDATE #RESULT SET Actual_Amt_Saving_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+
								  ' = cast((select sum(Actual_Amt_Base_avg_on_last_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+')-sum(Actual_Amt_Base_on_Curr_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+') FROM #RESULT WHERE #RESULT.Dsca <> '+''''+'TTL'+''''+' ) as decimal(18,0)) WHERE DSCA = '+''''+'TTL'+''''
				EXECUTE(@sqlString)

				SET  @sqlString = 'UPDATE #RESULT SET Actual_Amt_Saving_Percent_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+
								  ' = cast(cast((Actual_Amt_Saving_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+'/Actual_Amt_Base_avg_on_last_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+')*100 as decimal(18,2)) as NVARCHAR(19)) + '+''''+'%'+''''+' WHERE DSCA = '+''''+'TTL'+''''
				EXECUTE(@sqlString)

				-- ************************************  Update TTL To Sales  *********************************************
				SET  @sqlString = 'IF EXISTS(SELECT Amnt_Forecast FROM #TTDPUR_PRODUCTION_OUTPUT AS A WHERE A.FYear='+CAST(@Temp_Fyear AS NVARCHAR(5))+' AND A.FPeriod = '+CAST(@Temp_Period AS NVARCHAR(5))+' AND Amnt_Forecast <> 0)
									BEGIN
									UPDATE #RESULT SET Amt_Base_avg_on_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+
								  ' = CAST(CAST((SELECT Amt_Base_avg_on_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+' FROM #RESULT WHERE DSCA = '+''''+'TTL'+''''+')'+
								  '/'+
								  '(SELECT Amnt_Forecast FROM #TTDPUR_PRODUCTION_OUTPUT AS A WHERE A.FYear='+CAST(@Temp_Fyear AS NVARCHAR(5))+' AND A.FPeriod = '+CAST(@Temp_Period AS NVARCHAR(5))+' AND Amnt_Forecast <> 0) AS DECIMAL(18,2))*100 AS NVARCHAR(19))'+
								  ' WHERE DSCA = '+''''+'TTL To Sales'+''''+
								  ' END'
				EXECUTE(@sqlString)
				--prINT @sqlString

				SET  @sqlString = 'IF EXISTS(SELECT Amnt_Forecast FROM #TTDPUR_PRODUCTION_OUTPUT AS A WHERE A.FYear='+CAST(@Temp_Fyear AS NVARCHAR(5))+' AND A.FPeriod = '+CAST(@Temp_Period AS NVARCHAR(5))+' AND Amnt_Forecast <> 0)
									BEGIN
									UPDATE #RESULT SET Amt_Base_on_Forecast_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+
								  ' = CAST((SELECT Amt_Base_on_Forecast_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+' FROM #RESULT WHERE DSCA = '+''''+'TTL'+''''+')'+
								  '/'+
								  '(SELECT Amnt_Forecast FROM #TTDPUR_PRODUCTION_OUTPUT AS A WHERE A.FYear='+CAST(@Temp_Fyear AS NVARCHAR(5))+' AND A.FPeriod = '+CAST(@Temp_Period AS NVARCHAR(5))+') AS DECIMAL(18,2))*100'+
								  ' WHERE DSCA = '+''''+'TTL To Sales'+''''+
								  '	END '
				EXECUTE(@sqlString)

				SET  @sqlString = 'IF EXISTS(SELECT Amnt_Actual FROM #TTDPUR_PRODUCTION_OUTPUT AS A WHERE A.FYear='+CAST(@Temp_Fyear AS NVARCHAR(5))+' AND A.FPeriod = '+CAST(@Temp_Period AS NVARCHAR(5))+' AND Amnt_Actual <> 0)
								    BEGIN
									UPDATE #RESULT SET Actual_Amt_Base_avg_on_last_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+
								  ' = CAST((SELECT Actual_Amt_Base_avg_on_last_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+' FROM #RESULT WHERE DSCA = '+''''+'TTL'+''''+')'+
								  '/'+
								  '(SELECT Amnt_Actual FROM #TTDPUR_PRODUCTION_OUTPUT AS A WHERE A.FYear='+CAST(@Temp_Fyear AS NVARCHAR(5))+' AND A.FPeriod = '+CAST(@Temp_Period AS NVARCHAR(5))+') AS DECIMAL(18,2))*100'+
								  ' WHERE DSCA = '+''''+'TTL To Sales'+''''+
								  ' END'
				EXECUTE(@sqlString)

				SET  @sqlString = 'IF EXISTS(SELECT Amnt_Actual FROM #TTDPUR_PRODUCTION_OUTPUT AS A WHERE A.FYear='+CAST(@Temp_Fyear AS NVARCHAR(5))+' AND A.FPeriod = '+CAST(@Temp_Period AS NVARCHAR(5))+' AND Amnt_Actual <> 0)
									BEGIN
									UPDATE #RESULT SET Actual_Amt_Base_on_Curr_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+
								  ' = CAST((SELECT Actual_Amt_Base_on_Curr_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+' FROM #RESULT WHERE DSCA = '+''''+'TTL'+''''+')'+
								  '/'+
								  '(SELECT Amnt_Actual FROM #TTDPUR_PRODUCTION_OUTPUT AS A WHERE A.FYear='+CAST(@Temp_Fyear AS NVARCHAR(5))+' AND A.FPeriod = '+CAST(@Temp_Period AS NVARCHAR(5))+') AS DECIMAL(18,2))*100'+
								  ' WHERE DSCA = '+''''+'TTL To Sales'+''''+
								  ' END'
				EXECUTE(@sqlString)

				SET  @sqlString = 'IF EXISTS(SELECT Amnt_Forecast FROM #TTDPUR_PRODUCTION_OUTPUT AS A WHERE A.FYear='+CAST(@Temp_Fyear AS NVARCHAR(5))+' AND A.FPeriod = '+CAST(@Temp_Period AS NVARCHAR(5))+' AND Amnt_Forecast <> 0)
									BEGIN
									UPDATE #RESULT SET Material_Saving_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+
								  ' = CAST(CAST(Amt_Saving_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+
								  '/'+
								  '(SELECT Amnt_Forecast FROM #TTDPUR_PRODUCTION_OUTPUT AS A WHERE A.FYear='+CAST(@Temp_Fyear AS NVARCHAR(5))+' AND A.FPeriod = '+CAST(@Temp_Period AS NVARCHAR(5))+') AS DECIMAL(18,2))*100 AS NVARCHAR(20))+'+''''+'%'+''''+
								  'END'
				EXECUTE(@sqlString)

				SET  @sqlString = 'IF EXISTS(SELECT Amnt_Actual FROM #TTDPUR_PRODUCTION_OUTPUT AS A WHERE A.FYear='+CAST(@Temp_Fyear AS NVARCHAR(5))+' AND A.FPeriod = '+CAST(@Temp_Period AS NVARCHAR(5))+' AND Amnt_Actual <> 0)
									BEGIN
									UPDATE #RESULT SET Actual_Material_Saving_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+
								  ' = CAST(CAST(Actual_Amt_Saving_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+
								  '/'+
								  '(SELECT Amnt_Actual FROM #TTDPUR_PRODUCTION_OUTPUT AS A WHERE A.FYear='+CAST(@Temp_Fyear AS NVARCHAR(5))+' AND A.FPeriod = '+CAST(@Temp_Period AS NVARCHAR(5))+') AS DECIMAL(18,2))*100 AS NVARCHAR(20))+'+''''+'%'+''''+
								  'END'
				EXECUTE(@sqlString)

				SET @Temp_Period = @Temp_Period + 1
				IF @Temp_Period > 12
					BEGIN
						SET @Temp_Fyear = @Temp_Fyear + 1
						SET @Temp_Period = 1
					END

				SET @Loop = @Loop + 1
			END

--	SELECT * FROM #RESULT ORDER BY ID

			-- Another report for actual vs forecast

			IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb..#Summery_Result') AND TYPE = 'U')
				DROP TABLE #Summery_Result
			SELECT DSCA INTO #Summery_Result FROM #RESULT --WHERE RTRIM(DSCA) <> 'TTL'
			ALTER TABLE #Summery_Result ADD Overall_Savings float
			ALTER TABLE #Summery_Result ADD Cumnlative_Savings float
			ALTER TABLE #Summery_Result ADD Realised_Savings float
			ALTER TABLE #Summery_Result ADD Target_Met NVARCHAR(20)
			ALTER TABLE #Summery_Result ADD AVG_TOTAL FLOAT
			ALTER TABLE #Summery_Result ADD Actual_TOTAL FLOAT
			ALTER TABLE #Summery_Result ADD Overall_Savings_p NVARCHAR(10)
			ALTER TABLE #Summery_Result ADD Cumnlative_Savings_P NVARCHAR(10)
			ALTER TABLE #Summery_Result ADD Overall_Savings_p_temp float
			ALTER TABLE #Summery_Result ADD Cumnlative_Savings_P_temp float
			ALTER TABLE #Summery_Result ADD Realised_Savings_P NVARCHAR(10)
			ALTER TABLE #Summery_Result ADD Target_Met_P NVARCHAR(20)
			ALTER TABLE #Summery_Result ADD Remarks NVARCHAR(100)

			SET @Loop = 0
			SET @Temp_Fyear = @Forecast_YearFrom
			SET @Temp_Period = @Forecast_PeriodFrom
			SET @sqlString = ''

			WHILE @Loop < @Period_Count
				BEGIN
					SET @sqlString = 'UPDATE #Summery_Result SET Overall_Savings = isnull(Overall_Savings,0) + isnull(CAST((SELECT Amt_Saving_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+' FROM #RESULT WHERE #RESULT.DSCA = #Summery_Result.DSCA) AS FLOAT),0)'
					EXECUTE(@sqlString)

					SET @sqlString = 'UPDATE #Summery_Result SET Cumnlative_Savings = isnull(Cumnlative_Savings,0) + isnull(CAST((SELECT Actual_Amt_Saving_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+' FROM #RESULT WHERE #RESULT.DSCA = #Summery_Result.DSCA) AS FLOAT),0)'
					EXECUTE(@sqlString)

					UPDATE #Summery_Result SET Realised_Savings = ISNULL(Overall_Savings,0) - ISNULL(Cumnlative_Savings,0)
					UPDATE #Summery_Result SET Target_Met = 'Yes' WHERE Realised_Savings >= 0
					UPDATE #Summery_Result SET Target_Met = 'No' WHERE Realised_Savings < 0

					SET @sqlString = 'UPDATE #Summery_Result SET AVG_TOTAL = isnull(AVG_TOTAL,0) + isnull(CAST((SELECT Amt_Base_avg_on_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+' FROM #RESULT WHERE #RESULT.DSCA = #Summery_Result.DSCA) AS FLOAT),0)'
					EXECUTE(@sqlString)

					SET @sqlString = 'UPDATE #Summery_Result SET Actual_TOTAL = isnull(Actual_TOTAL,0) + isnull(CAST((SELECT Actual_Amt_Base_avg_on_last_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+' FROM #RESULT WHERE #RESULT.DSCA = #Summery_Result.DSCA) AS FLOAT),0)'
					EXECUTE(@sqlString)

					-- Alter Properties to add char '%'
					SET  @sqlString = 'ALTER TABLE #RESULT ALTER COLUMN Amt_Base_avg_on_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5)) + ' NVARCHAR(20)'
					EXECUTE(@sqlString)

					SET  @sqlString = 'ALTER TABLE #RESULT ALTER COLUMN Amt_Base_on_Forecast_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5)) + ' NVARCHAR(20)'
					EXECUTE(@sqlString)

					SET  @sqlString = 'ALTER TABLE #RESULT ALTER COLUMN Actual_Amt_Base_avg_on_last_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5)) + ' NVARCHAR(20)'
					EXECUTE(@sqlString)

					SET  @sqlString = 'ALTER TABLE #RESULT ALTER COLUMN Actual_Amt_Base_on_Curr_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5)) + ' NVARCHAR(20)'
					EXECUTE(@sqlString)

					SET  @sqlString = 'UPDATE #RESULT SET Amt_Base_avg_on_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+
									  ' = Amt_Base_avg_on_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+'+'+''''+'%'+''''+
									  ' WHERE DSCA = '+''''+'TTL To Sales'+''''
					EXECUTE(@sqlString)

					SET  @sqlString = 'UPDATE #RESULT SET Amt_Base_on_Forecast_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+
									  ' = Amt_Base_on_Forecast_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+'+'+''''+'%'+''''+
									  ' WHERE DSCA = '+''''+'TTL To Sales'+''''
					EXECUTE(@sqlString)

					SET  @sqlString = 'UPDATE #RESULT SET Actual_Amt_Base_avg_on_last_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+
									  ' = Actual_Amt_Base_avg_on_last_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+'+'+''''+'%'+''''+
									  ' WHERE DSCA = '+''''+'TTL To Sales'+''''
					EXECUTE(@sqlString)

					SET  @sqlString = 'UPDATE #RESULT SET Actual_Amt_Base_on_Curr_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+
									  ' = Actual_Amt_Base_on_Curr_P'+CAST(@Temp_Period AS NVARCHAR(5))+'FY'+CAST(@Temp_Fyear AS NVARCHAR(5))+'+'+''''+'%'+''''+
									  ' WHERE DSCA = '+''''+'TTL To Sales'+''''
					EXECUTE(@sqlString)

					SET @Temp_Period = @Temp_Period + 1
					IF @Temp_Period > 12
						BEGIN
							SET @Temp_Fyear = @Temp_Fyear + 1
							SET @Temp_Period = 1
						END
					SET @Loop = @Loop + 1
				END

			UPDATE #Summery_Result SET Overall_Savings_p = cast(cast((ISNULL(Overall_Savings,0) / AVG_TOTAL)*100 as decimal(18,1)) as NVARCHAR(10))+N'%' WHERE AVG_TOTAL <> 0
			UPDATE #Summery_Result SET Cumnlative_Savings_P = '0' WHERE Actual_TOTAL = 0
			UPDATE #Summery_Result SET Cumnlative_Savings_P = cast(cast((Cumnlative_Savings/Actual_TOTAL)*100 as decimal(18,1)) as NVARCHAR(10))+N'%' WHERE Actual_TOTAL <> 0
			UPDATE #Summery_Result SET Overall_Savings_p_temp = cast((ISNULL(Overall_Savings,0) / AVG_TOTAL)*100 as decimal(18,1)) WHERE AVG_TOTAL <> 0
			UPDATE #Summery_Result SET Cumnlative_Savings_P_temp = 0 WHERE Actual_TOTAL = 0
			UPDATE #Summery_Result SET Cumnlative_Savings_P_temp = cast((Cumnlative_Savings/Actual_TOTAL)*100 as decimal(18,1)) WHERE Actual_TOTAL <> 0
			UPDATE #Summery_Result SET Realised_Savings_P = cast((Cumnlative_Savings_P_temp - Overall_Savings_p_temp) as NVARCHAR(9))+N'%'
			UPDATE #Summery_Result SET Target_Met_P = 'Yes' where (Cumnlative_Savings_P_temp - Overall_Savings_p_temp) >= 0
			UPDATE #Summery_Result SET Target_Met_P = 'No' where (Cumnlative_Savings_P_temp - Overall_Savings_p_temp) < 0

			ALTER TABLE #Summery_Result DROP COLUMN Overall_Savings_p_temp
			ALTER TABLE #Summery_Result DROP COLUMN Cumnlative_Savings_P_temp
			ALTER TABLE #Summery_Result DROP COLUMN AVG_TOTAL
			ALTER TABLE #Summery_Result DROP COLUMN Actual_TOTAL

-- ************************ Update AVG TTL ****************************************************************** --

-- ************************ Show result ********************************************************************* --
			if not exists(SELECT top 1 * FROM #RESULT)
				begin
					raiserror('No data with sectiong!',16,1)
					return
				end
			else
				SELECT * FROM #RESULT as a left join #Summery_Result as b on a.dsca = b.dsca ORDER BY A.ID
END





GO
