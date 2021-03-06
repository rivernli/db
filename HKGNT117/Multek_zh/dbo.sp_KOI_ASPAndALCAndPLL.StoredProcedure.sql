USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_KOI_ASPAndALCAndPLL]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_KOI_ASPAndALCAndPLL] 
	@DateType VARCHAR(10)
	,@Report VARCHAR(10)

	,@FromYear VARCHAR(10)
	,@FromQuarter VARCHAR(10)
	,@FromPeriod VARCHAR(10)
	,@FromWeek VARCHAR(10)
	,@ToYear VARCHAR(10)
	,@ToQuarter VARCHAR(10)
	,@ToPeriod VARCHAR(10)
	,@ToWeek VARCHAR(10)

	,@Sale VARCHAR(50)
	,@Plant VARCHAR(50)

AS
BEGIN
	--#T
	IF (select object_ID('tempdb..#T')) >0 
			DROP TABLE [dbo].[#T]
	CREATE TABLE #T (
		 [Item] NVARCHAR(50)
		,[ASP] FLOAT
		,[ALC] FLOAT
		,[PPL] FLOAT
	)

	IF @DateType= 'FY'
	BEGIN
		--Fiscal Year
		IF @Report='Yearly'
		BEGIN
			--Yearly
			IF @Plant='All'
			BEGIN
				INSERT INTO [#T]
				SELECT 
					'FY' + [FYear] AS Item
					,SUM([ASP])
					,SUM([ALC])
					,SUM([PPL])
				FROM [Multek_ZH].[dbo].[KOI_ASPAndALCAndPLL]
				WHERE [Sale]=@Sale
						AND [FYear]>=@FromYear  AND [FYear]<= @ToYear
				GROUP BY [FYear]
				ORDER BY [FYear]
				
			END
			ELSE IF @Plant='All exclude 2F'
			BEGIN
				INSERT INTO [#T]
				SELECT 
					'FY' + convert(varchar,[FYear]) AS Item
					,SUM([ASP])
					,SUM([ALC])
					,SUM([PPL])
				FROM [Multek_ZH].[dbo].[KOI_ASPAndALCAndPLL]
				WHERE [Sale]=@Sale
						AND [FYear]>=@FromYear  AND [FYear]<= @ToYear
						AND [Plant]!='2F'
				GROUP BY [FYear]
				ORDER BY [FYear]
				
			END
			ELSE
			BEGIN
				INSERT INTO [#T]
				SELECT 
					'FY' + convert(varchar,[FYear]) AS Item
					,SUM([ASP])
					,SUM([ALC])
					,SUM([PPL])
				FROM [Multek_ZH].[dbo].[KOI_ASPAndALCAndPLL]
				WHERE [Sale]=@Sale
						AND [FYear]>=@FromYear  AND [FYear]<= @ToYear
						AND [Plant]=@Plant
				GROUP BY [FYear]
				ORDER BY [FYear]
				
			END
			
			--End Year
		END
		ELSE IF @Report='Quarterly'
		BEGIN
			--Quarter
			IF @Plant='All'
			BEGIN
				INSERT INTO [#T]
				SELECT 
					'Q' + convert(varchar,[FQuarter])+ 'FY' + convert(varchar,[FYear]) AS Item
					,SUM([ASP])
					,SUM([ALC])
					,SUM([PPL])
				FROM [Multek_ZH].[dbo].[KOI_ASPAndALCAndPLL]
				WHERE [Sale]=@Sale
						AND ([FYear] > @FromYear OR ([FYear]=@FromYear AND [FQuarter]>=@FromQuarter))
						AND ([FYear] < @ToYear   OR ([FYear]=@ToYear   AND [FQuarter]<=@ToQuarter))
				GROUP BY [FYear], [FQuarter]
				ORDER BY [FYear], [FQuarter]
				
			END
			ELSE IF @Plant='All exclude 2F'
			BEGIN
				INSERT INTO [#T]
				SELECT 
					'Q' + convert(varchar,[FQuarter])+ 'FY' +convert(varchar,[FYear]) AS Item
					,SUM([ASP])
					,SUM([ALC])
					,SUM([PPL])
				FROM [Multek_ZH].[dbo].[KOI_ASPAndALCAndPLL]
				WHERE [Sale]=@Sale
						AND ([FYear] > @FromYear OR ([FYear]=@FromYear AND [FQuarter]>=@FromQuarter))
						AND ([FYear] < @ToYear   OR ([FYear]=@ToYear   AND [FQuarter]<=@ToQuarter))
						AND [Plant]!='2F'
				GROUP BY [FYear], [FQuarter]
				ORDER BY [FYear], [FQuarter]
			END
			ELSE
			BEGIN
				INSERT INTO [#T]
				SELECT 
					'Q' + convert(varchar,[FQuarter])+ 'FY' +convert(varchar,[FYear]) AS Item
					,SUM([ASP])
					,SUM([ALC])
					,SUM([PPL])
				FROM [Multek_ZH].[dbo].[KOI_ASPAndALCAndPLL]
				WHERE [Sale]=@Sale
						AND ([FYear] > @FromYear OR ([FYear]=@FromYear AND [FQuarter]>=@FromQuarter))
						AND ([FYear] < @ToYear   OR ([FYear]=@ToYear   AND [FQuarter]<=@ToQuarter))
						AND [Plant]=@Plant
				GROUP BY [FYear], [FQuarter]
				ORDER BY [FYear], [FQuarter]
				
			END
			
			
			-- END Quarterly
		END
		ELSE IF @Report='Monthly'
		BEGIN
			--Monthly
			IF @Plant='All'
			BEGIN
				INSERT INTO [#T]
				SELECT 
					'P' + convert(varchar,[FPeriod])+ 'FY' +convert(varchar,[FYear]) AS Item
					,SUM([ASP])
					,SUM([ALC])
					,SUM([PPL])
				FROM [Multek_ZH].[dbo].[KOI_ASPAndALCAndPLL]
				WHERE [Sale]=@Sale
						AND ([FYear] > @FromYear OR ([FYear]=@FromYear AND [FPeriod]>=@FromPeriod))
						AND ([FYear] < @ToYear   OR ([FYear]=@ToYear   AND [FPeriod]<=@ToPeriod))
				GROUP BY [FYear], [FPeriod]
				ORDER BY [FYear], [FPeriod]
				
			END
			ELSE IF @Plant='All exclude 2F'
			BEGIN
				INSERT INTO [#T]
				SELECT 
					'P' + convert(varchar,[FPeriod])+ 'FY' +convert(varchar,[FYear]) AS Item
					,SUM([ASP])
					,SUM([ALC])
					,SUM([PPL])
				FROM [Multek_ZH].[dbo].[KOI_ASPAndALCAndPLL]
				WHERE [Sale]=@Sale
						AND ([FYear] > @FromYear OR ([FYear]=@FromYear AND [FPeriod]>=@FromPeriod))
						AND ([FYear] < @ToYear   OR ([FYear]=@ToYear   AND [FPeriod]<=@ToPeriod))
						AND [Plant]!='2F'
				GROUP BY [FYear], [FPeriod]
				ORDER BY [FYear], [FPeriod]
						
			END
			ELSE
			BEGIN
				INSERT INTO [#T]
				SELECT 
					'P' + convert(varchar,[FPeriod])+ 'FY' +convert(varchar,[FYear]) AS Item
					,SUM([ASP])
					,SUM([ALC])
					,SUM([PPL])
				FROM [Multek_ZH].[dbo].[KOI_ASPAndALCAndPLL]
				WHERE [Sale]=@Sale
						AND ([FYear] > @FromYear OR ([FYear]=@FromYear AND [FPeriod]>=@FromPeriod))
						AND ([FYear] < @ToYear   OR ([FYear]=@ToYear   AND [FPeriod]<=@ToPeriod))
						AND [Plant]=@Plant
				GROUP BY [FYear], [FPeriod]
				ORDER BY [FYear], [FPeriod]
				
			END
			
			
			--END Monthly			
		END
		ELSE IF @Report='Weekly'
		BEGIN
			--Weekly
			IF @Plant='All'
			BEGIN
				INSERT INTO [#T]
				SELECT 
					'W' + convert(varchar,[FYearWeek])+ 'FY' + convert(varchar,[FYear]) AS Item
					,SUM([ASP])
					,SUM([ALC])
					,SUM([PPL])
				FROM [Multek_ZH].[dbo].[KOI_ASPAndALCAndPLL]
				WHERE [Sale]=@Sale
						AND ([FYear] > @FromYear OR ([FYear]=@FromYear AND [FYearWeek]>=@FromWeek))
						AND ([FYear] < @ToYear   OR ([FYear]=@ToYear   AND [FYearWeek]<=@ToWeek))
				GROUP BY [FYear], [FYearWeek]
				ORDER BY [FYear], [FYearWeek]
				
			END
			ELSE IF @Plant='All exclude 2F'
			BEGIN
				INSERT INTO [#T]
				SELECT 
					'W' + convert(varchar,[FYearWeek])+ 'FY' + convert(varchar,[FYear]) AS Item
					,SUM([ASP])
					,SUM([ALC])
					,SUM([PPL])
				FROM [Multek_ZH].[dbo].[KOI_ASPAndALCAndPLL]
				WHERE [Sale]=@Sale
						AND ([FYear] > @FromYear OR ([FYear]=@FromYear AND [FYearWeek]>=@FromWeek))
						AND ([FYear] < @ToYear   OR ([FYear]=@ToYear   AND [FYearWeek]<=@ToWeek))
						AND [Plant]!='2F'
				GROUP BY [FYear], [FYearWeek]
				ORDER BY [FYear], [FYearWeek]
				
			END
			ELSE
			BEGIN
				INSERT INTO [#T]
				SELECT 
					'W' + convert(varchar,[FYearWeek])+ 'FY' + convert(varchar,[FYear]) AS Item
					,SUM([ASP])
					,SUM([ALC])
					,SUM([PPL])
				FROM [Multek_ZH].[dbo].[KOI_ASPAndALCAndPLL]
				WHERE [Sale]=@Sale
						AND ([FYear] > @FromYear OR ([FYear]=@FromYear AND [FYearWeek]>=@FromWeek))
						AND ([FYear] < @ToYear   OR ([FYear]=@ToYear   AND [FYearWeek]<=@ToWeek))
						AND [Plant]=@Plant
				GROUP BY [FYear], [FYearWeek]
				ORDER BY [FYear], [FYearWeek]
				
			END
			
			
			--END Weekly	
		END
		
		
		
		
		
		--END Fiscal Year	
	END


	ELSE
	BEGIN
		--Calender
		IF @Report='Yearly'
		BEGIN
			--Yearly
			IF @Plant='All'
			BEGIN
				INSERT INTO [#T]
				SELECT 
					'Y'+ convert(varchar,[CYear]) AS Item
					,SUM([ASP])
					,SUM([ALC])
					,SUM([PPL])
				FROM [Multek_ZH].[dbo].[KOI_ASPAndALCAndPLL]
				WHERE [Sale]=@Sale
						AND [CYear]>=@FromYear  AND [CYear]<= @ToYear
				GROUP BY [CYear]
				ORDER BY [CYear]
				
			END
			ELSE IF @Plant='All exclude 2F'
			BEGIN
				INSERT INTO [#T]
				SELECT 
					'Y'+ convert(varchar,[CYear]) AS Item
					,SUM([ASP])
					,SUM([ALC])
					,SUM([PPL])
				FROM [Multek_ZH].[dbo].[KOI_ASPAndALCAndPLL]
				WHERE [Sale]=@Sale
						AND [CYear]>=@FromYear  AND [CYear]<= @ToYear
						AND [Plant]!='2F'
				GROUP BY [CYear]
				ORDER BY [CYear]
						
			END
			ELSE
			BEGIN
				INSERT INTO [#T]
				SELECT 
					'Y'+ convert(varchar,[CYear]) AS Item
					,SUM([ASP])
					,SUM([ALC])
					,SUM([PPL])
				FROM [Multek_ZH].[dbo].[KOI_ASPAndALCAndPLL]
				WHERE [Sale]=@Sale
						AND [CYear]>=@FromYear  AND [CYear]<= @ToYear
						AND [Plant]=@Plant
				GROUP BY [CYear]
				ORDER BY [CYear]
				
			END
			
			--End Year
		END
		ELSE IF @Report='Quarterly'
		BEGIN
			--Quarter
			IF @Plant='All'
			BEGIN
				INSERT INTO [#T]
				SELECT 
					'Q' + convert(varchar,[CQuarter])+ 'Y' + convert(varchar,[CYear]) AS Item
					,SUM([ASP])
					,SUM([ALC])
					,SUM([PPL])
				FROM [Multek_ZH].[dbo].[KOI_ASPAndALCAndPLL]
				WHERE [Sale]=@Sale
						AND ([CYear] > @FromYear OR ([CYear]=@FromYear AND [CQuarter]>=@FromQuarter))
						AND ([FYear] < @ToYear   OR ([FYear]=@ToYear   AND [CQuarter]<=@ToQuarter))
				GROUP BY [CYear], [CQuarter]
				ORDER BY [CYear], [CQuarter]
				
			END
			ELSE IF @Plant='All exclude 2F'
			BEGIN
				INSERT INTO [#T]
				SELECT 
					'Q' + convert(varchar,[CQuarter])+ 'Y' + convert(varchar,[CYear]) AS Item
					,SUM([ASP])
					,SUM([ALC])
					,SUM([PPL])
				FROM [Multek_ZH].[dbo].[KOI_ASPAndALCAndPLL]
				WHERE [Sale]=@Sale
						AND ([CYear] > @FromYear OR ([CYear]=@FromYear AND [CQuarter]>=@FromQuarter))
						AND ([CYear] < @ToYear   OR ([CYear]=@ToYear   AND [CQuarter]<=@ToQuarter))
						AND [Plant]!='2F'
				GROUP BY [CYear], [CQuarter]
				ORDER BY [CYear], [CQuarter]
						
			END
			ELSE
			BEGIN
				INSERT INTO [#T]
				SELECT 
					'Q' + convert(varchar,[CQuarter])+ 'Y' + convert(varchar,[CYear]) AS Item
					,SUM([ASP])
					,SUM([ALC])
					,SUM([PPL])
				FROM [Multek_ZH].[dbo].[KOI_ASPAndALCAndPLL]
				WHERE [Sale]=@Sale
						AND ([CYear] > @FromYear OR ([CYear]=@FromYear AND [CQuarter]>=@FromQuarter))
						AND ([CYear] < @ToYear   OR ([CYear]=@ToYear   AND [CQuarter]<=@ToQuarter))
						AND [Plant]=@Plant
				GROUP BY [CYear], [CQuarter]
				ORDER BY [CYear], [CQuarter]
						
			END
			
			
			-- END Quarterly
		END
		ELSE IF @Report='Monthly'
		BEGIN
			--Monthly
			IF @Plant='All'
			BEGIN
				INSERT INTO [#T]
				SELECT 
					'M' + convert(varchar,[CMonth])+ 'Y' + convert(varchar,[CYear]) AS Item
					,SUM([ASP])
					,SUM([ALC])
					,SUM([PPL])
				FROM [Multek_ZH].[dbo].[KOI_ASPAndALCAndPLL]
				WHERE [Sale]=@Sale
						AND ([CYear] > @FromYear OR ([CYear]=@FromYear AND [CMonth]>=@FromPeriod))
						AND ([CYear] < @ToYear   OR ([CYear]=@ToYear   AND [CMonth]<=@ToPeriod))
				GROUP BY [CYear], [CMonth]
				ORDER BY [CYear], [CMonth]
				
			END
			ELSE IF @Plant='All exclude 2F'
			BEGIN
				INSERT INTO [#T]
				SELECT 
					'M' + convert(varchar,[CMonth])+ 'Y' + convert(varchar,[CYear]) AS Item
					,SUM([ASP])
					,SUM([ALC])
					,SUM([PPL])
				FROM [Multek_ZH].[dbo].[KOI_ASPAndALCAndPLL]
				WHERE [Sale]=@Sale
						AND ([CYear] > @FromYear OR ([CYear]=@FromYear AND [CMonth]>=@FromPeriod))
						AND ([CYear] < @ToYear   OR ([CYear]=@ToYear   AND [CMonth]<=@ToPeriod))
						AND [Plant]!='2F'
				GROUP BY [CYear], [CMonth]
				ORDER BY [CYear], [CMonth]
						
			END
			ELSE
			BEGIN
				INSERT INTO [#T]
				SELECT 
					'M' + convert(varchar,[CMonth])+ 'Y' + convert(varchar,[CYear]) AS Item
					,SUM([ASP])
					,SUM([ALC])
					,SUM([PPL])
				FROM [Multek_ZH].[dbo].[KOI_ASPAndALCAndPLL]
				WHERE [Sale]=@Sale
						AND ([CYear] > @FromYear OR ([CYear]=@FromYear AND [CMonth]>=@FromPeriod))
						AND ([CYear] < @ToYear   OR ([CYear]=@ToYear   AND [CMonth]<=@ToPeriod))
						AND [Plant]=@Plant
				GROUP BY [CYear], [CMonth]
				ORDER BY [CYear], [CMonth]
						
			END
			
			
			--END Monthly			
		END
		ELSE IF @Report='Weekly'
		BEGIN
			--Weekly
			IF @Plant='All'
			BEGIN
				INSERT INTO [#T]
				SELECT 
					'W' + convert(varchar,[CYearWeek])+ 'Y' +convert(varchar,[CYear]) AS Item
					,SUM([ASP])
					,SUM([ALC])
					,SUM([PPL])
				FROM [Multek_ZH].[dbo].[KOI_ASPAndALCAndPLL]
				WHERE [Sale]=@Sale
						AND ([CYear] > @FromYear OR ([CYear]=@FromYear AND [CYearWeek]>=@FromWeek))
						AND ([CYear] < @ToYear   OR ([CYear]=@ToYear   AND [CYearWeek]<=@ToWeek))
				GROUP BY [CYear], [CYearWeek]
				ORDER BY [CYear], [CYearWeek]
				
			END
			ELSE IF @Plant='All exclude 2F'
			BEGIN
				INSERT INTO [#T]
				SELECT 
					'W' + convert(varchar,[CYearWeek])+ 'Y' +convert(varchar,[CYear]) AS Item
					,SUM([ASP])
					,SUM([ALC])
					,SUM([PPL])
				FROM [Multek_ZH].[dbo].[KOI_ASPAndALCAndPLL]
				WHERE [Sale]=@Sale
						AND ([CYear] > @FromYear OR ([CYear]=@FromYear AND [CYearWeek]>=@FromWeek))
						AND ([CYear] < @ToYear   OR ([CYear]=@ToYear   AND [CYearWeek]<=@ToWeek))
						AND [Plant]!='2F'
				GROUP BY [CYear], [CYearWeek]
				ORDER BY [CYear], [CYearWeek]
						
			END
			ELSE
			BEGIN
				INSERT INTO [#T]
				SELECT 
					'W' + convert(varchar,[CYearWeek])+ 'Y' +convert(varchar,[CYear]) AS Item
					,SUM([ASP])
					,SUM([ALC])
					,SUM([PPL])
				FROM [Multek_ZH].[dbo].[KOI_ASPAndALCAndPLL]
				WHERE [Sale]=@Sale
						AND ([CYear] > @FromYear OR ([CYear]=@FromYear AND [CYearWeek]>=@FromWeek))
						AND ([CYear] < @ToYear   OR ([CYear]=@ToYear   AND [CYearWeek]<=@ToWeek))
						AND [Plant]=@Plant
				GROUP BY [CYear], [CYearWeek]
				ORDER BY [CYear], [CYearWeek]
						
			END
			
			
			--END Weekly	
		END
		
		
		--END Calender
	END


	--行转列
	DECLARE   @ALCString   varchar(8000) 
	DECLARE   @ASPString   varchar(8000) 
	DECLARE   @PPLString   varchar(8000) 
	SET @ALCString = 'SELECT  ''ALC'' AS Category'
	SET @ASPString =  'SELECT  ''ASP'' AS Category'
	SET @PPLString  = 'SELECT  ''PPL'' AS Category'
	SELECT 
		@ALCString  = @ALCString + ' , ' + convert(varchar,[ALC]) + ' AS ' + [Item]
		,@ASPString = @ASPString + ' , ' + convert(varchar,[ASP]) + ' AS ' + [Item]
		,@PPLString = @PPLString + + ' , ' + convert(varchar,[PPL]) + ' AS ' + [Item]
	FROM [#T]
	
	SELECT 
		@ALCString  = @ALCString + ' , ' + convert(varchar,AVG([ALC])) + ' AS QTD' 
		,@ASPString = @ASPString + ' , ' + convert(varchar,AVG([ASP])) + ' AS QTD' 
		,@PPLString = @PPLString + + ' , ' + convert(varchar,AVG([PPL])) + ' AS QTD' 
	FROM [#T]	


	EXEC(@ALCString + ' UNION ALL ' + @ASPString+ ' UNION ALL ' + @PPLString) 

	--Delete Table
	DROP TABLE [dbo].[#T]

END



GO
