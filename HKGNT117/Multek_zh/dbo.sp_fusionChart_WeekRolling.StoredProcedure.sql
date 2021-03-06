USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_fusionChart_WeekRolling]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE procedure [dbo].[sp_fusionChart_WeekRolling] 
@WeeksNum INT
as 

--Create Temp Table 
	CREATE TABLE ##tempexcel 
	( 
		B1 float NULL,
		B2F float NULL,
		B3_SUB float NULL,
		B4_SUB float NULL,
		B5 float NULL,
		VVI float NULL,
		B4_VVI float NULL,
		SUB float NULL,
		GrandTotal float NULL
	)

declare @SortType VARCHAR(5), @Fiscalweek NVARCHAR(50),@Mincalenderdate NVARCHAR(50),@Maxcalenderdate NVARCHAR(50), @xmlData NVARCHAR(MAX)
declare @Plant NVARCHAR(20), @COL1 NUMERIC(19,2),@COL2 NUMERIC(19,2), @COL3 NUMERIC(19,2), @COL4 NUMERIC(19,2), @COL5 NUMERIC(19,2), @COL6 NUMERIC(19,2), @COL7 NUMERIC(19,2), @COL8 NUMERIC(19,2), @COL9 NUMERIC(19,2), @COL10 NUMERIC(19,2), @COL11 NUMERIC(19,2), @COL12 NUMERIC(19,2), @COL13 NUMERIC(19,2), @COL14 NUMERIC(19,2) 
		
