USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[KOI_sp_Query_Periodly_Revenue_by_OEM_Key]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[KOI_sp_Query_Periodly_Revenue_by_OEM_Key]
	-- Add the parameters for the stored procedure here
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
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Create Table 
		CREATE TABLE #TEMP 
		(
			[Year] VARCHAR(4),
			Period VARCHAR(2),
			Plant NVARCHAR(20),
			OEM NVARCHAR(100),
			Revenue float
		)

    -- Insert statements for procedure here
    DECLARE @FyorCalender varchar(4),@OthersOEM nvarchar(max),@QuertString NVARCHAR(MAX), @sql NVARCHAR(MAX), @FiscalYear VARCHAR(4),@FiscalPeriod VARCHAR(4),@FiscalPeriodFrom VARCHAR(20),@FiscalPeriodTo VARCHAR(20), @Amount NUMERIC(18,2),@OEM NVARCHAR(300) 
	
		IF @ReportCode='001'		
		BEGIN
			SET @FyorCalender='FY'		
			DECLARE OEMPeriod_C CURSOR FOR 	
			SELECT FiscalYear+1 AS FiscalYear,FiscalPeriod,CONVERT(varchar(12),FiscalPeriodFrom,23) as FiscalPeriodFrom,CONVERT(varchar(12),FiscalPeriodTo,23) as FiscalPeriodTo
			FROM  DataWarehouse.dbo.DW_DIM_Calender 
			WHERE Calenderdate < CONVERT(VARCHAR(10),GETDATE()-1,120) AND CONVERT(VARCHAR,FiscalYear+1)+right(100+FiscalPeriod,2) BETWEEN @Year_s and @Year_e  
			GROUP BY FiscalYear,FiscalPeriod,FiscalPeriodFrom,FiscalPeriodTo
			ORDER BY FiscalYear DESC,FiscalPeriodTo DESC  
		END
		ELSE
		BEGIN
			DECLARE OEMPeriod_C CURSOR FOR 
			SELECT CalenderYear as FiscalYear,CalenderMonth as FiscalPeriod,CalenderDateFrom as FiscalPeriodFrom,CalenderDateTo as FiscalPeriodTo  
			FROM vw_KOI_Calender_Month WHERE CONVERT(VARCHAR,CalenderYear)+right(100+CalenderMonth,2) BETWEEN @Year_s and @Year_e  
			GROUP BY CalenderYear,CalenderMonth,CalenderDateFrom,CalenderDateTo 
			ORDER BY CalenderYear DESC,CalenderDateTo DESC 
		END

		OPEN OEMPeriod_C
		FETCH NEXT FROM OEMPeriod_C INTO @Fiscalyear,@FiscalPeriod,@FiscalPeriodFrom,@FiscalPeriodTo
	
		WHILE @@FETCH_STATUS=0
		BEGIN
			IF @FiscalPeriodTo>CONVERT(VARCHAR(10),DATEADD(DAY,-1,GETDATE()),120)
				BEGIN
					SET @FiscalPeriodTo=CONVERT(VARCHAR(10),DATEADD(DAY,-1,GETDATE()),120)
				END

			DECLARE Period_OEM_C_107 CURSOR FOR
				SELECT replace(OEM,'''','"') as OEM FROM KOI_Revenue_by_OEM_SetKey where plant=@plant AND CreateUser=@Account group by OEM order by OEM ASC 
				OPEN Period_OEM_C_107
				FETCH NEXT FROM Period_OEM_C_107 INTO @OEM 	
				WHILE @@FETCH_STATUS=0
					BEGIN
						--FG In		
						IF @Sale='FGIn'
						BEGIN 
							IF @Plant='All'
							BEGIN
								IF @dols_sqft='T$DOLS'
								SET @Amount = (SELECT ISNULL(SUM(T$DOLS),0) FROM TFSOLP107180 where T$LOCA='Chi' AND T$PLNT<>'HK' AND T$DATE BETWEEN @FiscalPeriodFrom and @FiscalPeriodTo AND T$CSGS=@OEM) 
								ELSE
								SET @Amount = (SELECT ISNULL(SUM(T$SQFT),0) FROM TFSOLP107180 where T$LOCA='Chi' AND T$PLNT<>'HK' AND T$DATE BETWEEN @FiscalPeriodFrom and @FiscalPeriodTo AND T$CSGS=@OEM) 
							END
							ELSE 
							IF @Plant='Allexclude2F'
								BEGIN
									IF @dols_sqft='T$DOLS'
									SET @Amount= (SELECT ISNULL(SUM(T$DOLS),0) FROM TFSOLP107180 where T$LOCA='Chi' AND T$PLNT<>'HK' and T$PLNT<>'2F' AND T$DATE BETWEEN @FiscalPeriodFrom and @FiscalPeriodTo AND T$CSGS=@OEM)  
									ELSE
									SET @Amount= (SELECT ISNULL(SUM(T$SQFT),0) FROM TFSOLP107180 where T$LOCA='Chi' AND T$PLNT<>'HK' and T$PLNT<>'2F' AND T$DATE BETWEEN @FiscalPeriodFrom and @FiscalPeriodTo AND T$CSGS=@OEM)  
								END
							ELSE 
								BEGIN 
									IF @dols_sqft='T$DOLS'
									SET @Amount= (SELECT ISNULL(SUM(T$DOLS),0) FROM TFSOLP107180 where T$LOCA='Chi' AND T$PLNT=(case @Plant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' ELSE @Plant end) AND T$DATE BETWEEN @FiscalPeriodFrom and @FiscalPeriodTo AND T$CSGS=@OEM)  
									ELSE
									SET @Amount= (SELECT ISNULL(SUM(T$SQFT),0) FROM TFSOLP107180 where T$LOCA='Chi' AND T$PLNT=(case @Plant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' ELSE @Plant end) AND T$DATE BETWEEN @FiscalPeriodFrom and @FiscalPeriodTo AND T$CSGS=@OEM)  
								END
						END 
						--FG OUT
						IF @Sale='FGOut'
						BEGIN
							IF @Plant='All'
							BEGIN 
								IF @dols_sqft='T$DOLS'
								SET @Amount = (SELECT ISNULL(SUM(T$DOLS),0) FROM TFSOLP105180 where T$LOCA='Chi' AND T$PLNT<>'HK' AND T$DATE BETWEEN @FiscalPeriodFrom and @FiscalPeriodTo AND T$CSGS=@OEM) 
								ELSE 
								SET @Amount = (SELECT ISNULL(SUM(T$SQFT),0) FROM TFSOLP105180 where T$LOCA='Chi' AND T$PLNT<>'HK' AND T$DATE BETWEEN @FiscalPeriodFrom and @FiscalPeriodTo AND T$CSGS=@OEM) 
							END
							ELSE 
							IF @Plant='Allexclude2F'
								BEGIN
									IF @dols_sqft='T$DOLS'
									SET @Amount= (SELECT ISNULL(SUM(T$DOLS),0) FROM TFSOLP105180 where T$LOCA='Chi' AND T$PLNT<>'HK' and T$PLNT<>'2F' AND T$DATE BETWEEN @FiscalPeriodFrom and @FiscalPeriodTo AND T$CSGS=@OEM)  
									ELSE 
									SET @Amount= (SELECT ISNULL(SUM(T$SQFT),0) FROM TFSOLP105180 where T$LOCA='Chi' AND T$PLNT<>'HK' and T$PLNT<>'2F' AND T$DATE BETWEEN @FiscalPeriodFrom and @FiscalPeriodTo AND T$CSGS=@OEM)  
								END
							ELSE 
								BEGIN 
									IF @dols_sqft='T$DOLS'
									SET @Amount= (SELECT ISNULL(SUM(T$DOLS),0) FROM TFSOLP105180 where T$LOCA='Chi' AND T$PLNT=(case @Plant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' ELSE @Plant end) AND T$DATE BETWEEN @FiscalPeriodFrom and @FiscalPeriodTo AND T$CSGS=@OEM)  
									ELSE 
									SET @Amount= (SELECT ISNULL(SUM(T$SQFT),0) FROM TFSOLP105180 where T$LOCA='Chi' AND T$PLNT=(case @Plant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' ELSE @Plant end) AND T$DATE BETWEEN @FiscalPeriodFrom and @FiscalPeriodTo AND T$CSGS=@OEM)  
								END
						END
						--Invoice 
						IF @Sale='Invoice'
						BEGIN
							IF @Plant='All'
							BEGIN 
								IF @dols_sqft='T$DOLS'
								SET @Amount = (SELECT ISNULL(SUM(T$DOLS),0) FROM TFSOLP106180 where T$LOCA='Chi' AND T$PLNT<>'HK' AND T$DATE BETWEEN @FiscalPeriodFrom and @FiscalPeriodTo AND T$CSGS=@OEM) 
								ELSE
								SET @Amount = (SELECT ISNULL(SUM(T$SQFT),0) FROM TFSOLP106180 where T$LOCA='Chi' AND T$PLNT<>'HK' AND T$DATE BETWEEN @FiscalPeriodFrom and @FiscalPeriodTo AND T$CSGS=@OEM) 
							END
							ELSE 
							IF @Plant='Allexclude2F'
								BEGIN
									IF @dols_sqft='T$DOLS'
									SET @Amount= (SELECT ISNULL(SUM(T$DOLS),0) FROM TFSOLP106180 where T$LOCA='Chi' AND T$PLNT<>'HK' and T$PLNT<>'2F' AND T$DATE BETWEEN @FiscalPeriodFrom and @FiscalPeriodTo AND T$CSGS=@OEM)  
									ELSE
									SET @Amount= (SELECT ISNULL(SUM(T$SQFT),0) FROM TFSOLP106180 where T$LOCA='Chi' AND T$PLNT<>'HK' and T$PLNT<>'2F' AND T$DATE BETWEEN @FiscalPeriodFrom and @FiscalPeriodTo AND T$CSGS=@OEM)  
								END
							ELSE 
								BEGIN
									IF @dols_sqft='T$DOLS'
									SET @Amount= (SELECT ISNULL(SUM(T$DOLS),0) FROM TFSOLP106180 where T$LOCA='Chi' AND T$PLNT=(case @Plant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' ELSE @Plant end) AND T$DATE BETWEEN @FiscalPeriodFrom and @FiscalPeriodTo AND T$CSGS=@OEM)  
									ELSE 
									SET @Amount= (SELECT ISNULL(SUM(T$SQFT),0) FROM TFSOLP106180 where T$LOCA='Chi' AND T$PLNT=(case @Plant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' ELSE @Plant end) AND T$DATE BETWEEN @FiscalPeriodFrom and @FiscalPeriodTo AND T$CSGS=@OEM)  
								END
						END

						INSERT INTO #TEMP VALUES(@FiscalYear,@FiscalPeriod,@plant,@OEM,@Amount)
						
						FETCH NEXT FROM Period_OEM_C_107 INTO @OEM 
					END	 
				CLOSE Period_OEM_C_107 
				DEALLOCATE Period_OEM_C_107 	

			FETCH NEXT FROM OEMPeriod_C INTO @FiscalYear,@FiscalPeriod,@FiscalPeriodFrom,@FiscalPeriodTo
		END
	CLOSE OEMPeriod_C
	DEALLOCATE OEMPeriod_C
	
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

--			exec ('select *,
--				  (select ISNULL(SUM(Revenue),0) from #TEMP where [Year]+''.''+CONVERT(VARCHAR,right(100+Period,2))=replace(b.[Year],''FY'','''') 
--				  and OEM not in ('+@OthersOEM+')) as Others 
--				  from (select '''+@FyorCalender+'''+[Year]+''.''+CONVERT(VARCHAR,right(100+Period,2)) as [Year],OEM,Revenue from #TEMP ) 
--				 a pivot (SUM(Revenue) for OEM in (' + @sql + ')) b order by [Year] ') 	

			IF @ReportCode='001'
			BEGIN
				IF @Sale = 'FGIn'
				exec ('select *,
					  (select ISNULL(SUM(T$DOLS),0) from TFSOLP107180 a,DataWarehouse.dbo.DW_DIM_Calender d 
						WHERE a.T$Date=d.CalenderDate AND T$LOCA=''Chi'' AND T$PLNT=(case '''+@Plant+''' WHEN ''B1'' THEN ''P2'' WHEN ''B2F'' THEN ''2F'' ELSE '''+@Plant+''' end) AND T$CSGS not in ('+@OthersOEM+') 
						AND CONVERT(VARCHAR,Fiscalyear+1)+''.''+CONVERT(VARCHAR,right(100+FiscalPeriod,2))=replace(b.[Year],''FY'','''')
						) as Others				 
					  from (select '''+@FyorCalender+'''+[Year]+''.''+CONVERT(VARCHAR,right(100+Period,2)) as [Year],OEM,Revenue from #TEMP ) 
					 a pivot (SUM(Revenue) for OEM in (' + @sql + ')) b order by [Year] ') 	
				IF @Sale = 'FGOut'
				exec ('select *,
					  (select ISNULL(SUM(T$DOLS),0) from TFSOLP105180 a,DataWarehouse.dbo.DW_DIM_Calender d 
						WHERE a.T$Date=d.CalenderDate AND T$LOCA=''Chi'' AND T$PLNT=(case '''+@Plant+''' WHEN ''B1'' THEN ''P2'' WHEN ''B2F'' THEN ''2F'' ELSE '''+@Plant+''' end) AND T$CSGS not in ('+@OthersOEM+') 
						AND CONVERT(VARCHAR,Fiscalyear+1)+''.''+CONVERT(VARCHAR,right(100+FiscalPeriod,2))=replace(b.[Year],''FY'','''')
						) as Others				 
					  from (select '''+@FyorCalender+'''+[Year]+''.''+CONVERT(VARCHAR,right(100+Period,2)) as [Year],OEM,Revenue from #TEMP ) 
					 a pivot (SUM(Revenue) for OEM in (' + @sql + ')) b order by [Year] ') 	
				IF @Sale = 'Invoice'
				exec ('select *,
					  (select ISNULL(SUM(T$DOLS),0) from TFSOLP106180 a,DataWarehouse.dbo.DW_DIM_Calender d 
						WHERE a.T$Date=d.CalenderDate AND T$LOCA=''Chi'' AND T$PLNT=(case '''+@Plant+''' WHEN ''B1'' THEN ''P2'' WHEN ''B2F'' THEN ''2F'' ELSE '''+@Plant+''' end) AND T$CSGS not in ('+@OthersOEM+') 
						AND CONVERT(VARCHAR,Fiscalyear+1)+''.''+CONVERT(VARCHAR,right(100+FiscalPeriod,2))=replace(b.[Year],''FY'','''')
						) as Others				 
					  from (select '''+@FyorCalender+'''+[Year]+''.''+CONVERT(VARCHAR,right(100+Period,2)) as [Year],OEM,Revenue from #TEMP ) 
					 a pivot (SUM(Revenue) for OEM in (' + @sql + ')) b order by [Year] ') 	

				END
			ELSE
			BEGIN
				IF @Sale = 'FGIn'
				exec ('select *,
					  (select ISNULL(SUM(T$DOLS),0) from TFSOLP107180 a,DataWarehouse.dbo.DW_DIM_Calender d 
						WHERE a.T$Date=d.CalenderDate AND T$LOCA=''Chi'' AND T$PLNT=(case '''+@Plant+''' WHEN ''B1'' THEN ''P2'' WHEN ''B2F'' THEN ''2F'' ELSE '''+@Plant+''' end) AND T$CSGS not in ('+@OthersOEM+') 
						AND CONVERT(VARCHAR,CalenderYear)+''.''+CONVERT(VARCHAR,right(100+CalenderMonth,2))=replace(b.[Year],''FY'','''')
						) as Others				 
					  from (select '''+@FyorCalender+'''+[Year]+''.''+CONVERT(VARCHAR,right(100+Period,2)) as [Year],OEM,Revenue from #TEMP ) 
					 a pivot (SUM(Revenue) for OEM in (' + @sql + ')) b order by [Year] ') 	
				IF @Sale = 'FGOut'
				exec ('select *,
					  (select ISNULL(SUM(T$DOLS),0) from TFSOLP105180 a,DataWarehouse.dbo.DW_DIM_Calender d 
						WHERE a.T$Date=d.CalenderDate AND T$LOCA=''Chi'' AND T$PLNT=(case '''+@Plant+''' WHEN ''B1'' THEN ''P2'' WHEN ''B2F'' THEN ''2F'' ELSE '''+@Plant+''' end) AND T$CSGS not in ('+@OthersOEM+') 
						AND CONVERT(VARCHAR,CalenderYear)+''.''+CONVERT(VARCHAR,right(100+CalenderMonth,2))=replace(b.[Year],''FY'','''')
						) as Others				 
					  from (select '''+@FyorCalender+'''+[Year]+''.''+CONVERT(VARCHAR,right(100+Period,2)) as [Year],OEM,Revenue from #TEMP ) 
					 a pivot (SUM(Revenue) for OEM in (' + @sql + ')) b order by [Year] ') 	
				IF @Sale = 'Invoice'
				exec ('select *,
					  (select ISNULL(SUM(T$DOLS),0) from TFSOLP106180 a,DataWarehouse.dbo.DW_DIM_Calender d 
						WHERE a.T$Date=d.CalenderDate AND T$LOCA=''Chi'' AND T$PLNT=(case '''+@Plant+''' WHEN ''B1'' THEN ''P2'' WHEN ''B2F'' THEN ''2F'' ELSE '''+@Plant+''' end) AND T$CSGS not in ('+@OthersOEM+') 
						AND CONVERT(VARCHAR,CalenderYear)+''.''+CONVERT(VARCHAR,right(100+CalenderMonth,2))=replace(b.[Year],''FY'','''')
						) as Others				 
					  from (select '''+@FyorCalender+'''+[Year]+''.''+CONVERT(VARCHAR,right(100+Period,2)) as [Year],OEM,Revenue from #TEMP ) 
					 a pivot (SUM(Revenue) for OEM in (' + @sql + ')) b order by [Year] ') 	

				END

		 END
DROP TABLE #TEMP 
END 

GO
