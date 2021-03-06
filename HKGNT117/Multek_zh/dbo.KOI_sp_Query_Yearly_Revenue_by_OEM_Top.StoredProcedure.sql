USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[KOI_sp_Query_Yearly_Revenue_by_OEM_Top]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[KOI_sp_Query_Yearly_Revenue_by_OEM_Top]
	@ReportCode VARCHAR(4),
	@Year_s VARCHAR(10),
	@Year_e VARCHAR(10),
	@Sale NVARCHAR(20),
	@Sortingby NVARCHAR(20),
	@Plant NVARCHAR(50),
	@RowIndex int,
	@dols_sqft VARCHAR(10),
	@Account NVARCHAR(50) 

AS
BEGIN
	SET NOCOUNT ON;
		-- Create Table 
		CREATE TABLE #TEMP
		(
			[Year] VARCHAR(4),
			Plant NVARCHAR(20),
			OEM NVARCHAR(100),
			Revenue float
		)

		declare @FyorCalender varchar(4),@OthersOEM nvarchar(max),@SQLString VARCHAR(MAX),@sql nvarchar(max),@QuertString VARCHAR(MAX) 

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
				set @SQLString=('INSERT INTO #TEMP SELECT FiscalYear+1,(case T$Plnt WHEN ''P2'' THEN ''B1'' WHEN ''2F'' THEN ''B2F'' ELSE T$Plnt end),T$CSGS,ISNULL(SUM('+@dols_sqft+'),0) FROM TFSOLP107180 t 
						 LEFT JOIN DataWarehouse.dbo.DW_DIM_Calender c ON t.T$DATE=c.calenderDate 
						 where t.T$LOCA=''Chi'' '+@QuertString+'  
						 AND CONVERT(VARCHAR,c.FiscalYear+1) BETWEEN '''+@Year_s+''' and '''+@Year_e+''' group by t.T$Plnt,t.T$CSGS,c.FiscalYear')
			END 
			--FG OUT
			IF @Sale='FGOut'
			BEGIN
				set @SQLString=('INSERT INTO #TEMP SELECT FiscalYear+1,(case T$Plnt WHEN ''P2'' THEN ''P2'' WHEN ''2F'' THEN ''B2F'' ELSE T$Plnt end),T$CSGS,ISNULL(SUM('+@dols_sqft+'),0) FROM TFSOLP105180 t 
						 LEFT JOIN DataWarehouse.dbo.DW_DIM_Calender c ON t.T$DATE=c.calenderDate 
						 where t.T$LOCA=''Chi'' '+@QuertString+' 
						 AND CONVERT(VARCHAR,c.FiscalYear+1) BETWEEN '''+@Year_s+''' and '''+@Year_e+''' group by t.T$Plnt,t.T$CSGS,c.FiscalYear')
			END 
			--Invoice 
			IF @Sale='Invoice'
			BEGIN
				set @SQLString=('INSERT INTO #TEMP SELECT FiscalYear+1,(case T$Plnt WHEN ''P2'' THEN ''P2'' WHEN ''2F'' THEN ''B2F'' ELSE T$Plnt end),T$CSGS,ISNULL(SUM('+@dols_sqft+'),0) FROM TFSOLP106180 t 
						 LEFT JOIN DataWarehouse.dbo.DW_DIM_Calender c ON t.T$DATE=c.calenderDate 
						 where t.T$LOCA=''Chi'' '+@QuertString+' 
						 AND CONVERT(VARCHAR,c.FiscalYear+1) BETWEEN '''+@Year_s+''' and '''+@Year_e+''' group by t.T$Plnt,t.T$CSGS,c.FiscalYear')
			END 
		END
	ELSE
		BEGIN 
			--Calender
			--FG In
			IF @Sale='FGIn'
			BEGIN
				set @SQLString=('INSERT INTO #TEMP SELECT CalenderYear,(case T$Plnt WHEN ''P2'' THEN ''P2'' WHEN ''2F'' THEN ''B2F'' ELSE T$Plnt end),T$CSGS,ISNULL(SUM('+@dols_sqft+'),0) FROM TFSOLP107180 t 
						 LEFT JOIN DataWarehouse.dbo.DW_DIM_Calender c ON t.T$DATE=c.calenderDate 
						 where t.T$LOCA=''Chi'' '+@QuertString+' 
						 AND CONVERT(VARCHAR,c.CalenderYear) BETWEEN '''+@Year_s+''' and '''+@Year_e+''' group by t.T$Plnt,t.T$CSGS,c.CalenderYear')
			END 
			--FG OUT
			IF @Sale='FGOut'
			BEGIN
				set @SQLString=('INSERT INTO #TEMP SELECT CalenderYear,(case T$Plnt WHEN ''P2'' THEN ''P2'' WHEN ''2F'' THEN ''B2F'' ELSE T$Plnt end),T$CSGS,ISNULL(SUM('+@dols_sqft+'),0) FROM TFSOLP105180 t 
						 LEFT JOIN DataWarehouse.dbo.DW_DIM_Calender c ON t.T$DATE=c.calenderDate 
						 where t.T$LOCA=''Chi'' '+@QuertString+' 
						 AND CONVERT(VARCHAR,c.CalenderYear) BETWEEN '''+@Year_s+''' and '''+@Year_e+''' group by t.T$Plnt,t.T$CSGS,c.CalenderYear')
			END 
			--Invoice 
			IF @Sale='Invoice'
			BEGIN
				set @SQLString=('INSERT INTO #TEMP SELECT CalenderYear,(case T$Plnt WHEN ''P2'' THEN ''P2'' WHEN ''2F'' THEN ''B2F'' ELSE T$Plnt end),T$CSGS,ISNULL(SUM('+@dols_sqft+'),0) FROM TFSOLP106180 t 
						 LEFT JOIN DataWarehouse.dbo.DW_DIM_Calender c ON t.T$DATE=c.calenderDate 
						 where t.T$LOCA=''Chi'' '+@QuertString+' 
						 AND CONVERT(VARCHAR,c.CalenderYear) BETWEEN '''+@Year_s+''' and '''+@Year_e+''' group by t.T$Plnt,t.T$CSGS,c.CalenderYear')
			END 
		END 
	exec(@SQLString)


		IF @RowIndex<>'0'
		SET ROWCOUNT @RowIndex 
		IF @Sortingby='ByNameASC'
			BEGIN	
			select @sql = isnull(@sql + '],[' , '') + OEM from #TEMP group by OEM order by OEM ASC  
			END
		IF @Sortingby='ByNameDesc'
			BEGIN	
			select @sql = isnull(@sql + '],[' , '') + OEM from #TEMP group by OEM order by OEM DESC  
			END
		IF @Sortingby='ByRevenueDesc'
			BEGIN
			select @sql = isnull(@sql + '],[' , '') + OEM from #TEMP group by OEM order by sum(Revenue) DESC 
			END
		IF @Sortingby='ByRevenueASC'
			BEGIN
			select @sql = isnull(@sql + '],[' , '') + OEM from #TEMP group by OEM order by sum(Revenue) ASC  
			END

		if @sql<>''
		BEGIN
			set @sql = '[' + @sql + ']'
			SET ROWCOUNT 0		
			--Others OEM
			set @OthersOEM = Replace(Replace(@sql,'[',''''),']','''') 

			exec ('select *,
				  (select ISNULL(SUM(Revenue),0) from #TEMP where [Year]=replace(b.[Year],''FY'','''')
				  and OEM not in ('+@OthersOEM+')) as Others 
				  from (select '''+@FyorCalender+'''+[Year] as [Year],OEM,Revenue from #TEMP ) 
				 a pivot (SUM(Revenue) for OEM in (' + @sql + ')) b order by [Year] ') 	
			END
	DROP TABLE #TEMP 
END








GO