BEGIN
			SET @xmlData='';
			SET @xmlData=@xmlData+'<chart caption='+''''+CONVERT(VARCHAR(20),@WeeksNum)+' Weeks chart'''+' swfurl="../Include/MSLine.swf"  lineThickness="1" showValues="0" formatNumberScale="0" anchorRadius="2" divLineAlpha="20"  divLineIsDashed="1" showAlternateHGridColor="1" alternateHGridAlpha="5"  shadowAlpha="40" numvdivlines="5" chartRightMargin="35" bgColor="FFFFFF,CC3300" bgAngle="270" bgAlpha="10,10">'
		IF @WeeksNum='13'		
			DECLARE M_Calender CURSOR FOR
			--select week,date		
			SELECT  top (@WeeksNum) Fiscalweek, 
			convert(varchar(10),min(calenderdate),120) AS Mincalenderdate, 
			convert(varchar(10),max(calenderdate),120) AS Maxcalenderdate 
			FROM DataWarehouse.dbo.DW_DIM_Calender 
			WHERE 
			calenderdate >= (select convert(varchar(10),(getdate()-calenderWeek)-92,120) as lastweek
			 FROM DataWarehouse.dbo.DW_DIM_Calender where calenderdate=convert(nvarchar(10),getdate(),120))
			AND calenderdate <= convert(nvarchar(10),getdate(),120)
			AND Fiscalweek<>(select Fiscalweek from DataWarehouse.dbo.DW_DIM_Calender where calenderdate=convert(nvarchar(10),getdate(),120))			
			group by Fiscalweek order by Maxcalenderdate ASC 
		ELSE
			DECLARE M_Calender CURSOR FOR
			--select week,date		
			SELECT  top (@WeeksNum) Fiscalweek, 
			convert(varchar(10),min(calenderdate),120) AS Mincalenderdate, 
			convert(varchar(10),max(calenderdate),120) AS Maxcalenderdate 
			FROM DataWarehouse.dbo.DW_DIM_Calender 
			WHERE 
			calenderdate >= (select convert(varchar(10),(getdate()-calenderWeek)-92,120) as lastweek
			 FROM DataWarehouse.dbo.DW_DIM_Calender where calenderdate=convert(nvarchar(10),getdate(),120))
			AND calenderdate <= convert(nvarchar(10),getdate(),120)
			AND Fiscalweek<>(select Fiscalweek from DataWarehouse.dbo.DW_DIM_Calender where calenderdate=convert(nvarchar(10),getdate(),120))			
			group by Fiscalweek order by Maxcalenderdate DESC 

			SET @xmlData=@xmlData+'<categories>'
			OPEN M_Calender
			FETCH NEXT FROM M_Calender INTO @Fiscalweek,@Mincalenderdate,@Maxcalenderdate
			WHILE @@FETCH_STATUS=0
				BEGIN
					--print(@Fiscalweek) print(@Mincalenderdate) print(@Maxcalenderdate)
					SET @xmlData=@xmlData+'<category label='+''''+CONVERT(VARCHAR(20),@Fiscalweek)+''''+' />'
					--INSERT temp table
					INSERT INTO ##tempexcel (B1,B2F,B3_SUB,B4_SUB,B5,VVI,B4_VVI,SUB,GrandTotal)
					(select (A_B1/B_B1) AS B1,(A_B2F/B_B2F) AS B2F,(A_B3/B_B3) AS B3,(A_B4/B_B4) AS B4,(A_B5/B_B5) AS B5,(A_VVI/B_VVI) AS VVI,
					(A_B4+A_VVI)/(B_B4+B_VVI) AS B4_VVI,(A_SUB/B_SUB) AS SUB,((A_B1+A_B2F+A_B3+A_B4+A_B5+A_VVI)/(B_B1+B_B2F+B_B3+B_B4+B_B5+B_VVI)) AS GrandTotal  from 
					(
					select SUM(T$PB12) AS A_B1,
					(select SUM(T$AMNT) from dbo.TFSOLP105180 WHERE T$DATE between ''+@Mincalenderdate+'' and ''+@Maxcalenderdate+'' AND T$PLNT='P2') AS B_B1,
					SUM(T$B2F) AS A_B2F,
					(select SUM(T$AMNT) from dbo.TFSOLP105180 WHERE T$DATE between ''+@Mincalenderdate+'' and ''+@Maxcalenderdate+'' AND T$PLNT='2F') AS B_B2F,
					SUM(T$PB3) AS A_B3,
					(select SUM(T$AMNT) from dbo.TFSOLP105180 WHERE T$DATE between ''+@Mincalenderdate+'' and ''+@Maxcalenderdate+'' AND T$PLNT='B3') AS B_B3,
					SUM(T$PB4) AS A_B4,
					(select SUM(T$AMNT) from dbo.TFSOLP105180 WHERE T$DATE between ''+@Mincalenderdate+'' and ''+@Maxcalenderdate+'' AND T$PLNT='B4') AS B_B4,
					SUM(T$PB5) AS A_B5,
					(select SUM(T$AMNT) from dbo.TFSOLP105180 WHERE T$DATE between ''+@Mincalenderdate+'' and ''+@Maxcalenderdate+'' AND T$PLNT='B5') AS B_B5, 
					SUM(T$SUB1) AS A_VVI,
					(select SUM(T$AMNT) from dbo.TFSOLP105180 WHERE T$DATE between ''+@Mincalenderdate+'' and ''+@Maxcalenderdate+'' AND T$PLNT='HK') AS B_VVI,
					SUM(T$SUB2) AS A_SUB, 
					(select SUM(T$AMNT) from dbo.TFSOLP105180 WHERE T$DATE between ''+@Mincalenderdate+'' and ''+@Maxcalenderdate+'' AND T$PLNT='HK' AND (T$cotp='CNG' OR T$cotp='SLS')) AS B_SUB
					 from TFSOLP119180 WHERE T$ODAT between ''+@Mincalenderdate+'' and ''+@Maxcalenderdate+''
					) tblweekRolling)

					FETCH NEXT FROM M_Calender INTO @Fiscalweek,@Mincalenderdate,@Maxcalenderdate
				END
			SET @xmlData=@xmlData+'</categories>'			
			CLOSE M_Calender
			DEALLOCATE M_Calender

		IF @WeeksNum='13'		
		BEGIN
						DECLARE Sum_Value CURSOR FOR		
						with query as (
								select 'B1' Plant, ROW_NUMBER() OVER (order by (select 0)) ID, B1 as DATA from ##tempexcel 
								union select 'B2F' Plant, ROW_NUMBER() OVER (order by (select 0)) ID, B2F from ##tempexcel 
								union select 'B3' Plant, ROW_NUMBER() OVER (order by (select 0)) ID, B3_SUB from ##tempexcel 
								union select 'B4' Plant, ROW_NUMBER() OVER (order by (select 0)) ID, B4_SUB from ##tempexcel 
								union select 'B5' Plant, ROW_NUMBER() OVER (order by (select 0)) ID, B5 from ##tempexcel 
								union select 'VVI' Plant, ROW_NUMBER() OVER (order by (select 0)) ID, VVI from ##tempexcel 
								union select 'B4+VVI' Plant, ROW_NUMBER() OVER (order by (select 0)) ID, B4_VVI from ##tempexcel 
								union select 'SUB' Plant, ROW_NUMBER() OVER (order by (select 0)) ID, SUB from ##tempexcel 
								union select 'Overall' Plant, ROW_NUMBER() OVER (order by (select 0)) ID, GrandTotal from ##tempexcel 
								)
								select Plant,
								MAX(case ID when 1 then DATA ELSE NULL END) AS COL1,
								MAX(case ID when 2 then DATA ELSE NULL END) AS COL2,
								MAX(case ID when 3 then DATA ELSE NULL END) AS COL3,
								MAX(case ID when 4 then DATA ELSE NULL END) AS COL4,
								MAX(case ID when 5 then DATA ELSE NULL END) AS COL5,
								MAX(case ID when 6 then DATA ELSE NULL END) AS COL6,
								MAX(case ID when 7 then DATA ELSE NULL END) AS COL7,
								MAX(case ID when 8 then DATA ELSE NULL END) AS COL8,
								MAX(case ID when 9 then DATA ELSE NULL END) AS COL9,
								MAX(case ID when 10 then DATA ELSE NULL END) AS COL10,
								MAX(case ID when 11 then DATA ELSE NULL END) AS COL11,
								MAX(case ID when 12 then DATA ELSE NULL END) AS COL12,
								MAX(case ID when 13 then DATA ELSE NULL END) AS COL13,
								MAX(case ID when 14 then DATA ELSE NULL END) AS COL14 
						from query GROUP BY Plant;

						OPEN Sum_Value
						FETCH NEXT FROM Sum_Value INTO @Plant,@COL1,@COL2,@COL3,@COL4,@COL5,@COL6,@COL7,@COL8,@COL9,@COL10,@COL11,@COL12,@COL13,@COL14 
						WHILE @@FETCH_STATUS=0
							BEGIN
								SET @xmlData=@xmlData+'<dataset seriesName='+''''+CONVERT(VARCHAR(20),@Plant)+''''+'>'								
								SET @xmlData=@xmlData+'<set value='+''''+CONVERT(VARCHAR(20),@COL1)+''''+' />'
								SET @xmlData=@xmlData+'<set value='+''''+CONVERT(VARCHAR(20),@COL2)+''''+' />'
								SET @xmlData=@xmlData+'<set value='+''''+CONVERT(VARCHAR(20),@COL3)+''''+' />'
								SET @xmlData=@xmlData+'<set value='+''''+CONVERT(VARCHAR(20),@COL4)+''''+' />'
								SET @xmlData=@xmlData+'<set value='+''''+CONVERT(VARCHAR(20),@COL5)+''''+' />'
								SET @xmlData=@xmlData+'<set value='+''''+CONVERT(VARCHAR(20),@COL6)+''''+' />'
								SET @xmlData=@xmlData+'<set value='+''''+CONVERT(VARCHAR(20),@COL7)+''''+' />'
								SET @xmlData=@xmlData+'<set value='+''''+CONVERT(VARCHAR(20),@COL8)+''''+' />'
								SET @xmlData=@xmlData+'<set value='+''''+CONVERT(VARCHAR(20),@COL9)+''''+' />'
								SET @xmlData=@xmlData+'<set value='+''''+CONVERT(VARCHAR(20),@COL10)+''''+' />'
								SET @xmlData=@xmlData+'<set value='+''''+CONVERT(VARCHAR(20),@COL11)+''''+' />'
								SET @xmlData=@xmlData+'<set value='+''''+CONVERT(VARCHAR(20),@COL12)+''''+' />'
								SET @xmlData=@xmlData+'<set value='+''''+CONVERT(VARCHAR(20),@COL13)+''''+' />'								
							    SET @xmlData=@xmlData+'</dataset>'
								
								FETCH NEXT FROM Sum_Value INTO @Plant,@COL1,@COL2,@COL3,@COL4,@COL5,@COL6,@COL7,@COL8,@COL9,@COL10,@COL11,@COL12,@COL13,@COL14 
							END
						CLOSE Sum_Value
						DEALLOCATE Sum_Value
				
			END
			
			IF @WeeksNum='4'		
		BEGIN
						DECLARE Sum_Value CURSOR FOR		
						with query as (
								select 'B1' Plant, ROW_NUMBER() OVER (order by (select 0)) ID, B1 as DATA from ##tempexcel 
								union select 'B2F' Plant, ROW_NUMBER() OVER (order by (select 0)) ID, B2F from ##tempexcel 
								union select 'B3' Plant, ROW_NUMBER() OVER (order by (select 0)) ID, B3_SUB from ##tempexcel 
								union select 'B4' Plant, ROW_NUMBER() OVER (order by (select 0)) ID, B4_SUB from ##tempexcel 
								union select 'B5' Plant, ROW_NUMBER() OVER (order by (select 0)) ID, B5 from ##tempexcel 
								union select 'VVI' Plant, ROW_NUMBER() OVER (order by (select 0)) ID, VVI from ##tempexcel 
								union select 'B4+VVI' Plant, ROW_NUMBER() OVER (order by (select 0)) ID, B4_VVI from ##tempexcel 
								union select 'SUB' Plant, ROW_NUMBER() OVER (order by (select 0)) ID, SUB from ##tempexcel 
								union select 'Overall' Plant, ROW_NUMBER() OVER (order by (select 0)) ID, GrandTotal from ##tempexcel 
								)
								select Plant,
								MAX(case ID when 1 then DATA ELSE NULL END) AS COL1,
								MAX(case ID when 2 then DATA ELSE NULL END) AS COL2,
								MAX(case ID when 3 then DATA ELSE NULL END) AS COL3,
								MAX(case ID when 4 then DATA ELSE NULL END) AS COL4,
								MAX(case ID when 5 then DATA ELSE NULL END) AS COL5 
						from query GROUP BY Plant;

						OPEN Sum_Value
						FETCH NEXT FROM Sum_Value INTO @Plant,@COL1,@COL2,@COL3,@COL4,@COL5  
						WHILE @@FETCH_STATUS=0
							BEGIN
								SET @xmlData=@xmlData+'<dataset seriesName='+''''+CONVERT(VARCHAR(20),@Plant)+''''+'>'								
								SET @xmlData=@xmlData+'<set value='+''''+CONVERT(VARCHAR(20),@COL1)+''''+' />'
								SET @xmlData=@xmlData+'<set value='+''''+CONVERT(VARCHAR(20),@COL2)+''''+' />'
								SET @xmlData=@xmlData+'<set value='+''''+CONVERT(VARCHAR(20),@COL3)+''''+' />'
								SET @xmlData=@xmlData+'<set value='+''''+CONVERT(VARCHAR(20),@COL4)+''''+' />'
							    SET @xmlData=@xmlData+'</dataset>'

								FETCH NEXT FROM Sum_Value INTO @Plant,@COL1,@COL2,@COL3,@COL4,@COL5 
							END
						CLOSE Sum_Value
						DEALLOCATE Sum_Value
			END

			SET @xmlData=@xmlData+'</chart>'

		DROP TABLE ##tempexcel
		SELECT @xmlData AS xmlData
		
END 














GO
