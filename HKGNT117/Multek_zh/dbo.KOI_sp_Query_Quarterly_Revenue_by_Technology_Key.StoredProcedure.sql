USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[KOI_sp_Query_Quarterly_Revenue_by_Technology_Key]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[KOI_sp_Query_Quarterly_Revenue_by_Technology_Key]
	-- Add the parameters for the stored procedure here
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
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
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

    -- Insert statements for procedure here
    DECLARE @FyorCalender varchar(4),@QuertString NVARCHAR(MAX), @sql NVARCHAR(MAX), @FiscalYear VARCHAR(4),@FiscalQuarter VARCHAR(4),@FiscalQuarterFrom VARCHAR(20),@FiscalQuarterTo VARCHAR(20), @Amount NUMERIC(18,2),@Technology NVARCHAR(300) 
	
		IF @ReportCode='001'		
		BEGIN
			SET @FyorCalender='FY'		
			DECLARE Technology_Quarter_C CURSOR FOR 	
			SELECT FiscalYear+1 AS FiscalYear,FiscalQuarter,CONVERT(varchar(12),FiscalQuarterFrom,23) as FiscalQuarterFrom,CONVERT(varchar(12),FiscalQuarterTo,23) as FiscalQuarterTo
			FROM  DataWarehouse.dbo.DW_DIM_Calender 
			WHERE Calenderdate < CONVERT(VARCHAR(10),GETDATE()-1,120) AND CONVERT(VARCHAR,FiscalYear+1)+right(100+FiscalQuarter,2) BETWEEN @Year_s and @Year_e  
			GROUP BY FiscalYear,FiscalQuarter,FiscalQuarterFrom,FiscalQuarterTo
			ORDER BY FiscalYear DESC,FiscalQuarterTo DESC  
		END
		ELSE
		BEGIN
			DECLARE Technology_Quarter_C CURSOR FOR 
			SELECT CalenderYear as FiscalYear,CalenderQuarter as FiscalQuarter,CalenderDateFrom as FiscalQuarterFrom,CalenderDateTo as FiscalQuarterTo  
			FROM vw_KOI_Calender_Quarter WHERE CONVERT(VARCHAR,CalenderYear)+right(100+CalenderQuarter,2) BETWEEN @Year_s and @Year_e  
			GROUP BY CalenderYear,CalenderQuarter,CalenderDateFrom,CalenderDateTo 
			ORDER BY CalenderYear DESC,CalenderDateTo DESC 
		END

		OPEN Technology_Quarter_C
		FETCH NEXT FROM Technology_Quarter_C INTO @Fiscalyear,@FiscalQuarter,@FiscalQuarterFrom,@FiscalQuarterTo
	
		WHILE @@FETCH_STATUS=0
		BEGIN
			IF @FiscalQuarterTo>CONVERT(VARCHAR(10),DATEADD(DAY,-1,GETDATE()),120)
				BEGIN
					SET @FiscalQuarterTo=CONVERT(VARCHAR(10),DATEADD(DAY,-1,GETDATE()),120)
				END

			DECLARE Quarter_Technology_C_107 CURSOR FOR
				SELECT replace(Technology,'''','"') as Technology FROM KOI_Revenue_by_Technology_SetKey where plant=@plant AND CreateUser=@Account group by Technology order by Technology ASC 
				OPEN Quarter_Technology_C_107
				FETCH NEXT FROM Quarter_Technology_C_107 INTO @Technology 	
				WHILE @@FETCH_STATUS=0
					BEGIN
						--FG In		
						IF @Sale='FGIn'
						BEGIN 
							IF @Plant='All'
							BEGIN
								SET @Amount = (SELECT ISNULL(SUM(T$DOLS),0) FROM TFSOLP107180 t INNER JOIN  FactoryLoading.dbo.TFIATT006180 b on t.T$ITEM=b.T$ITEM  where T$LOCA='Chi' AND b.T$ATTR='type' AND T$PLNT<>'HK' AND T$DATE BETWEEN @FiscalQuarterFrom and @FiscalQuarterTo AND T$ASTR=@Technology) 								
							END
							ELSE 
							IF @Plant='Allexclude2F'
								BEGIN
									SET @Amount= (SELECT ISNULL(SUM(T$DOLS),0) FROM TFSOLP107180 t INNER JOIN  FactoryLoading.dbo.TFIATT006180 b on t.T$ITEM=b.T$ITEM where T$LOCA='Chi' AND b.T$ATTR='type' AND T$PLNT<>'HK' and T$PLNT<>'2F' AND T$DATE BETWEEN @FiscalQuarterFrom and @FiscalQuarterTo AND T$ASTR=@Technology)  									
								END
							ELSE 
								BEGIN
									SET @Amount= (SELECT ISNULL(SUM(T$DOLS),0) FROM TFSOLP107180 t INNER JOIN  FactoryLoading.dbo.TFIATT006180 b on t.T$ITEM=b.T$ITEM where T$LOCA='Chi' AND b.T$ATTR='type' AND T$PLNT=(case @Plant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' ELSE @Plant end) AND T$DATE BETWEEN @FiscalQuarterFrom and @FiscalQuarterTo AND T$ASTR=@Technology)  									
								END
						END 
						--FG OUT
						IF @Sale='FGOut'
						BEGIN
							IF @Plant='All'
							BEGIN
								SET @Amount = (SELECT ISNULL(SUM(T$DOLS),0) FROM TFSOLP105180 t INNER JOIN  FactoryLoading.dbo.TFIATT006180 b on t.T$ITEM=b.T$ITEM  where T$LOCA='Chi' AND b.T$ATTR='type' AND T$PLNT<>'HK' AND T$DATE BETWEEN @FiscalQuarterFrom and @FiscalQuarterTo AND T$ASTR=@Technology) 								
							END
							ELSE 
							IF @Plant='Allexclude2F'
								BEGIN
									SET @Amount= (SELECT ISNULL(SUM(T$DOLS),0) FROM TFSOLP105180 t INNER JOIN  FactoryLoading.dbo.TFIATT006180 b on t.T$ITEM=b.T$ITEM where T$LOCA='Chi' AND b.T$ATTR='type' AND T$PLNT<>'HK' and T$PLNT<>'2F' AND T$DATE BETWEEN @FiscalQuarterFrom and @FiscalQuarterTo AND T$ASTR=@Technology)  									
								END
							ELSE 
								BEGIN
									SET @Amount= (SELECT ISNULL(SUM(T$DOLS),0) FROM TFSOLP105180 t INNER JOIN  FactoryLoading.dbo.TFIATT006180 b on t.T$ITEM=b.T$ITEM where T$LOCA='Chi' AND b.T$ATTR='type' AND T$PLNT=(case @Plant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' ELSE @Plant end) AND T$DATE BETWEEN @FiscalQuarterFrom and @FiscalQuarterTo AND T$ASTR=@Technology)  									
								END
						END
						--Invoice 
						IF @Sale='Invoice'
						BEGIN
							IF @Plant='All'
							BEGIN
								SET @Amount = (SELECT ISNULL(SUM(T$DOLS),0) FROM TFSOLP106180 t INNER JOIN  FactoryLoading.dbo.TFIATT006180 b on t.T$ITEM=b.T$ITEM  where T$LOCA='Chi' AND b.T$ATTR='type' AND T$PLNT<>'HK' AND T$DATE BETWEEN @FiscalQuarterFrom and @FiscalQuarterTo AND T$ASTR=@Technology) 								
							END
							ELSE 
							IF @Plant='Allexclude2F'
								BEGIN
									SET @Amount= (SELECT ISNULL(SUM(T$DOLS),0) FROM TFSOLP106180 t INNER JOIN  FactoryLoading.dbo.TFIATT006180 b on t.T$ITEM=b.T$ITEM where T$LOCA='Chi' AND b.T$ATTR='type' AND T$PLNT<>'HK' and T$PLNT<>'2F' AND T$DATE BETWEEN @FiscalQuarterFrom and @FiscalQuarterTo AND T$ASTR=@Technology)  									
								END
							ELSE 
								BEGIN
									SET @Amount= (SELECT ISNULL(SUM(T$DOLS),0) FROM TFSOLP106180 t INNER JOIN  FactoryLoading.dbo.TFIATT006180 b on t.T$ITEM=b.T$ITEM where T$LOCA='Chi' AND b.T$ATTR='type' AND T$PLNT=(case @Plant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' ELSE @Plant end) AND T$DATE BETWEEN @FiscalQuarterFrom and @FiscalQuarterTo AND T$ASTR=@Technology)  									
								END
						END

						INSERT INTO #TEMP VALUES(@FiscalYear,@FiscalQuarter,@plant,@Technology,@Amount)
						
						FETCH NEXT FROM Quarter_Technology_C_107 INTO @Technology 
					END	 
				CLOSE Quarter_Technology_C_107 
				DEALLOCATE Quarter_Technology_C_107 	

			FETCH NEXT FROM Technology_Quarter_C INTO @FiscalYear,@FiscalQuarter,@FiscalQuarterFrom,@FiscalQuarterTo
		END
	CLOSE Technology_Quarter_C
	DEALLOCATE Technology_Quarter_C
	
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
