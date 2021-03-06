USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MSS_SeeMSSBookingBreakdown]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 


CREATE  procedure [dbo].[sp_MSS_SeeMSSBookingBreakdown]
	@Value	VARCHAR(MAX)
as
begin
	--CurrentFiscalDate
	DECLARE @CurrentDay DATETIME
	DECLARE @CurrentFiscalYear VARCHAR(4)
	DECLARE @CurrentFiscalPeriod VARCHAR(2)
	SELECT @CurrentDay=CONVERT(DATETIME, CONVERT(varchar(100), [UpTime] , 112)) FROM [Multek_ZH].[dbo].[MSS_UpTime]
	SELECT @CurrentFiscalYear= substring([FiscalYearDesc],3,4),@CurrentFiscalPeriod=CONVERT(VARCHAR,FiscalPeriod) FROM  [DataWarehouse].[dbo].[DW_DIM_Calender]
	WHERE CalenderDate=@CurrentDay

	--#Breakdown  当前其包含以前期的Breakdown
	IF (select object_ID('tempdb..#Breakdown')) >0 
		DROP TABLE [#Breakdown]
	SELECT  
		[T$PDAT_FiscalYear]
		,[T$PDAT_FiscalPeriod]
		,[Plant]
		,[Project]
		,[OEM]
		,[Product]
		,ISNULL(SUM([FGavailable]), 0)AS [FGavailable]
		,ISNULL(SUM([BalanceToBuild]), 0)AS [BalanceToBuild]
	INTO [#Breakdown]
	FROM (
		SELECT  
			[T$PDAT_FiscalYear]
			,[T$PDAT_FiscalPeriod]
			,[Plant]
			,[Project]
			,[OEM]
			,[Product]
			,[FGavailable]
			,[BalanceToBuild]
		FROM [MSS_MSSBreakdown] 
		WHERE [T$JDAT]=@CurrentDay
				AND [Project] IN ( SELECT  col   FROM   dbo.f_split(@Value,','))  -- 分割字符串 
				AND ([T$PDAT_FiscalYear] > @CurrentFiscalYear
					OR([T$PDAT_FiscalYear] = @CurrentFiscalYear AND [T$PDAT_FiscalPeriod] >= @CurrentFiscalPeriod)
					AND [T$PDAT_FiscalYear] != 2099	)
		GROUP BY [T$PDAT_FiscalYear],[T$PDAT_FiscalPeriod], [Plant], [Project],[OEM],[Product],[FGavailable],[BalanceToBuild]
		--ORDER BY [T$PDAT_FiscalYear],[T$PDAT_FiscalPeriod], [Plant], [Project],[OEM],[Product],[FGavailable],[BalanceToBuild]
		UNION ALL--以前期
		SELECT  
			@CurrentFiscalYear AS [T$PDAT_FiscalYear]
			,@CurrentFiscalPeriod AS [T$PDAT_FiscalPeriod]
			,[Plant]
			,[Project]
			,[OEM]
			,[Product]
			,[FGavailable]
			,[BalanceToBuild]
		FROM [MSS_MSSBreakdown] 
		WHERE [T$JDAT]=@CurrentDay
				AND [Project] IN ( SELECT  col   FROM   dbo.f_split(@Value,','))  -- 分割字符串 
				AND(
					[T$PDAT_FiscalYear] < @CurrentFiscalYear
					OR([T$PDAT_FiscalYear] = @CurrentFiscalYear AND [T$PDAT_FiscalPeriod] < @CurrentFiscalPeriod)
				)	
		GROUP BY [T$PDAT_FiscalYear],[T$PDAT_FiscalPeriod], [Plant], [Project],[OEM],[Product],[FGavailable],[BalanceToBuild]
		--ORDER BY [T$PDAT_FiscalYear],[T$PDAT_FiscalPeriod], [Plant], [Project],[OEM],[Product],[FGavailable],[BalanceToBuild]
	)AS T
	GROUP BY [T$PDAT_FiscalYear],[T$PDAT_FiscalPeriod], [Plant], [Project],[OEM],[Product],[FGavailable],[BalanceToBuild]
	ORDER BY [T$PDAT_FiscalYear],[T$PDAT_FiscalPeriod], [Plant], [Project],[OEM],[Product],[FGavailable],[BalanceToBuild]
	
	
	
	--OverallPeriod
	IF (select object_ID('tempdb..#OverallPeriod')) >0 
		DROP TABLE [#OverallPeriod]
	SELECT [T$PDAT_FiscalYear]
		  ,[T$PDAT_FiscalPeriod]
	INTO [#OverallPeriod]
	FROM [#Breakdown]
	WHERE [T$PDAT_FiscalYear] > @CurrentFiscalYear
			OR([T$PDAT_FiscalYear] = @CurrentFiscalYear AND [T$PDAT_FiscalPeriod] >= @CurrentFiscalPeriod)
		AND [T$PDAT_FiscalYear] != 2099	
	GROUP BY [T$PDAT_FiscalYear],[T$PDAT_FiscalPeriod]
	ORDER BY [T$PDAT_FiscalYear],[T$PDAT_FiscalPeriod]
	
	DECLARE @BookingSQLString VARCHAR(MAX), @OutstandSQLString VARCHAR(MAX)
	DECLARE @Outstanding NUMERIC(19,4), @FG NUMERIC(19,4),@Meet NUMERIC(19,4), @Ahead NUMERIC(19,4)
	
	--#Outstanding
	if (select object_ID('tempdb..#Outstanding')) >0 
		DROP TABLE [#Outstanding]
	CREATE TABLE #Outstanding ([Project] VARCHAR(50)
			, [Plant] VARCHAR(50)
			, [OEM] VARCHAR(50)
			)
	SET @BookingSQLString=''
	SELECT @BookingSQLString=@BookingSQLString
							+ 'ALTER TABLE #Outstanding ADD [' + dbo.fun_Get_Full_Period_Name([T$PDAT_FiscalYear], [T$PDAT_FiscalPeriod]) + '_F.G] NUMERIC(19,4) NULL '
							+ 'ALTER TABLE #Outstanding ADD [' + dbo.fun_Get_Full_Period_Name([T$PDAT_FiscalYear], [T$PDAT_FiscalPeriod]) + '_Bal] NUMERIC(19,4) NULL '
							+ 'ALTER TABLE #Outstanding ADD [' + dbo.fun_Get_Full_Period_Name([T$PDAT_FiscalYear], [T$PDAT_FiscalPeriod]) + '] NUMERIC(19,4) NULL '
	FROM #OverallPeriod
	EXEC (@BookingSQLString)
	ALTER TABLE #Outstanding ADD [Outstanding] NUMERIC(19,4) NULL
	ALTER TABLE #Outstanding ADD [MeetSamePeriod] NUMERIC(19,4) NULL
	ALTER TABLE #Outstanding ADD [Ahead] NUMERIC(19,4) NULL
	ALTER TABLE #Outstanding ADD [F.G] NUMERIC(19,4) NULL
	ALTER TABLE #Outstanding ADD [Product] VARCHAR(50)



	
	DECLARE @temp varchar(50)--临时变量，用来保存游标值  
	--申明游标 
	DECLARE order_cursor CURSOR FOR SELECT [Project] FROM [#Breakdown] GROUP BY [Project]
	--打开游标  
	OPEN order_cursor 
	 FETCH NEXT FROM order_cursor INTO @temp   
	 WHILE @@FETCH_STATUS = 0 --返回被 FETCH  语句执行的最后游标的状态，而不是任何当前被连接打开的游标的状态。  
	  BEGIN  
		--执行sql操作
		SET @BookingSQLString='INSERT INTO #Outstanding VALUES('''+@temp+''''
		
		--Outstanding Order
		SET @OutstandSQLString=''
		SET @Outstanding=0
		SELECT
			  @OutstandSQLString=@OutstandSQLString
			  +', ' + CONVERT(VARCHAR(50),CAST(ISNULL([FGavailable],0)AS NUMERIC(19,4)))
			  +', ' + CONVERT(VARCHAR(50),CAST(ISNULL([BalanceToBuild],0)AS NUMERIC(19,4)))
			  +', ' + CONVERT(VARCHAR(50),CAST(ISNULL([FGavailable],0)AS NUMERIC(19,4))+CAST(ISNULL([BalanceToBuild],0)AS NUMERIC(19,4)))
			  ,@Outstanding=@Outstanding+ ISNULL([FGavailable],0) + ISNULL([BalanceToBuild],0)
		FROM #OverallPeriod AS A LEFT JOIN (
			SELECT 
				[T$PDAT_FiscalYear]
				,[T$PDAT_FiscalPeriod]
				,SUM([FGavailable])AS [FGavailable]
				,SUM([BalanceToBuild])AS [BalanceToBuild]
			FROM [#Breakdown]
			WHERE [Project]=@temp
			GROUP BY [T$PDAT_FiscalYear],[T$PDAT_FiscalPeriod]
		) AS B
		ON  A.[T$PDAT_FiscalYear]=B.[T$PDAT_FiscalYear]
		AND A.[T$PDAT_FiscalPeriod]=B.[T$PDAT_FiscalPeriod]
		ORDER BY A.[T$PDAT_FiscalYear],A.[T$PDAT_FiscalPeriod]
		
		
		SET @Ahead=0
		SET @FG=0
		--AheadFGOut
		SELECT 
			@Ahead=CAST(ISNULL(SUM([Amount]),0)AS NUMERIC(19,4))
		FROM [MSS_AheadFGOut_ByOrder]
		WHERE [T$JDAT]=@CurrentDay
			 AND [T$AJSD_FiscalYear] = @CurrentFiscalYear 
			 AND [T$AJSD_FiscalPeriod] = @CurrentFiscalPeriod
			 AND [Project]=@temp
		--FGOut
		SELECT 
			@FG=CAST(ISNULL(SUM([FGout]),0)AS NUMERIC(19,4))
		FROM [MSS_FGOut_ByOrder]
		WHERE [T$JDAT]=@CurrentDay
			 AND [T$AJSD_FiscalYear] = @CurrentFiscalYear 
			 AND [T$AJSD_FiscalPeriod] = @CurrentFiscalPeriod
			 AND [Project]=@temp
		--Meet same period
		SET @Meet=@FG-@Ahead
		
		
		SELECT TOP 1 @BookingSQLString=@BookingSQLString 
			+','''+[Plant] +''','''+[OEM] +''''
			+ @OutstandSQLString + ', ' + CONVERT(VARCHAR(50),@Outstanding)
			+ ', ' + CONVERT(VARCHAR(50),@Meet) 
			+ ', '+ CONVERT(VARCHAR(50),@Ahead)   
			+ ', ' +CONVERT(VARCHAR(50),@FG)
			+ ','''+[Product]+'''' 
			+ ')' 
		FROM [#Breakdown]
		WHERE [Project]=@temp
		
		EXEC(@BookingSQLString)
		
		--开始循环游标变量  
		FETCH NEXT FROM order_cursor INTO @temp  
	   
	  END  

	CLOSE order_cursor--关闭游标  
	DEALLOCATE order_cursor--释放游标 
	
	
	SELECT * FROM [#Outstanding]
	--Delete Table
	DROP TABLE [#Breakdown]
	DROP TABLE [#OverallPeriod]
	DROP TABLE [#Outstanding]
	

	
END


GO
