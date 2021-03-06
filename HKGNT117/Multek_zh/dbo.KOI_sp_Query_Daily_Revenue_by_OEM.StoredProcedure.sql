USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[KOI_sp_Query_Daily_Revenue_by_OEM]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[KOI_sp_Query_Daily_Revenue_by_OEM]
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
							select @sql = isnull(@sql + '],[' , '') + T$CSGS from V_VWFSOLP107180 WHERE T$DATE BETWEEN @Date_s AND @Date_e AND T$PLNT<>'HK' group by T$CSGS order by T$CSGS ASC  
						END
					ELSE
						BEGIN
							IF @Plant='Allexclude2F' 
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' AND T$PLNT<>''2F'' '	
								select @sql = isnull(@sql + '],[' , '') + T$CSGS from V_VWFSOLP107180 WHERE T$DATE BETWEEN @Date_s AND @Date_e AND T$PLNT<>'HK' AND T$PLNT<>'2F'  group by T$CSGS order by T$CSGS ASC  
							END
							ELSE
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT='''+@Plant+''' '	 
								select @sql = isnull(@sql + '],[' , '') + T$CSGS from V_VWFSOLP107180 WHERE T$DATE BETWEEN @Date_s AND @Date_e AND T$PLNT=@Plant  group by T$CSGS order by T$CSGS ASC  
							END
					END

				IF @Sortingby='ByRevenueDesc'
					IF @Plant='All'	
						BEGIN		
							SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' '		
							select @sql = isnull(@sql + '],[' , '') + T$CSGS from V_VWFSOLP107180 WHERE T$DATE BETWEEN @Date_s AND @Date_e AND T$PLNT<>'HK' group by T$CSGS order by sum(T$DOLS) DESC 
						END
					ELSE
						BEGIN
							IF @Plant='Allexclude2F' 
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' AND T$PLNT<>''2F'' '	
								select @sql = isnull(@sql + '],[' , '') + T$CSGS from V_VWFSOLP107180 WHERE T$DATE BETWEEN @Date_s AND @Date_e AND T$PLNT<>'HK' AND T$PLNT<>'2F'  group by T$CSGS order by sum(T$DOLS) DESC 
							END
							ELSE
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT='''+@Plant+''' '	 
								select @sql = isnull(@sql + '],[' , '') + T$CSGS from V_VWFSOLP107180 WHERE T$DATE BETWEEN @Date_s AND @Date_e AND T$PLNT=@Plant  group by T$CSGS order by sum(T$DOLS) DESC 
							END
					END 					
				IF @Sortingby='ByRevenueASC'
					IF @Plant='All'	
						BEGIN		
							SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' '		
							select @sql = isnull(@sql + '],[' , '') + T$CSGS from V_VWFSOLP107180 WHERE T$DATE BETWEEN @Date_s AND @Date_e AND T$PLNT<>'HK' group by T$CSGS order by sum(T$DOLS) ASC 
						END
					ELSE
						BEGIN
							IF @Plant='Allexclude2F' 
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' AND T$PLNT<>''2F'' '	
								select @sql = isnull(@sql + '],[' , '') + T$CSGS from V_VWFSOLP107180 WHERE T$DATE BETWEEN @Date_s AND @Date_e AND T$PLNT<>'HK' AND T$PLNT<>'2F'  group by T$CSGS order by sum(T$DOLS) ASC 
							END
							ELSE
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT='''+@Plant+''' '	 
								select @sql = isnull(@sql + '],[' , '') + T$CSGS from V_VWFSOLP107180 WHERE T$DATE BETWEEN @Date_s AND @Date_e AND T$PLNT=@Plant  group by T$CSGS order by sum(T$DOLS) ASC 
							END
					END 
				set @sql = '[' + @sql + ']' 			
				SET ROWCOUNT 0 
				IF @sql<>''
				exec ('select * from (select CONVERT(VARCHAR(10),T$DATE,120) as [Year],T$CSGS,T$DOLS from V_VWFSOLP107180 '+@querystring+' ) 
				 a pivot (SUM(T$DOLS) for T$CSGS in (' + @sql + ')) b')
				
			END 

			IF @Sale='FGOut' 
			BEGIN
				SET ROWCOUNT @RowIndex
				IF @Sortingby='ByNameDesc'
					IF @Plant='All'	
						BEGIN		
							SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' '		
							select @sql = isnull(@sql + '],[' , '') + T$CSGS from V_VWFSOLP105180 WHERE T$DATE BETWEEN @Date_s AND @Date_e AND T$PLNT<>'HK' group by T$CSGS order by T$CSGS ASC  
						END
					ELSE
						BEGIN
							IF @Plant='Allexclude2F' 
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' AND T$PLNT<>''2F'' '	
								select @sql = isnull(@sql + '],[' , '') + T$CSGS from V_VWFSOLP105180 WHERE T$DATE BETWEEN @Date_s AND @Date_e AND T$PLNT<>'HK' AND T$PLNT<>'2F'  group by T$CSGS order by T$CSGS ASC  
							END
							ELSE
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT='''+@Plant+''' '	 
								select @sql = isnull(@sql + '],[' , '') + T$CSGS from V_VWFSOLP105180 WHERE T$DATE BETWEEN @Date_s AND @Date_e AND T$PLNT=@Plant  group by T$CSGS order by T$CSGS ASC  
							END
					END
				IF @Sortingby='ByRevenueDesc'
					IF @Plant='All'	
						BEGIN		
							SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' '		
							select @sql = isnull(@sql + '],[' , '') + T$CSGS from V_VWFSOLP105180 WHERE T$DATE BETWEEN @Date_s AND @Date_e AND T$PLNT<>'HK' group by T$CSGS order by sum(T$DOLS) DESC 
						END
					ELSE
						BEGIN
							IF @Plant='Allexclude2F' 
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' AND T$PLNT<>''2F'' '	
								select @sql = isnull(@sql + '],[' , '') + T$CSGS from V_VWFSOLP105180 WHERE T$DATE BETWEEN @Date_s AND @Date_e AND T$PLNT<>'HK' AND T$PLNT<>'2F'  group by T$CSGS order by sum(T$DOLS) DESC 
							END
							ELSE
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT='''+@Plant+''' '	 
								select @sql = isnull(@sql + '],[' , '') + T$CSGS from V_VWFSOLP105180 WHERE T$DATE BETWEEN @Date_s AND @Date_e AND T$PLNT=@Plant  group by T$CSGS order by sum(T$DOLS) DESC 
							END
					END
				IF @Sortingby='ByRevenueASC'
					IF @Plant='All'	
						BEGIN		
							SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' '		
							select @sql = isnull(@sql + '],[' , '') + T$CSGS from V_VWFSOLP105180 WHERE T$DATE BETWEEN @Date_s AND @Date_e AND T$PLNT<>'HK' group by T$CSGS order by sum(T$DOLS) ASC 
						END
					ELSE
						BEGIN
							IF @Plant='Allexclude2F' 
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' AND T$PLNT<>''2F'' '	
								select @sql = isnull(@sql + '],[' , '') + T$CSGS from V_VWFSOLP105180 WHERE T$DATE BETWEEN @Date_s AND @Date_e AND T$PLNT<>'HK' AND T$PLNT<>'2F'  group by T$CSGS order by sum(T$DOLS) ASC 
							END
							ELSE
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT='''+@Plant+''' '	 
								select @sql = isnull(@sql + '],[' , '') + T$CSGS from V_VWFSOLP105180 WHERE T$DATE BETWEEN @Date_s AND @Date_e AND T$PLNT=@Plant  group by T$CSGS order by sum(T$DOLS) ASC 
							END
					END 

				set @sql = '[' + @sql + ']' 	
				SET ROWCOUNT 0 
				IF @sql<>''
				exec ('select * from (select CONVERT(VARCHAR(10),T$DATE,120) as [Year],T$CSGS,T$DOLS from V_VWFSOLP105180 '+@querystring+' ) 
				 a pivot (SUM(T$DOLS) for T$CSGS in (' + @sql + ')) b')		
			END

			IF @Sale='Invoice' 
			BEGIN
				SET ROWCOUNT @RowIndex
				IF @Sortingby='ByNameDesc'
					IF @Plant='All'	
						BEGIN		
							SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' '		
							select @sql = isnull(@sql + '],[' , '') + T$CSGS from V_VWFSOLP106180 WHERE T$DATE BETWEEN @Date_s AND @Date_e AND T$PLNT<>'HK' group by T$CSGS order by T$CSGS ASC  
						END
					ELSE
						BEGIN
							IF @Plant='Allexclude2F' 
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' AND T$PLNT<>''2F'' '	
								select @sql = isnull(@sql + '],[' , '') + T$CSGS from V_VWFSOLP106180 WHERE T$DATE BETWEEN @Date_s AND @Date_e AND T$PLNT<>'HK' AND T$PLNT<>'2F'  group by T$CSGS order by T$CSGS ASC  
							END
							ELSE
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT='''+@Plant+''' '	 
								select @sql = isnull(@sql + '],[' , '') + T$CSGS from V_VWFSOLP106180 WHERE T$DATE BETWEEN @Date_s AND @Date_e AND T$PLNT=@Plant  group by T$CSGS order by T$CSGS ASC  
							END
					END
				IF @Sortingby='ByRevenueDesc'
					IF @Plant='All'	
						BEGIN		
							SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' '		
							select @sql = isnull(@sql + '],[' , '') + T$CSGS from V_VWFSOLP106180 WHERE T$DATE BETWEEN @Date_s AND @Date_e AND T$PLNT<>'HK' group by T$CSGS order by sum(T$DOLS) DESC 
						END
					ELSE
						BEGIN
							IF @Plant='Allexclude2F' 
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' AND T$PLNT<>''2F'' '	
								select @sql = isnull(@sql + '],[' , '') + T$CSGS from V_VWFSOLP106180 WHERE T$DATE BETWEEN @Date_s AND @Date_e AND T$PLNT<>'HK' AND T$PLNT<>'2F'  group by T$CSGS order by sum(T$DOLS) DESC 
							END
							ELSE
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT='''+@Plant+''' '	 
								select @sql = isnull(@sql + '],[' , '') + T$CSGS from V_VWFSOLP106180 WHERE T$DATE BETWEEN @Date_s AND @Date_e AND T$PLNT=@Plant  group by T$CSGS order by sum(T$DOLS) DESC 
							END
					END
				IF @Sortingby='ByRevenueASC'
					IF @Plant='All'	
						BEGIN		
							SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' '		
							select @sql = isnull(@sql + '],[' , '') + T$CSGS from V_VWFSOLP106180 WHERE T$DATE BETWEEN @Date_s AND @Date_e AND T$PLNT<>'HK' group by T$CSGS order by sum(T$DOLS) ASC 
						END
					ELSE
						BEGIN
							IF @Plant='Allexclude2F' 
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' AND T$PLNT<>''2F'' '	
								select @sql = isnull(@sql + '],[' , '') + T$CSGS from V_VWFSOLP106180 WHERE T$DATE BETWEEN @Date_s AND @Date_e AND T$PLNT<>'HK' AND T$PLNT<>'2F'  group by T$CSGS order by sum(T$DOLS) ASC 
							END
							ELSE
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT='''+@Plant+''' '	 
								select @sql = isnull(@sql + '],[' , '') + T$CSGS from V_VWFSOLP106180 WHERE T$DATE BETWEEN @Date_s AND @Date_e AND T$PLNT=@Plant  group by T$CSGS order by sum(T$DOLS) ASC 
							END
					END 


				set @sql = '[' + @sql + ']' 	
				SET ROWCOUNT 0 
				IF @sql<>''
				exec ('select * from (select CONVERT(VARCHAR(10),T$DATE,120) as [Year],T$CSGS,T$DOLS from V_VWFSOLP106180 '+@querystring+' ) 
				 a pivot (SUM(T$DOLS) for T$CSGS in (' + @sql + ')) b')		
			END
			 	
		END 



		IF @ToporKey='Key'
		BEGIN 			 
			IF @Sale='FGIn' 
			BEGIN
				IF @Sortingby='ByNameDesc'
				   IF @Plant='All'	
						BEGIN		
							SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' '		
							select @sql = isnull(@sql + '],[' , '') + a.T$CSGS from V_VWFSOLP107180 a INNER JOIN KOI_Revenue_by_OEM_SetKey b ON a.T$CSGS=b.OEM
							WHERE a.T$DATE BETWEEN @Date_s AND @Date_e AND a.T$PLNT<>'HK' group by a.T$CSGS order by a.T$CSGS ASC  
						END
					ELSE
						BEGIN
							IF @Plant='Allexclude2F' 
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' AND T$PLNT<>''2F'' AND b.Plant<>''B2F'' '	
								select @sql = isnull(@sql + '],[' , '') + a.T$CSGS from V_VWFSOLP107180 a INNER JOIN KOI_Revenue_by_OEM_SetKey b ON a.T$CSGS=b.OEM 
								WHERE a.T$DATE BETWEEN @Date_s AND @Date_e AND a.T$PLNT<>'HK' AND a.T$PLNT<>'2F' AND b.Plant<>'B2F' group by a.T$CSGS order by a.T$CSGS ASC  
							END
							ELSE
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT='''+@Plant+''' '	 
								select @sql = isnull(@sql + '],[' , '') + a.T$CSGS from V_VWFSOLP107180 a INNER JOIN KOI_Revenue_by_OEM_SetKey b ON a.T$CSGS=b.OEM 
								WHERE a.T$DATE BETWEEN @Date_s AND @Date_e AND a.T$PLNT=@Plant group by a.T$CSGS order by a.T$CSGS ASC  
							END
					END

				IF @Sortingby='ByRevenueDesc'
					IF @Plant='All'	
						BEGIN		
							SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' '		
							select @sql = isnull(@sql + '],[' , '') + a.T$CSGS from V_VWFSOLP107180 a INNER JOIN KOI_Revenue_by_OEM_SetKey b ON a.T$CSGS=b.OEM 
							WHERE a.T$DATE BETWEEN @Date_s AND @Date_e AND a.T$PLNT<>'HK' group by a.T$CSGS order by sum(a.T$DOLS) DESC 
						END
					ELSE
						BEGIN
							IF @Plant='Allexclude2F' 
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' AND T$PLNT<>''2F''  AND b.Plant<>''B2F'' '	
								select @sql = isnull(@sql + '],[' , '') + a.T$CSGS from V_VWFSOLP107180 a INNER JOIN KOI_Revenue_by_OEM_SetKey b ON a.T$CSGS=b.OEM 
								WHERE a.T$DATE BETWEEN @Date_s AND @Date_e AND a.T$PLNT<>'HK' AND a.T$PLNT<>'2F' AND b.Plant<>'B2F'  group by a.T$CSGS order by sum(a.T$DOLS) DESC 
							END
							ELSE
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT='''+@Plant+''' '	 
								select @sql = isnull(@sql + '],[' , '') + a.T$CSGS from V_VWFSOLP107180 a INNER JOIN KOI_Revenue_by_OEM_SetKey b ON a.T$CSGS=b.OEM 
								WHERE a.T$DATE BETWEEN @Date_s AND @Date_e AND a.T$PLNT=@Plant group by a.T$CSGS order by sum(a.T$DOLS) DESC 
							END
					END 					
				IF @Sortingby='ByRevenueASC'
					IF @Plant='All'	
						BEGIN		
							SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' '		
							select @sql = isnull(@sql + '],[' , '') + a.T$CSGS from V_VWFSOLP107180 a INNER JOIN KOI_Revenue_by_OEM_SetKey b ON a.T$CSGS=b.OEM 
							WHERE a.T$DATE BETWEEN @Date_s AND @Date_e AND a.T$PLNT<>'HK' group by a.T$CSGS order by sum(a.T$DOLS) ASC 
						END
					ELSE
						BEGIN
							IF @Plant='Allexclude2F' 
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' AND T$PLNT<>''2F''  AND b.Plant<>''B2F'' '	
								select @sql = isnull(@sql + '],[' , '') + a.T$CSGS from V_VWFSOLP107180 a INNER JOIN KOI_Revenue_by_OEM_SetKey b ON a.T$CSGS=b.OEM 
								WHERE a.T$DATE BETWEEN @Date_s AND @Date_e AND a.T$PLNT<>'HK' AND a.T$PLNT<>'2F' AND b.Plant<>'B2F'  group by a.T$CSGS order by sum(a.T$DOLS) ASC 
							END
							ELSE
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT='''+@Plant+''' '	 
								select @sql = isnull(@sql + '],[' , '') + a.T$CSGS from V_VWFSOLP107180 a INNER JOIN KOI_Revenue_by_OEM_SetKey b ON a.T$CSGS=b.OEM 
								WHERE a.T$DATE BETWEEN @Date_s AND @Date_e AND a.T$PLNT=@Plant group by a.T$CSGS order by sum(a.T$DOLS) ASC 
							END
					END 
				set @sql = '[' + @sql + ']' 		
				IF @sql<>''
				exec ('select * from (select CONVERT(VARCHAR(10),a.T$DATE,120) as [Year],a.T$CSGS,a.T$DOLS from V_VWFSOLP107180 a INNER JOIN KOI_Revenue_by_OEM_SetKey b ON a.T$CSGS=b.OEM '+@querystring+' ) 
				 a pivot (SUM(T$DOLS) for T$CSGS in (' + @sql + ')) b')
				
			END 

			IF @Sale='FGOut' 
			BEGIN
				IF @Sortingby='ByNameDesc'
					IF @Plant='All'	
						BEGIN		
							SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' '		
							select @sql = isnull(@sql + '],[' , '') + T$CSGS from V_VWFSOLP105180 a INNER JOIN KOI_Revenue_by_OEM_SetKey b ON a.T$CSGS=b.OEM 
							WHERE T$DATE BETWEEN @Date_s AND @Date_e AND T$PLNT<>'HK' group by T$CSGS order by T$CSGS ASC  
						END
					ELSE
						BEGIN
							IF @Plant='Allexclude2F' 
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' AND T$PLNT<>''2F''  AND b.Plant<>''B2F'' '	
								select @sql = isnull(@sql + '],[' , '') + T$CSGS from V_VWFSOLP105180 a INNER JOIN KOI_Revenue_by_OEM_SetKey b ON a.T$CSGS=b.OEM 
								WHERE T$DATE BETWEEN @Date_s AND @Date_e AND T$PLNT<>'HK' AND T$PLNT<>'2F' AND b.Plant<>'B2F' group by T$CSGS order by T$CSGS ASC  
							END
							ELSE
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT='''+@Plant+''' '	 
								select @sql = isnull(@sql + '],[' , '') + T$CSGS from V_VWFSOLP105180 a INNER JOIN KOI_Revenue_by_OEM_SetKey b ON a.T$CSGS=b.OEM 
								WHERE T$DATE BETWEEN @Date_s AND @Date_e AND T$PLNT=@Plant group by T$CSGS order by T$CSGS ASC  
							END
					END
				IF @Sortingby='ByRevenueDesc'
					IF @Plant='All'	
						BEGIN		
							SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' '		
							select @sql = isnull(@sql + '],[' , '') + T$CSGS from V_VWFSOLP105180 a INNER JOIN KOI_Revenue_by_OEM_SetKey b ON a.T$CSGS=b.OEM  
							WHERE T$DATE BETWEEN @Date_s AND @Date_e AND T$PLNT<>'HK' group by T$CSGS order by sum(T$DOLS) DESC 
						END
					ELSE
						BEGIN
							IF @Plant='Allexclude2F' 
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' AND T$PLNT<>''2F'' AND b.Plant<>''B2F'' '	
								select @sql = isnull(@sql + '],[' , '') + T$CSGS from V_VWFSOLP105180 a INNER JOIN KOI_Revenue_by_OEM_SetKey b ON a.T$CSGS=b.OEM  
								WHERE T$DATE BETWEEN @Date_s AND @Date_e AND T$PLNT<>'HK' AND T$PLNT<>'2F' AND b.Plant<>'B2F' group by T$CSGS order by sum(T$DOLS) DESC 
							END
							ELSE
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT='''+@Plant+''' '	 
								select @sql = isnull(@sql + '],[' , '') + T$CSGS from V_VWFSOLP105180 a INNER JOIN KOI_Revenue_by_OEM_SetKey b ON a.T$CSGS=b.OEM  
								WHERE T$DATE BETWEEN @Date_s AND @Date_e AND T$PLNT=@Plant group by T$CSGS order by sum(T$DOLS) DESC 
							END
					END
				IF @Sortingby='ByRevenueASC'
					IF @Plant='All'	
						BEGIN		
							SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' '		
							select @sql = isnull(@sql + '],[' , '') + T$CSGS from V_VWFSOLP105180 a INNER JOIN KOI_Revenue_by_OEM_SetKey b ON a.T$CSGS=b.OEM  
							WHERE T$DATE BETWEEN @Date_s AND @Date_e AND T$PLNT<>'HK' group by T$CSGS order by sum(T$DOLS) ASC 
						END
					ELSE
						BEGIN
							IF @Plant='Allexclude2F' 
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' AND T$PLNT<>''2F''  AND b.Plant<>''B2F'' '	
								select @sql = isnull(@sql + '],[' , '') + T$CSGS from V_VWFSOLP105180 a INNER JOIN KOI_Revenue_by_OEM_SetKey b ON a.T$CSGS=b.OEM  
								WHERE T$DATE BETWEEN @Date_s AND @Date_e AND T$PLNT<>'HK' AND T$PLNT<>'2F' AND b.Plant<>'B2F'  group by T$CSGS order by sum(T$DOLS) ASC 
							END
							ELSE
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT='''+@Plant+''' '	 
								select @sql = isnull(@sql + '],[' , '') + T$CSGS from V_VWFSOLP105180 a INNER JOIN KOI_Revenue_by_OEM_SetKey b ON a.T$CSGS=b.OEM  
								WHERE T$DATE BETWEEN @Date_s AND @Date_e AND T$PLNT=@Plant group by T$CSGS order by sum(T$DOLS) ASC 
							END
					END 

				set @sql = '[' + @sql + ']' 	
				IF @sql<>''
				exec ('select * from (select CONVERT(VARCHAR(10),T$DATE,120) as [Year],T$CSGS,T$DOLS from V_VWFSOLP105180  a INNER JOIN KOI_Revenue_by_OEM_SetKey b ON a.T$CSGS=b.OEM  '+@querystring+' ) 
				 a pivot (SUM(T$DOLS) for T$CSGS in (' + @sql + ')) b')		
			END

			IF @Sale='Invoice' 
			BEGIN
				IF @Sortingby='ByNameDesc'
					IF @Plant='All'	
						BEGIN		
							SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' '		
							select @sql = isnull(@sql + '],[' , '') + T$CSGS from V_VWFSOLP106180 a INNER JOIN KOI_Revenue_by_OEM_SetKey b ON a.T$CSGS=b.OEM 
							WHERE T$DATE BETWEEN @Date_s AND @Date_e AND T$PLNT<>'HK' group by T$CSGS order by T$CSGS ASC  
						END
					ELSE
						BEGIN
							IF @Plant='Allexclude2F' 
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' AND T$PLNT<>''2F'' AND b.Plant<>''B2F'' '	
								select @sql = isnull(@sql + '],[' , '') + T$CSGS from V_VWFSOLP106180 a INNER JOIN KOI_Revenue_by_OEM_SetKey b ON a.T$CSGS=b.OEM 
								WHERE T$DATE BETWEEN @Date_s AND @Date_e AND T$PLNT<>'HK' AND T$PLNT<>'2F' AND b.Plant<>'B2F'  group by T$CSGS order by T$CSGS ASC  
							END
							ELSE
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT='''+@Plant+''' '	 
								select @sql = isnull(@sql + '],[' , '') + T$CSGS from V_VWFSOLP106180 a INNER JOIN KOI_Revenue_by_OEM_SetKey b ON a.T$CSGS=b.OEM 
								WHERE T$DATE BETWEEN @Date_s AND @Date_e AND T$PLNT=@Plant group by T$CSGS order by T$CSGS ASC  
							END
					END
				IF @Sortingby='ByRevenueDesc'
					IF @Plant='All'	
						BEGIN		
							SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' '		
							select @sql = isnull(@sql + '],[' , '') + T$CSGS from V_VWFSOLP106180 a INNER JOIN KOI_Revenue_by_OEM_SetKey b ON a.T$CSGS=b.OEM 
							WHERE T$DATE BETWEEN @Date_s AND @Date_e AND T$PLNT<>'HK' group by T$CSGS order by sum(T$DOLS) DESC 
						END
					ELSE
						BEGIN
							IF @Plant='Allexclude2F' 
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' AND T$PLNT<>''2F'' AND b.Plant<>''B2F'' '	
								select @sql = isnull(@sql + '],[' , '') + T$CSGS from V_VWFSOLP106180 a INNER JOIN KOI_Revenue_by_OEM_SetKey b ON a.T$CSGS=b.OEM 
								WHERE T$DATE BETWEEN @Date_s AND @Date_e AND T$PLNT<>'HK' AND T$PLNT<>'2F' AND b.Plant<>'B2F'  group by T$CSGS order by sum(T$DOLS) DESC 
							END
							ELSE
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT='''+@Plant+''' '	 
								select @sql = isnull(@sql + '],[' , '') + T$CSGS from V_VWFSOLP106180 a INNER JOIN KOI_Revenue_by_OEM_SetKey b ON a.T$CSGS=b.OEM 
								WHERE T$DATE BETWEEN @Date_s AND @Date_e AND T$PLNT=@Plant group by T$CSGS order by sum(T$DOLS) DESC 
							END
					END
				IF @Sortingby='ByRevenueASC'
					IF @Plant='All'	
						BEGIN		
							SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' '		
							select @sql = isnull(@sql + '],[' , '') + T$CSGS from V_VWFSOLP106180 a INNER JOIN KOI_Revenue_by_OEM_SetKey b ON a.T$CSGS=b.OEM 
							WHERE T$DATE BETWEEN @Date_s AND @Date_e AND T$PLNT<>'HK' group by T$CSGS order by sum(T$DOLS) ASC 
						END
					ELSE
						BEGIN
							IF @Plant='Allexclude2F' 
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT<>''HK'' AND T$PLNT<>''2F'' AND b.Plant<>''B2F'' '	
								select @sql = isnull(@sql + '],[' , '') + T$CSGS from V_VWFSOLP106180 a INNER JOIN KOI_Revenue_by_OEM_SetKey b ON a.T$CSGS=b.OEM 
								WHERE T$DATE BETWEEN @Date_s AND @Date_e AND T$PLNT<>'HK' AND T$PLNT<>'2F' AND b.Plant<>'B2F'  group by T$CSGS order by sum(T$DOLS) ASC 
							END
							ELSE
							BEGIN
								SET @querystring = 'WHERE T$DATE BETWEEN '''+@Date_s+''' AND '''+@Date_e+''' AND T$PLNT='''+@Plant+''' '	 
								select @sql = isnull(@sql + '],[' , '') + T$CSGS from V_VWFSOLP106180 a INNER JOIN KOI_Revenue_by_OEM_SetKey b ON a.T$CSGS=b.OEM 
								WHERE T$DATE BETWEEN @Date_s AND @Date_e AND T$PLNT=@Plant group by T$CSGS order by sum(T$DOLS) ASC 
							END
					END 


				set @sql = '[' + @sql + ']' 	
				IF @sql<>''
				exec ('select * from (select CONVERT(VARCHAR(10),T$DATE,120) as [Year],T$CSGS,T$DOLS from V_VWFSOLP106180 a INNER JOIN KOI_Revenue_by_OEM_SetKey b ON a.T$CSGS=b.OEM  '+@querystring+' ) 
				 a pivot (SUM(T$DOLS) for T$CSGS in (' + @sql + ')) b')		
			END
		END
	END 




GO
