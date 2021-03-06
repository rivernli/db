USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[KOI_sp_Query_Weekly_Revenue_by_Technology_Key]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[KOI_sp_Query_Weekly_Revenue_by_Technology_Key]
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
			Week VARCHAR(2),
			Plant NVARCHAR(20),
			Technology NVARCHAR(100),
			Revenue float
		)

    -- Insert statements for procedure here
    DECLARE @FyorCalender varchar(4),@QuertString NVARCHAR(MAX), @sql NVARCHAR(MAX), @FiscalYear VARCHAR(4),@FiscalWeek VARCHAR(4),@FiscalWeekFrom VARCHAR(20),@FiscalWeekTo VARCHAR(20), @Amount NUMERIC(18,2),@Technology NVARCHAR(300) 
	
		IF @ReportCode='001'		
		BEGIN
			SET @FyorCalender='FY'		
			DECLARE Technology_Week_C CURSOR FOR 	
			SELECT FiscalYear+1 AS FiscalYear,FiscalWeek,CONVERT(varchar(12),FiscalWeekFrom,23) as FiscalWeekFrom,CONVERT(varchar(12),FiscalWeekTo,23) as FiscalWeekTo
			FROM  DataWarehouse.dbo.DW_DIM_Calender 
			WHERE Calenderdate < CONVERT(VARCHAR(10),GETDATE()-1,120) AND CONVERT(VARCHAR,FiscalYear+1)+right(100+FiscalWeek,2) BETWEEN @Year_s and @Year_e  
			GROUP BY FiscalYear,FiscalWeek,FiscalWeekFrom,FiscalWeekTo
			ORDER BY FiscalYear DESC,FiscalWeekTo DESC  
		END
		ELSE
		BEGIN
			DECLARE Technology_Week_C CURSOR FOR 
			SELECT CalenderYear as FiscalYear,calenderWeek as FiscalWeek,CalenderDateFrom as FiscalWeekFrom,CalenderDateTo as FiscalWeekTo  
			FROM vw_KOI_Calender_Week WHERE CONVERT(VARCHAR,CalenderYear)+right(100+calenderWeek,2) BETWEEN @Year_s and @Year_e  
			GROUP BY CalenderYear,calenderWeek,CalenderDateFrom,CalenderDateTo 
			ORDER BY CalenderYear DESC,CalenderDateTo DESC 
		END

		OPEN Technology_Week_C
		FETCH NEXT FROM Technology_Week_C INTO @Fiscalyear,@FiscalWeek,@FiscalWeekFrom,@FiscalWeekTo
	
		WHILE @@FETCH_STATUS=0
		BEGIN
			IF @FiscalWeekTo>CONVERT(VARCHAR(10),DATEADD(DAY,-1,GETDATE()),120)
				BEGIN
					SET @FiscalWeekTo=CONVERT(VARCHAR(10),DATEADD(DAY,-1,GETDATE()),120)
				END

			DECLARE Week_Technology CURSOR FOR
				SELECT replace(Technology,'''','"') as Technology FROM KOI_Revenue_by_Technology_SetKey where plant=@plant AND CreateUser=@Account group by Technology order by Technology ASC 
				OPEN Week_Technology
				FETCH NEXT FROM Week_Technology INTO @Technology 	
				WHILE @@FETCH_STATUS=0
					BEGIN
						--FG In		
						IF @Sale='FGIn'
						BEGIN 
							IF @Plant='All'
							BEGIN 
								SET @Amount = (SELECT ISNULL(SUM(T$DOLS),0) FROM TFSOLP107180 t INNER JOIN  FactoryLoading.dbo.TFIATT006180 b on t.T$ITEM=b.T$ITEM  where T$LOCA='Chi' AND b.T$ATTR='type' AND T$PLNT<>'HK' AND T$DATE BETWEEN @FiscalWeekFrom and @FiscalWeekTo AND T$ASTR=@Technology) 								
							END
							ELSE 
							IF @Plant='Allexclude2F'
								BEGIN 
									SET @Amount= (SELECT ISNULL(SUM(T$DOLS),0) FROM TFSOLP107180 t INNER JOIN  FactoryLoading.dbo.TFIATT006180 b on t.T$ITEM=b.T$ITEM where T$LOCA='Chi' AND b.T$ATTR='type' AND T$PLNT<>'HK' and T$PLNT<>'2F' AND T$DATE BETWEEN @FiscalWeekFrom and @FiscalWeekTo AND T$ASTR=@Technology)  																		
								END
							ELSE 
								BEGIN
									SET @Amount= (SELECT ISNULL(SUM(T$DOLS),0) FROM TFSOLP107180 t INNER JOIN  FactoryLoading.dbo.TFIATT006180 b on t.T$ITEM=b.T$ITEM where T$LOCA='Chi' AND b.T$ATTR='type' AND T$PLNT=(case @Plant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' ELSE @Plant end) AND T$DATE BETWEEN @FiscalWeekFrom and @FiscalWeekTo AND T$ASTR=@Technology)   
								END
						END 
						--FG OUT
						IF @Sale='FGOut'
						BEGIN
							IF @Plant='All'
							BEGIN 
								SET @Amount = (SELECT ISNULL(SUM(T$DOLS),0) FROM TFSOLP105180 t INNER JOIN  FactoryLoading.dbo.TFIATT006180 b on t.T$ITEM=b.T$ITEM  where T$LOCA='Chi' AND b.T$ATTR='type' AND T$PLNT<>'HK' AND T$DATE BETWEEN @FiscalWeekFrom and @FiscalWeekTo AND T$ASTR=@Technology) 								
							END
							ELSE 
							IF @Plant='Allexclude2F'
								BEGIN 
									SET @Amount= (SELECT ISNULL(SUM(T$DOLS),0) FROM TFSOLP105180 t INNER JOIN  FactoryLoading.dbo.TFIATT006180 b on t.T$ITEM=b.T$ITEM where T$LOCA='Chi' AND b.T$ATTR='type' AND T$PLNT<>'HK' and T$PLNT<>'2F' AND T$DATE BETWEEN @FiscalWeekFrom and @FiscalWeekTo AND T$ASTR=@Technology)  																		
								END
							ELSE 
								BEGIN
									SET @Amount= (SELECT ISNULL(SUM(T$DOLS),0) FROM TFSOLP105180 t INNER JOIN  FactoryLoading.dbo.TFIATT006180 b on t.T$ITEM=b.T$ITEM where T$LOCA='Chi' AND b.T$ATTR='type' AND T$PLNT=(case @Plant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' ELSE @Plant end) AND T$DATE BETWEEN @FiscalWeekFrom and @FiscalWeekTo AND T$ASTR=@Technology)   
								END
						END
						--Invoice 
						IF @Sale='Invoice'
						BEGIN
							IF @Plant='All'
							BEGIN 
								SET @Amount = (SELECT ISNULL(SUM(T$DOLS),0) FROM TFSOLP106180 t INNER JOIN  FactoryLoading.dbo.TFIATT006180 b on t.T$ITEM=b.T$ITEM  where T$LOCA='Chi' AND b.T$ATTR='type' AND T$PLNT<>'HK' AND T$DATE BETWEEN @FiscalWeekFrom and @FiscalWeekTo AND T$ASTR=@Technology) 								
							END
							ELSE 
							IF @Plant='Allexclude2F'
								BEGIN 
									SET @Amount= (SELECT ISNULL(SUM(T$DOLS),0) FROM TFSOLP106180 t INNER JOIN  FactoryLoading.dbo.TFIATT006180 b on t.T$ITEM=b.T$ITEM where T$LOCA='Chi' AND b.T$ATTR='type' AND T$PLNT<>'HK' and T$PLNT<>'2F' AND T$DATE BETWEEN @FiscalWeekFrom and @FiscalWeekTo AND T$ASTR=@Technology)  																		
								END
							ELSE 
								BEGIN
									SET @Amount= (SELECT ISNULL(SUM(T$DOLS),0) FROM TFSOLP106180 t INNER JOIN  FactoryLoading.dbo.TFIATT006180 b on t.T$ITEM=b.T$ITEM where T$LOCA='Chi' AND b.T$ATTR='type' AND T$PLNT=(case @Plant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' ELSE @Plant end) AND T$DATE BETWEEN @FiscalWeekFrom and @FiscalWeekTo AND T$ASTR=@Technology)   
								END
						END

						INSERT INTO #TEMP VALUES(@FiscalYear,@FiscalWeek,@plant,@Technology,@Amount)
						
						FETCH NEXT FROM Week_Technology INTO @Technology 
					END	 
				CLOSE Week_Technology 
				DEALLOCATE Week_Technology 	

			FETCH NEXT FROM Technology_Week_C INTO @FiscalYear,@FiscalWeek,@FiscalWeekFrom,@FiscalWeekTo
		END
	CLOSE Technology_Week_C
	DEALLOCATE Technology_Week_C
	
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
				  from (select '''+@FyorCalender+'''+[Year]+''.''+CONVERT(VARCHAR,right(100+Week,2)) as [Year],Technology,Revenue from #TEMP ) 
				 a pivot (SUM(Revenue) for Technology in (' + @sql + ')) b order by [Year] ') 	

		 END
DROP TABLE #TEMP 
END 

GO
