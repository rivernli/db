USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[KOI_sp_Query_Quarterly_Revenue_by_Technology_Top]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
create PROCEDURE [dbo].[KOI_sp_Query_Quarterly_Revenue_by_Technology_Top]
	@ReportCode VARCHAR(4),
	@Year_s VARCHAR(10),
	@Year_e VARCHAR(10),
	@Sale NVARCHAR(20),
	@Sortingby NVARCHAR(20),
	@Plant NVARCHAR(50),
	@RowIndex int,
	@Account NVARCHAR(50) 

AS
BEGIN
	SET NOCOUNT ON;
		-- Create Table 
		CREATE TABLE #TEMP
		(
			[Year] VARCHAR(4),
			Quarter VARCHAR(2),
			Plant NVARCHAR(20),
			Technology NVARCHAR(100),
			Revenue float
		)

		declare @FyorCalender varchar(4),@SQLString VARCHAR(MAX),@sql nvarchar(max),@QuertString VARCHAR(MAX) 

IF @Plant='All'
		BEGIN
		SET @QuertString = ' AND t.T$PLNT<>''HK'' '
		END
	ELSE 
	IF @Plant='Allexclude2F'
		BEGIN
		SET @QuertString=' AND t.T$PLNT<>''HK'' and t.T$PLNT<>''2F'' '
		END
	ELSE 
		BEGIN
		SET @QuertString=' AND t.T$PLNT=(case '''+@Plant+''' WHEN ''B1'' THEN ''P2'' WHEN ''B2F'' THEN ''2F'' ELSE '''+@Plant+''' end) '
		END

 -- temp table 
	IF @ReportCode='001' 
		BEGIN
			SET @FyorCalender='FY'
			--FG In
			IF @Sale='FGIn'
			BEGIN 
				set @SQLString=('INSERT INTO #TEMP SELECT FiscalYear+1,FiscalQuarter,(case T$Plnt WHEN ''P2'' THEN ''B1'' WHEN ''2F'' THEN ''B2F'' ELSE T$Plnt end),T$ASTR,
						 ISNULL(SUM(T$DOLS),0) FROM TFSOLP107180 t 
						 INNER JOIN  FactoryLoading.dbo.TFIATT006180 b on t.T$ITEM=b.T$ITEM 
						 INNER JOIN DataWarehouse.dbo.DW_DIM_Calender c ON t.T$DATE=c.calenderDate 
						 where t.T$LOCA=''Chi'' AND b.T$ATTR=''type'' '+@QuertString+'  
						 AND CONVERT(VARCHAR,c.FiscalYear+1)+right(100+c.FiscalQuarter,2) BETWEEN '''+@Year_s+''' and '''+@Year_e+''' group by t.T$Plnt,b.T$ASTR,c.FiscalYear,c.FiscalQuarter')
			END 
			--FG OUT
			IF @Sale='FGOut'
			BEGIN
				set @SQLString=('INSERT INTO #TEMP SELECT FiscalYear+1,FiscalQuarter,(case T$Plnt WHEN ''P2'' THEN ''B1'' WHEN ''2F'' THEN ''B2F'' ELSE T$Plnt end),T$ASTR,
						 ISNULL(SUM(T$DOLS),0) FROM TFSOLP105180 t 
						 INNER JOIN  FactoryLoading.dbo.TFIATT006180 b on t.T$ITEM=b.T$ITEM 
						 INNER JOIN DataWarehouse.dbo.DW_DIM_Calender c ON t.T$DATE=c.calenderDate 
						 where t.T$LOCA=''Chi'' AND b.T$ATTR=''type'' '+@QuertString+'  
						 AND CONVERT(VARCHAR,c.FiscalYear+1)+right(100+c.FiscalQuarter,2) BETWEEN '''+@Year_s+''' and '''+@Year_e+''' group by t.T$Plnt,b.T$ASTR,c.FiscalYear,c.FiscalQuarter') 
			END 
			--Invoice 
			IF @Sale='Invoice'
			BEGIN 
				set @SQLString=('INSERT INTO #TEMP SELECT FiscalYear+1,FiscalQuarter,(case T$Plnt WHEN ''P2'' THEN ''B1'' WHEN ''2F'' THEN ''B2F'' ELSE T$Plnt end),T$ASTR,
						 ISNULL(SUM(T$DOLS),0) FROM TFSOLP106180 t 
						 INNER JOIN  FactoryLoading.dbo.TFIATT006180 b on t.T$ITEM=b.T$ITEM 
						 INNER JOIN DataWarehouse.dbo.DW_DIM_Calender c ON t.T$DATE=c.calenderDate 
						 where t.T$LOCA=''Chi'' AND b.T$ATTR=''type'' '+@QuertString+'  
						 AND CONVERT(VARCHAR,c.FiscalYear+1)+right(100+c.FiscalQuarter,2) BETWEEN '''+@Year_s+''' and '''+@Year_e+''' group by t.T$Plnt,b.T$ASTR,c.FiscalYear,c.FiscalQuarter') 
			END 
		END
	ELSE
		BEGIN 
			--Calender
			--FG In
			IF @Sale='FGIn'
			BEGIN 
				set @SQLString=('INSERT INTO #TEMP SELECT CalenderYear,CalenderQuarter,(case T$Plnt WHEN ''P2'' THEN ''B1'' WHEN ''2F'' THEN ''B2F'' ELSE T$Plnt end),T$ASTR,
						 ISNULL(SUM(T$DOLS),0) FROM TFSOLP107180 t 
						 INNER JOIN  FactoryLoading.dbo.TFIATT006180 b on t.T$ITEM=b.T$ITEM 
						 INNER JOIN DataWarehouse.dbo.DW_DIM_Calender c ON t.T$DATE=c.calenderDate 
						 where t.T$LOCA=''Chi'' AND b.T$ATTR=''type'' '+@QuertString+'  
						 AND CONVERT(VARCHAR,c.CalenderYear)+right(100+c.CalenderQuarter,2) BETWEEN '''+@Year_s+''' and '''+@Year_e+''' group by t.T$Plnt,b.T$ASTR,c.CalenderYear,c.CalenderQuarter') 
			END 
			--FG OUT
			IF @Sale='FGOut'
			BEGIN
				set @SQLString=('INSERT INTO #TEMP SELECT CalenderYear,CalenderQuarter,(case T$Plnt WHEN ''P2'' THEN ''B1'' WHEN ''2F'' THEN ''B2F'' ELSE T$Plnt end),T$ASTR,
						 ISNULL(SUM(T$DOLS),0) FROM TFSOLP105180 t 
						 INNER JOIN  FactoryLoading.dbo.TFIATT006180 b on t.T$ITEM=b.T$ITEM 
						 INNER JOIN DataWarehouse.dbo.DW_DIM_Calender c ON t.T$DATE=c.calenderDate 
						 where t.T$LOCA=''Chi'' AND b.T$ATTR=''type'' '+@QuertString+'  
						 AND CONVERT(VARCHAR,c.CalenderYear)+right(100+c.CalenderQuarter,2) BETWEEN '''+@Year_s+''' and '''+@Year_e+''' group by t.T$Plnt,b.T$ASTR,c.CalenderYear,c.CalenderQuarter') 
			END 
			--Invoice 
			IF @Sale='Invoice'
			BEGIN 
				set @SQLString=('INSERT INTO #TEMP SELECT CalenderYear,CalenderQuarter,(case T$Plnt WHEN ''P2'' THEN ''B1'' WHEN ''2F'' THEN ''B2F'' ELSE T$Plnt end),T$ASTR,
						 ISNULL(SUM(T$DOLS),0) FROM TFSOLP106180 t 
						 INNER JOIN  FactoryLoading.dbo.TFIATT006180 b on t.T$ITEM=b.T$ITEM 
						 INNER JOIN DataWarehouse.dbo.DW_DIM_Calender c ON t.T$DATE=c.calenderDate 
						 where t.T$LOCA=''Chi'' AND b.T$ATTR=''type'' '+@QuertString+'  
						 AND CONVERT(VARCHAR,c.CalenderYear)+right(100+c.CalenderQuarter,2) BETWEEN '''+@Year_s+''' and '''+@Year_e+''' group by t.T$Plnt,b.T$ASTR,c.CalenderYear,c.CalenderQuarter') 
			END 
		END 
	exec(@SQLString)


		IF @RowIndex<>'0'
		SET ROWCOUNT @RowIndex 
		IF @Sortingby='ByNameDesc'
			BEGIN	
			select @sql = isnull(@sql + '],[' , '') + Technology from #TEMP group by Technology order by Technology ASC  
			END
		IF @Sortingby='ByRevenueDesc'
			BEGIN
			select @sql = isnull(@sql + '],[' , '') + Technology from #TEMP group by Technology order by sum(Revenue) DESC 
			END
		IF @Sortingby='ByRevenueASC'
			BEGIN
			select @sql = isnull(@sql + '],[' , '') + Technology from #TEMP group by Technology order by sum(Revenue) ASC  
			END

		if @sql<>''
		BEGIN
			set @sql = '[' + @sql + ']'
			SET ROWCOUNT 0		

			exec ('select *
				  from (select '''+@FyorCalender+'''+[Year]+''.''+CONVERT(VARCHAR,right(100+Quarter,2)) as [Year],Technology,Revenue from #TEMP ) 
				 a pivot (SUM(Revenue) for Technology in (' + @sql + ')) b order by [Year] ') 	
			END
	DROP TABLE #TEMP 
END








GO
