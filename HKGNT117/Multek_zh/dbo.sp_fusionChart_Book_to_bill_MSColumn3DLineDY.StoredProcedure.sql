USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_fusionChart_Book_to_bill_MSColumn3DLineDY]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE procedure [dbo].[sp_fusionChart_Book_to_bill_MSColumn3DLineDY] 
@WeeksNum INT
as 

declare @Mincalenderdate NVARCHAR(50),@Maxcalenderdate NVARCHAR(50), @xmlData NVARCHAR(MAX)
declare @WeekSType NVARCHAR(20), @B1 NUMERIC(19,3),@B2F NUMERIC(19,3),@B3 NUMERIC(19,3),@B4 NUMERIC(19,3),@B5 NUMERIC(19,3),@VVI NUMERIC(19,3),@B4_VVI NUMERIC(19,3),@SUB NUMERIC(19,3) 
		
BEGIN
			SET @xmlData='';
			SET @xmlData=@xmlData+'<chart palette="1" caption='+''''+CONVERT(VARCHAR(20),@WeeksNum)+' Book to bill'''+' swfurl="../Include/MSColumn3DLineDY.swf"  shownames="1" showvalues="0" numberPrefix="$" sYAxisValuesDecimals="2" connectNullData="0" numDivLines="4" formatNumberScale="0">'			
			SET @xmlData=@xmlData+'<categories>'			
			SET @xmlData=@xmlData+'<category label="B1" />'
			SET @xmlData=@xmlData+'<category label="B2F" />'
			SET @xmlData=@xmlData+'<category label="B3" />'
			SET @xmlData=@xmlData+'<category label="B4" />'
			SET @xmlData=@xmlData+'<category label="B5" />'
			SET @xmlData=@xmlData+'<category label="VVI" />'
			SET @xmlData=@xmlData+'<category label="B4+VVI" />'	
				SET @xmlData=@xmlData+'<category label="SUB" />'
			SET @xmlData=@xmlData+'</categories>'
		
			DECLARE M_Calender CURSOR FOR
			--select week,date
			select min(Mincalenderdate) AS Mincalenderdate,max(Maxcalenderdate) AS Maxcalenderdate from
			(
			SELECT  top (@WeeksNum)
						convert(varchar(10),min(calenderdate),120) AS Mincalenderdate, 
						convert(varchar(10),max(calenderdate),120) AS Maxcalenderdate 
						FROM DataWarehouse.dbo.DW_DIM_Calender 
						WHERE 
						calenderdate >= (select convert(varchar(10),(getdate()-calenderWeek)-92,120) as lastweek
						 FROM DataWarehouse.dbo.DW_DIM_Calender where calenderdate=convert(nvarchar(10),getdate(),120))
						AND calenderdate <= convert(nvarchar(10),getdate(),120)		
						AND Fiscalweek<>(select Fiscalweek from DataWarehouse.dbo.DW_DIM_Calender where calenderdate=convert(nvarchar(10),getdate(),120))		
						group by Fiscalweek  order by Maxcalenderdate ASC
			) tbDateTable

			OPEN M_Calender
			FETCH NEXT FROM M_Calender INTO @Mincalenderdate,@Maxcalenderdate
			WHILE @@FETCH_STATUS=0
				BEGIN		
					DECLARE Sum_Value CURSOR FOR	
					--Order booked		
					select 'Order booked 4 weeks' AS WeekSType, SUM(T$PB12) AS B1,SUM(T$B2F) AS B2F,SUM(T$PB3) AS B3,SUM(T$PB4) AS B4,SUM(T$PB5) AS B5, 
					 SUM(T$SUB1) AS VVI,SUM(T$PB4)+SUM(T$SUB1) AS B4_VVI, SUM(T$SUB2) AS SUB 
					 from TFSOLP119180 WHERE T$ODAT between ''+@Mincalenderdate+'' and ''+@Maxcalenderdate+''
					UNION  ALL --FG out
					select WeekSType,B1,B2F,B3,B4,B5,VVI,B4+VVI AS B4_VVI,SUB from
					(
					SELECT  'FG out 4 weeks' AS WeekSType,
						(select SUM(T$AMNT) from TFSOLP105180 WHERE T$DATE between ''+@Mincalenderdate+'' and ''+@Maxcalenderdate+'' AND T$PLNT='P2') AS B1,
						(select SUM(T$AMNT) from TFSOLP105180 WHERE T$DATE between ''+@Mincalenderdate+'' and ''+@Maxcalenderdate+'' AND T$PLNT='2F') AS B2F,
						(select SUM(T$AMNT) from TFSOLP105180 WHERE T$DATE between ''+@Mincalenderdate+'' and ''+@Maxcalenderdate+'' AND T$PLNT='B3') AS B3,
						(select SUM(T$AMNT) from TFSOLP105180 WHERE T$DATE between ''+@Mincalenderdate+'' and ''+@Maxcalenderdate+'' AND T$PLNT='B4') AS B4,
						(select SUM(T$AMNT) from TFSOLP105180 WHERE T$DATE between ''+@Mincalenderdate+'' and ''+@Maxcalenderdate+'' AND T$PLNT='B5') AS B5,
						(select SUM(T$AMNT) from .TFSOLP105180 WHERE T$DATE between ''+@Mincalenderdate+'' and ''+@Maxcalenderdate+'' AND T$PLNT='HK') AS VVI, 
						(select SUM(T$AMNT) from TFSOLP105180 where T$PLNT='HK' AND (T$cotp='CNG' OR T$cotp='SLS')) AS SUB 
					) tb105180

				OPEN Sum_Value
					FETCH NEXT FROM Sum_Value INTO @WeekSType,@B1,@B2F,@B3,@B4,@B5,@VVI,@B4_VVI,@SUB  
					WHILE @@FETCH_STATUS=0
						BEGIN
							SET @xmlData=@xmlData+'<dataset seriesName='+''''+CONVERT(VARCHAR(20),@WeekSType)+''''+' showValues="0">'								
							SET @xmlData=@xmlData+'<set value='+''''+CONVERT(VARCHAR(20),@B1)+''''+' />'
							SET @xmlData=@xmlData+'<set value='+''''+CONVERT(VARCHAR(20),@B2F)+''''+' />'
							SET @xmlData=@xmlData+'<set value='+''''+CONVERT(VARCHAR(20),@B3)+''''+' />'
							SET @xmlData=@xmlData+'<set value='+''''+CONVERT(VARCHAR(20),@B4)+''''+' />'
							SET @xmlData=@xmlData+'<set value='+''''+CONVERT(VARCHAR(20),@B5)+''''+' />'
							SET @xmlData=@xmlData+'<set value='+''''+CONVERT(VARCHAR(20),@VVI)+''''+' />'
							SET @xmlData=@xmlData+'<set value='+''''+CONVERT(VARCHAR(20),@B4_VVI)+''''+' />'
							SET @xmlData=@xmlData+'<set value='+''''+CONVERT(VARCHAR(20),@SUB)+''''+' />'
						    SET @xmlData=@xmlData+'</dataset>'
							FETCH NEXT FROM Sum_Value INTO @WeekSType,@B1,@B2F,@B3,@B4,@B5,@VVI,@B4_VVI,@SUB 
						END
					CLOSE Sum_Value
					DEALLOCATE Sum_Value
				END	
			CLOSE M_Calender
			DEALLOCATE M_Calender
		
			SET @xmlData=@xmlData+'</chart>'		
		SELECT @xmlData AS xmlData
		
END 















GO
