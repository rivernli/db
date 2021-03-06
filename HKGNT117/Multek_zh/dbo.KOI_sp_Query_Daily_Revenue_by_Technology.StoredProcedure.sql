USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[KOI_sp_Query_Daily_Revenue_by_Technology]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[KOI_sp_Query_Daily_Revenue_by_Technology]
	-- Add the parameters for the stored procedure here
	@Date_s VARCHAR(10),
	@Date_e VARCHAR(10),
	@Sale NVARCHAR(20),
	@Sortingby NVARCHAR(20),
	@Plant NVARCHAR(50),
	@RowIndex int,
	@ToporKey NVARCHAR(50) 
AS
BEGIN
	SET NOCOUNT ON;
	declare @sql nvarchar(max), @querystring nvarchar(max) 
	SET @Plant=(CASE @Plant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' ELSE @Plant END)
	--FY AND Calender

		IF @ToporKey='Top' 
		BEGIN 			 
			IF @Sale='FGIn' 
			BEGIN
				SET ROWCOUNT @RowIndex 
				IF @Sortingby='ByNameDesc'
				   IF @Plant='All'	
						BEGIN		
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' '		
								select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM WHERE b.T$ATTR='type' AND T$PLNT<>'HK' AND T$DATE BETWEEN @Date_s AND @Date_e group by T$ASTR order by T$ASTR ASC 
						END
					ELSE
						BEGIN
							IF @Plant='Allexclude2F' 
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' AND T$PLNT<>''2F'' '	
								select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM WHERE b.T$ATTR='type' AND T$PLNT<>'HK' AND T$PLNT<>'2F' AND T$DATE BETWEEN @Date_s AND @Date_e group by T$ASTR order by T$ASTR ASC  
							END
							ELSE
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT='''+@Plant+''' '	 
								select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM WHERE b.T$ATTR='type' AND T$PLNT<>'HK' AND T$PLNT=@Plant AND T$DATE BETWEEN @Date_s AND @Date_e group by T$ASTR order by T$ASTR ASC  
							END
					END

				IF @Sortingby='ByRevenueDesc'
					IF @Plant='All'	
						BEGIN		
							SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' '		
							select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM WHERE b.T$ATTR='type' AND T$PLNT<>'HK' AND T$DATE BETWEEN @Date_s AND @Date_e group by T$ASTR  order by SUM(T$DOLS) DESC
						END
					ELSE
						BEGIN
							IF @Plant='Allexclude2F' 
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' AND T$PLNT<>''2F'' '	
								select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM WHERE b.T$ATTR='type' AND T$PLNT<>'HK' AND T$PLNT<>'2F' AND T$DATE BETWEEN @Date_s AND @Date_e group by T$ASTR order by SUM(T$DOLS) DESC
							END
							ELSE
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT='''+@Plant+''' '	 
								select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM WHERE b.T$ATTR='type' AND T$PLNT<>'HK' AND T$PLNT=@Plant AND T$DATE BETWEEN @Date_s AND @Date_e  group by T$ASTR order by SUM(T$DOLS) DESC
							END
					END 					
				IF @Sortingby='ByRevenueASC'
					IF @Plant='All'	
						BEGIN		
							SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' '		
							select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM WHERE b.T$ATTR='type' AND T$PLNT<>'HK' AND T$DATE BETWEEN @Date_s AND @Date_e group by T$ASTR  order by SUM(T$DOLS) ASC
						END
					ELSE
						BEGIN
							IF @Plant='Allexclude2F' 
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' AND T$PLNT<>''2F'' '	
								select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM WHERE b.T$ATTR='type' AND T$PLNT<>'HK' AND T$PLNT<>'2F' AND T$DATE BETWEEN @Date_s AND @Date_e group by T$ASTR order by SUM(T$DOLS) ASC 
							END
							ELSE
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT='''+@Plant+''' '	 
								select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM WHERE b.T$ATTR='type' AND T$PLNT<>'HK' AND T$PLNT=@Plant AND T$DATE BETWEEN @Date_s AND @Date_e group by T$ASTR order by SUM(T$DOLS) ASC
							END
					END 
				set @sql = '[' + @sql + ']' 			
				SET ROWCOUNT 0 
				IF @sql<>''
				exec ('select * from (select CONVERT(VARCHAR(10),T$DATE,120) as [Year],T$ASTR,T$DOLS from V_VWFSOLP107180 a 
				 INNER JOIN FactoryLoading.dbo.TFIATT006180 b ON a.T$ITEM=b.T$ITEM '+@querystring+' AND T$ATTR=''type'') 
				 ta pivot (SUM(T$DOLS) for T$ASTR in (' + @sql + ')) tb') 				
			END 

			IF @Sale='FGOut' 
			BEGIN
				SET ROWCOUNT @RowIndex
				IF @Sortingby='ByNameDesc'
					IF @Plant='All'	
						BEGIN		
							SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' '		
							select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM WHERE b.T$ATTR='type' AND T$PLNT<>'HK' AND T$DATE BETWEEN @Date_s AND @Date_e  group by T$ASTR order by T$ASTR ASC  
						END
					ELSE
						BEGIN
							IF @Plant='Allexclude2F' 
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' AND T$PLNT<>''2F'' '	
								select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM WHERE b.T$ATTR='type' AND T$PLNT<>'HK' AND T$PLNT<>'2F' AND T$DATE BETWEEN @Date_s AND @Date_e group by T$ASTR order by T$ASTR ASC  
							END
							ELSE
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT='''+@Plant+''' '	 
								select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM WHERE b.T$ATTR='type' AND T$PLNT=@Plant AND T$DATE BETWEEN @Date_s AND @Date_e group by T$ASTR order by T$ASTR ASC  
							END
					END
				IF @Sortingby='ByRevenueDesc'
					IF @Plant='All'	
						BEGIN		
							SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' '		
							select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM WHERE b.T$ATTR='type' AND T$PLNT<>'HK' AND T$DATE BETWEEN @Date_s AND @Date_e group by T$ASTR order by sum(T$DOLS) DESC 
						END
					ELSE
						BEGIN
							IF @Plant='Allexclude2F' 
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' AND T$PLNT<>''2F'' '	
								select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM WHERE b.T$ATTR='type' AND T$PLNT<>'HK' AND T$PLNT<>'2F' AND T$DATE BETWEEN @Date_s AND @Date_e  group by T$ASTR order by sum(T$DOLS) DESC 
							END
							ELSE
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT='''+@Plant+''' '	 
								select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM WHERE b.T$ATTR='type' AND T$PLNT=@Plant AND T$DATE BETWEEN @Date_s AND @Date_e group by T$ASTR order by sum(T$DOLS) DESC 
							END
					END
				IF @Sortingby='ByRevenueASC'
					IF @Plant='All'	
						BEGIN		
							SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' '		
							select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM WHERE b.T$ATTR='type' AND T$PLNT<>'HK' AND T$DATE BETWEEN @Date_s AND @Date_e group by T$ASTR order by sum(T$DOLS) ASC 
						END
					ELSE
						BEGIN
							IF @Plant='Allexclude2F' 
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' AND T$PLNT<>''2F'' '	
								select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM WHERE b.T$ATTR='type' AND T$PLNT<>'HK' AND T$PLNT<>'2F' AND T$DATE BETWEEN @Date_s AND @Date_e group by T$ASTR order by sum(T$DOLS) ASC 
							END
							ELSE
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT='''+@Plant+''' '	 
								select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM WHERE b.T$ATTR='type' AND T$PLNT=@Plant AND T$DATE BETWEEN @Date_s AND @Date_e group by T$ASTR order by sum(T$DOLS) ASC 
							END
					END 

				set @sql = '[' + @sql + ']' 	
				SET ROWCOUNT 0 
				IF @sql<>''
				exec ('select * from (select CONVERT(VARCHAR(10),T$DATE,120) as [Year],T$ASTR,T$DOLS from V_VWFSOLP107180 a 
				 INNER JOIN FactoryLoading.dbo.TFIATT006180 b ON a.T$ITEM=b.T$ITEM '+@querystring+' AND T$ATTR=''type'') 
				 ta pivot (SUM(T$DOLS) for T$ASTR in (' + @sql + ')) tb') 

			END

			IF @Sale='Invoice' 
			BEGIN
				SET ROWCOUNT @RowIndex
				IF @Sortingby='ByNameDesc'
					IF @Plant='All'	
						BEGIN		
							SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' '		
							select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM WHERE b.T$ATTR='type' AND T$PLNT<>'HK' AND T$DATE BETWEEN @Date_s AND @Date_e group by T$ASTR order by T$ASTR ASC  
						END
					ELSE
						BEGIN
							IF @Plant='Allexclude2F' 
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' AND T$PLNT<>''2F'' '	
								select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM WHERE b.T$ATTR='type' AND T$PLNT<>'HK' AND T$PLNT<>'2F' AND T$DATE BETWEEN @Date_s AND @Date_e group by T$ASTR order by T$ASTR ASC  
							END
							ELSE
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT='''+@Plant+''' '	 
								select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM WHERE b.T$ATTR='type' AND T$PLNT<>'HK' AND T$PLNT=@Plant AND T$DATE BETWEEN @Date_s AND @Date_e group by T$ASTR order by T$ASTR ASC  
							END
					END
				IF @Sortingby='ByRevenueDesc'
					IF @Plant='All'	
						BEGIN		
							SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' '		
							select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM WHERE b.T$ATTR='type' AND T$PLNT<>'HK' AND T$DATE BETWEEN @Date_s AND @Date_e  group by T$ASTR order by sum(T$DOLS) DESC 
						END
					ELSE
						BEGIN
							IF @Plant='Allexclude2F' 
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' AND T$PLNT<>''2F'' '	
								select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM WHERE b.T$ATTR='type' AND T$PLNT<>'HK' AND T$PLNT<>'2F' AND T$DATE BETWEEN @Date_s AND @Date_e group by T$ASTR order by sum(T$DOLS) DESC 
							END
							ELSE
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT='''+@Plant+''' '	 
								select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM WHERE b.T$ATTR='type' AND T$PLNT<>'HK' AND T$PLNT=@Plant AND T$DATE BETWEEN @Date_s AND @Date_e group by T$ASTR order by sum(T$DOLS) DESC 
							END
					END
				IF @Sortingby='ByRevenueASC'
					IF @Plant='All'	
						BEGIN		
							SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' '		
							select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM WHERE b.T$ATTR='type' AND T$PLNT<>'HK' AND T$DATE BETWEEN @Date_s AND @Date_e group by T$ASTR order by sum(T$DOLS) ASC 
						END
					ELSE
						BEGIN
							IF @Plant='Allexclude2F' 
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' AND T$PLNT<>''2F'' '	
								select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM WHERE b.T$ATTR='type' AND T$PLNT<>'2F' AND T$DATE BETWEEN @Date_s AND @Date_e group by T$ASTR order by sum(T$DOLS) ASC 
							END
							ELSE
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT='''+@Plant+''' '	 
								select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM WHERE b.T$ATTR='type' AND T$PLNT=@Plant AND T$DATE BETWEEN @Date_s AND @Date_e group by T$ASTR order by sum(T$DOLS) ASC 
							END
					END 


				set @sql = '[' + @sql + ']' 	
				SET ROWCOUNT 0 
				IF @sql<>''				
				exec ('select * from (select CONVERT(VARCHAR(10),T$DATE,120) as [Year],T$ASTR,T$DOLS from V_VWFSOLP107180 a 
				 INNER JOIN FactoryLoading.dbo.TFIATT006180 b ON a.T$ITEM=b.T$ITEM '+@querystring+' AND T$ATTR=''type'') 
				 ta pivot (SUM(T$DOLS) for T$ASTR in (' + @sql + ')) tb') 
			END
			 	
		END 





		IF @ToporKey='Key'
		BEGIN 			 
			IF @Sale='FGIn' 
			BEGIN
				SET ROWCOUNT @RowIndex 
				IF @Sortingby='ByNameDesc'
				   IF @Plant='All'	
						BEGIN		
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' '		
								select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a 
								inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM 
								INNER JOIN KOI_Revenue_by_Technology_SetKey c ON b.T$ASTR=c.Technology 
								WHERE b.T$ATTR='type' AND T$PLNT<>'HK' AND T$DATE BETWEEN @Date_s AND @Date_e group by T$ASTR order by T$ASTR ASC 
						END
					ELSE
						BEGIN
							IF @Plant='Allexclude2F' 
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' AND T$PLNT<>''2F'' '	
								select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a 
								inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM 
								INNER JOIN KOI_Revenue_by_Technology_SetKey c ON b.T$ASTR=c.Technology 
								WHERE b.T$ATTR='type' AND T$PLNT<>'HK' AND T$PLNT<>'2F' AND T$DATE BETWEEN @Date_s AND @Date_e group by T$ASTR order by T$ASTR ASC  
							END
							ELSE
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT='''+@Plant+''' '	 
								select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a 
								inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM 
								INNER JOIN KOI_Revenue_by_Technology_SetKey c ON b.T$ASTR=c.Technology 
								WHERE b.T$ATTR='type' AND T$PLNT<>'HK' AND T$PLNT=@Plant AND T$DATE BETWEEN @Date_s AND @Date_e group by T$ASTR order by T$ASTR ASC  
							END
					END

				IF @Sortingby='ByRevenueDesc'
					IF @Plant='All'	
						BEGIN		
							SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' '		
							select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a 
							inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM 
							INNER JOIN KOI_Revenue_by_Technology_SetKey c ON b.T$ASTR=c.Technology 
							WHERE b.T$ATTR='type' AND T$PLNT<>'HK' AND T$DATE BETWEEN @Date_s AND @Date_e group by T$ASTR  order by SUM(T$DOLS) DESC
						END
					ELSE
						BEGIN
							IF @Plant='Allexclude2F' 
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' AND T$PLNT<>''2F'' '	
								select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a 
								inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM 
								INNER JOIN KOI_Revenue_by_Technology_SetKey c ON b.T$ASTR=c.Technology 
								WHERE b.T$ATTR='type' AND T$PLNT<>'HK' AND T$PLNT<>'2F' AND T$DATE BETWEEN @Date_s AND @Date_e group by T$ASTR order by SUM(T$DOLS) DESC
							END
							ELSE
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT='''+@Plant+''' '	 
								select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a 
								inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM 
								INNER JOIN KOI_Revenue_by_Technology_SetKey c ON b.T$ASTR=c.Technology 
								WHERE b.T$ATTR='type' AND T$PLNT<>'HK' AND T$PLNT=@Plant AND T$DATE BETWEEN @Date_s AND @Date_e  group by T$ASTR order by SUM(T$DOLS) DESC
							END
					END 					
				IF @Sortingby='ByRevenueASC'
					IF @Plant='All'	
						BEGIN		
							SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' '		
							select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a 
							inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM 
							INNER JOIN KOI_Revenue_by_Technology_SetKey c ON b.T$ASTR=c.Technology 
							WHERE b.T$ATTR='type' AND T$PLNT<>'HK' AND T$DATE BETWEEN @Date_s AND @Date_e group by T$ASTR  order by SUM(T$DOLS) ASC
						END
					ELSE
						BEGIN
							IF @Plant='Allexclude2F' 
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' AND T$PLNT<>''2F'' '	
								select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a 
								inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM 
								INNER JOIN KOI_Revenue_by_Technology_SetKey c ON b.T$ASTR=c.Technology 
								WHERE b.T$ATTR='type' AND T$PLNT<>'HK' AND T$PLNT<>'2F' AND T$DATE BETWEEN @Date_s AND @Date_e group by T$ASTR order by SUM(T$DOLS) ASC 
							END
							ELSE
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT='''+@Plant+''' '	 
								select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a 
								inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM 
								INNER JOIN KOI_Revenue_by_Technology_SetKey c ON b.T$ASTR=c.Technology 
								WHERE b.T$ATTR='type' AND T$PLNT<>'HK' AND T$PLNT=@Plant AND T$DATE BETWEEN @Date_s AND @Date_e group by T$ASTR order by SUM(T$DOLS) ASC
							END
					END 
				set @sql = '[' + @sql + ']' 			
				SET ROWCOUNT 0 
				IF @sql<>''
				exec ('select * from (select CONVERT(VARCHAR(10),T$DATE,120) as [Year],T$ASTR,T$DOLS from V_VWFSOLP107180 a 
				 INNER JOIN FactoryLoading.dbo.TFIATT006180 b ON a.T$ITEM=b.T$ITEM '+@querystring+' AND T$ATTR=''type'') 
				 ta pivot (SUM(T$DOLS) for T$ASTR in (' + @sql + ')) tb') 				
			END 

			IF @Sale='FGOut' 
			BEGIN
				SET ROWCOUNT @RowIndex
				IF @Sortingby='ByNameDesc'
					IF @Plant='All'	
						BEGIN		
							SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' '		
							select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a 
							inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM 
							INNER JOIN KOI_Revenue_by_Technology_SetKey c ON b.T$ASTR=c.Technology 
							WHERE b.T$ATTR='type' AND T$PLNT<>'HK' AND T$DATE BETWEEN @Date_s AND @Date_e  group by T$ASTR order by T$ASTR ASC  
						END
					ELSE
						BEGIN
							IF @Plant='Allexclude2F' 
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' AND T$PLNT<>''2F'' '	
								select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a 
								inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM 
								INNER JOIN KOI_Revenue_by_Technology_SetKey c ON b.T$ASTR=c.Technology 
								WHERE b.T$ATTR='type' AND T$PLNT<>'HK' AND T$PLNT<>'2F' AND T$DATE BETWEEN @Date_s AND @Date_e group by T$ASTR order by T$ASTR ASC  
							END
							ELSE
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT='''+@Plant+''' '	 
								select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a 
								inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM 
								INNER JOIN KOI_Revenue_by_Technology_SetKey c ON b.T$ASTR=c.Technology 
								WHERE b.T$ATTR='type' AND T$PLNT=@Plant AND T$DATE BETWEEN @Date_s AND @Date_e group by T$ASTR order by T$ASTR ASC  
							END
					END
				IF @Sortingby='ByRevenueDesc'
					IF @Plant='All'	
						BEGIN		
							SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' '		
							select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a 
							inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM 
							INNER JOIN KOI_Revenue_by_Technology_SetKey c ON b.T$ASTR=c.Technology 
							WHERE b.T$ATTR='type' AND T$PLNT<>'HK' AND T$DATE BETWEEN @Date_s AND @Date_e group by T$ASTR order by sum(T$DOLS) DESC 
						END
					ELSE
						BEGIN
							IF @Plant='Allexclude2F' 
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' AND T$PLNT<>''2F'' '	
								select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a 
								inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM 
								INNER JOIN KOI_Revenue_by_Technology_SetKey c ON b.T$ASTR=c.Technology 
								WHERE b.T$ATTR='type' AND T$PLNT<>'HK' AND T$PLNT<>'2F' AND T$DATE BETWEEN @Date_s AND @Date_e  group by T$ASTR order by sum(T$DOLS) DESC 
							END
							ELSE
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT='''+@Plant+''' '	 
								select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a 
								inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM 
								INNER JOIN KOI_Revenue_by_Technology_SetKey c ON b.T$ASTR=c.Technology 
								WHERE b.T$ATTR='type' AND T$PLNT=@Plant AND T$DATE BETWEEN @Date_s AND @Date_e group by T$ASTR order by sum(T$DOLS) DESC 
							END
					END
				IF @Sortingby='ByRevenueASC'
					IF @Plant='All'	
						BEGIN		
							SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' '		
							select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a 
							inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM 
							INNER JOIN KOI_Revenue_by_Technology_SetKey c ON b.T$ASTR=c.Technology 
							WHERE b.T$ATTR='type' AND T$PLNT<>'HK' AND T$DATE BETWEEN @Date_s AND @Date_e group by T$ASTR order by sum(T$DOLS) ASC 
						END
					ELSE
						BEGIN
							IF @Plant='Allexclude2F' 
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' AND T$PLNT<>''2F'' '	
								select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a 
								inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM 
								INNER JOIN KOI_Revenue_by_Technology_SetKey c ON b.T$ASTR=c.Technology 
								WHERE b.T$ATTR='type' AND T$PLNT<>'HK' AND T$PLNT<>'2F' AND T$DATE BETWEEN @Date_s AND @Date_e group by T$ASTR order by sum(T$DOLS) ASC 
							END
							ELSE
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT='''+@Plant+''' '	 
								select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a 
								inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM 
								INNER JOIN KOI_Revenue_by_Technology_SetKey c ON b.T$ASTR=c.Technology 
								WHERE b.T$ATTR='type' AND T$PLNT=@Plant AND T$DATE BETWEEN @Date_s AND @Date_e group by T$ASTR order by sum(T$DOLS) ASC 
							END
					END 

				set @sql = '[' + @sql + ']' 	
				SET ROWCOUNT 0 
				IF @sql<>''
				exec ('select * from (select CONVERT(VARCHAR(10),T$DATE,120) as [Year],T$ASTR,T$DOLS from V_VWFSOLP107180 a 
				 INNER JOIN FactoryLoading.dbo.TFIATT006180 b ON a.T$ITEM=b.T$ITEM '+@querystring+' AND T$ATTR=''type'') 
				 ta pivot (SUM(T$DOLS) for T$ASTR in (' + @sql + ')) tb') 

			END

			IF @Sale='Invoice' 
			BEGIN
				SET ROWCOUNT @RowIndex
				IF @Sortingby='ByNameDesc'
					IF @Plant='All'	
						BEGIN		
							SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' '		
							select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a 
							inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM 
							INNER JOIN KOI_Revenue_by_Technology_SetKey c ON b.T$ASTR=c.Technology 
							WHERE b.T$ATTR='type' AND T$PLNT<>'HK' AND T$DATE BETWEEN @Date_s AND @Date_e group by T$ASTR order by T$ASTR ASC  
						END
					ELSE
						BEGIN
							IF @Plant='Allexclude2F' 
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' AND T$PLNT<>''2F'' '	
								select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a 
								inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM 
								INNER JOIN KOI_Revenue_by_Technology_SetKey c ON b.T$ASTR=c.Technology 
								WHERE b.T$ATTR='type' AND T$PLNT<>'HK' AND T$PLNT<>'2F' AND T$DATE BETWEEN @Date_s AND @Date_e group by T$ASTR order by T$ASTR ASC  
							END
							ELSE
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT='''+@Plant+''' '	 
								select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a 
								inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM 
								INNER JOIN KOI_Revenue_by_Technology_SetKey c ON b.T$ASTR=c.Technology 
								WHERE b.T$ATTR='type' AND T$PLNT<>'HK' AND T$PLNT=@Plant AND T$DATE BETWEEN @Date_s AND @Date_e group by T$ASTR order by T$ASTR ASC  
							END
					END
				IF @Sortingby='ByRevenueDesc'
					IF @Plant='All'	
						BEGIN		
							SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' '		
							select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a 
							inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM 
							INNER JOIN KOI_Revenue_by_Technology_SetKey c ON b.T$ASTR=c.Technology 
							WHERE b.T$ATTR='type' AND T$PLNT<>'HK' AND T$DATE BETWEEN @Date_s AND @Date_e  group by T$ASTR order by sum(T$DOLS) DESC 
						END
					ELSE
						BEGIN
							IF @Plant='Allexclude2F' 
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' AND T$PLNT<>''2F'' '	
								select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a 
								inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM 
								INNER JOIN KOI_Revenue_by_Technology_SetKey c ON b.T$ASTR=c.Technology 
								WHERE b.T$ATTR='type' AND T$PLNT<>'HK' AND T$PLNT<>'2F' AND T$DATE BETWEEN @Date_s AND @Date_e group by T$ASTR order by sum(T$DOLS) DESC 
							END
							ELSE
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT='''+@Plant+''' '	 
								select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a 
								inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM 
								INNER JOIN KOI_Revenue_by_Technology_SetKey c ON b.T$ASTR=c.Technology 
								WHERE b.T$ATTR='type' AND T$PLNT<>'HK' AND T$PLNT=@Plant AND T$DATE BETWEEN @Date_s AND @Date_e group by T$ASTR order by sum(T$DOLS) DESC 
							END
					END
				IF @Sortingby='ByRevenueASC'
					IF @Plant='All'	
						BEGIN		
							SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' '		
							select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a 
							inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM 
							INNER JOIN KOI_Revenue_by_Technology_SetKey c ON b.T$ASTR=c.Technology 
							WHERE b.T$ATTR='type' AND T$PLNT<>'HK' AND T$DATE BETWEEN @Date_s AND @Date_e group by T$ASTR order by sum(T$DOLS) ASC 
						END
					ELSE
						BEGIN
							IF @Plant='Allexclude2F' 
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' AND T$PLNT<>''2F'' '	
								select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a 
								inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM 
								INNER JOIN KOI_Revenue_by_Technology_SetKey c ON b.T$ASTR=c.Technology 
								WHERE b.T$ATTR='type' AND T$PLNT<>'2F' AND T$DATE BETWEEN @Date_s AND @Date_e group by T$ASTR order by sum(T$DOLS) ASC 
							END
							ELSE
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT='''+@Plant+''' '	 
								select @sql = isnull(@sql + '],[' , '') + T$ASTR from V_VWFSOLP107180 a 
								inner join FactoryLoading.dbo.TFIATT006180 b on a.T$ITEM=b.T$ITEM 
								INNER JOIN KOI_Revenue_by_Technology_SetKey c ON b.T$ASTR=c.Technology 
								WHERE b.T$ATTR='type' AND T$PLNT=@Plant AND T$DATE BETWEEN @Date_s AND @Date_e group by T$ASTR order by sum(T$DOLS) ASC 
							END
					END 


				set @sql = '[' + @sql + ']' 	
				SET ROWCOUNT 0 
				IF @sql<>''				
				exec ('select * from (select CONVERT(VARCHAR(10),T$DATE,120) as [Year],T$ASTR,T$DOLS from V_VWFSOLP107180 a 
				 INNER JOIN FactoryLoading.dbo.TFIATT006180 b ON a.T$ITEM=b.T$ITEM '+@querystring+' AND T$ATTR=''type'') 
				 ta pivot (SUM(T$DOLS) for T$ASTR in (' + @sql + ')) tb') 
			END
		END
	END 





GO
