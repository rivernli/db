USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_fusionChart_Book_to_bill_Line]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[sp_fusionChart_Book_to_bill_Line] 
@WeeksNum INT
as 

BEGIN

declare @Mincalenderdate NVARCHAR(50),@Maxcalenderdate NVARCHAR(50), @xmlData NVARCHAR(MAX)
declare @WeekSType NVARCHAR(20), @B1 NUMERIC(19,2),@B2F NUMERIC(19,2),@B3 NUMERIC(19,2),@B4 NUMERIC(19,2),@B5 NUMERIC(19,2),@VVI NUMERIC(19,2),@B4_VVI NUMERIC(19,2),@SUB NUMERIC(19,2) 
declare @Tb119_b4 NUMERIC(19,2), @Tb119_vvi NUMERIC(19,2), @Tb105_b4 NUMERIC(19,2), @Tb105_vvi NUMERIC(19,2) 

IF @WeeksNum='13' 
SET @WeekSType = ' Book to bill (M)'
ELSE
SET @WeekSType = ' Book to bill (Q)'

		--select Min Date
		SET @Mincalenderdate=(
								select min(Mincalenderdate) from
								(
								SELECT  top (@WeeksNum)
											convert(varchar(10),min(calenderdate),120) AS Mincalenderdate 
											FROM DataWarehouse.dbo.DW_DIM_Calender 
											WHERE 
											calenderdate >= (select convert(varchar(10),(getdate()-calenderWeek)-92,120) as lastweek
											 FROM DataWarehouse.dbo.DW_DIM_Calender where calenderdate=convert(nvarchar(10),getdate(),120))
											AND calenderdate <= convert(nvarchar(10),getdate(),120)			
											AND Fiscalweek<>(select Fiscalweek from DataWarehouse.dbo.DW_DIM_Calender where calenderdate=convert(nvarchar(10),getdate(),120))	
											group by Fiscalweek
								) tbMinDateTable
							  );


		SET @Maxcalenderdate=(
								select max(Maxcalenderdate) from
								(
								SELECT  top (@WeeksNum)
											convert(varchar(10),max(calenderdate),120) AS Maxcalenderdate 
											FROM DataWarehouse.dbo.DW_DIM_Calender 
											WHERE 
											calenderdate >= (select convert(varchar(10),(getdate()-calenderWeek)-92,120) as lastweek
											 FROM DataWarehouse.dbo.DW_DIM_Calender where calenderdate=convert(nvarchar(10),getdate(),120))
											AND calenderdate <= convert(nvarchar(10),getdate(),120)			
											AND Fiscalweek<>(select Fiscalweek from DataWarehouse.dbo.DW_DIM_Calender where calenderdate=convert(nvarchar(10),getdate(),120))	
											group by Fiscalweek
								) tbManDateTable
							  );

		 SET @B1 = (SELECT SUM(T$PB12)/(select SUM(T$AMNT) from TFSOLP105180 WHERE T$DATE between ''+@Mincalenderdate+'' and ''+@Maxcalenderdate+'' AND T$PLNT='P2') FROM TFSOLP119180 WHERE T$ODAT between ''+@Mincalenderdate+'' and ''+@Maxcalenderdate+'')
		 SET @B2F = (SELECT SUM(T$B2F)/(select SUM(T$AMNT) from TFSOLP105180 WHERE T$DATE between ''+@Mincalenderdate+'' and ''+@Maxcalenderdate+'' AND T$PLNT='2F') FROM TFSOLP119180 WHERE T$ODAT between ''+@Mincalenderdate+'' and ''+@Maxcalenderdate+'')
		 SET @B3 = (SELECT SUM(T$PB3)/(select SUM(T$AMNT) from TFSOLP105180 WHERE T$DATE between ''+@Mincalenderdate+'' and ''+@Maxcalenderdate+'' AND T$PLNT='B3') FROM TFSOLP119180 WHERE T$ODAT between ''+@Mincalenderdate+'' and ''+@Maxcalenderdate+'')
		 SET @Tb119_b4 = (SELECT SUM(T$PB4) FROM TFSOLP119180 WHERE T$ODAT between ''+@Mincalenderdate+'' and ''+@Maxcalenderdate+'')
		 SET @Tb105_b4 = (select SUM(T$AMNT) from TFSOLP105180 WHERE T$DATE between ''+@Mincalenderdate+'' and ''+@Maxcalenderdate+'' AND T$PLNT='B4') 
		 SET @B4 = @Tb119_b4/@Tb105_b4
		 SET @B5 = (SELECT SUM(T$PB5)/(select SUM(T$AMNT) from TFSOLP105180 WHERE T$DATE between ''+@Mincalenderdate+'' and ''+@Maxcalenderdate+'' AND T$PLNT='B5') FROM TFSOLP119180 WHERE T$ODAT between ''+@Mincalenderdate+'' and ''+@Maxcalenderdate+'')
		 SET @Tb119_vvi = (SELECT SUM(T$SUB1) FROM TFSOLP119180 WHERE T$ODAT between ''+@Mincalenderdate+'' and ''+@Maxcalenderdate+'')
		 SET @Tb105_vvi = (select SUM(T$AMNT) from .TFSOLP105180 WHERE T$DATE between ''+@Mincalenderdate+'' and ''+@Maxcalenderdate+'' AND T$PLNT='HK')
		 SET @VVI = @Tb119_vvi/@Tb105_vvi
		 SET @B4_VVI = (@Tb119_b4+@Tb119_vvi)/(@Tb105_b4+@Tb105_vvi)
		 SET @SUB = (SELECT SUM(T$SUB2)/(select SUM(T$AMNT) from TFSOLP105180 WHERE T$DATE between ''+@Mincalenderdate+'' and ''+@Maxcalenderdate+'' AND T$PLNT='HK' AND (T$cotp='CNG' OR T$cotp='SLS')) FROM TFSOLP119180 WHERE T$ODAT between ''+@Mincalenderdate+'' and ''+@Maxcalenderdate+'')
		

		SET @xmlData='';
		SET @xmlData=@xmlData+'<chart caption='+''''+CONVERT(VARCHAR(20),@WeeksNum) + @WeekSType +''''+' swfurl="../Include/Line.swf"  shownames="1" showvalues="0" numberPrefix="$" alternateHGridColor="FCB541" alternateHGridAlpha="20" divLineColor="FCB541" divLineAlpha="50" canvasBorderColor="666666" baseFontColor="666666" lineColor="FCB541">'			
		SET @xmlData=@xmlData+'<set label='+''''+'B1'+''''+' value='+''''+CONVERT(VARCHAR(20),@B1)+''''+' />'
		SET @xmlData=@xmlData+'<set label='+''''+'B2F'+''''+' value='+''''+CONVERT(VARCHAR(20),@B2F)+''''+' />'
		SET @xmlData=@xmlData+'<set label='+''''+'B3'+''''+' value='+''''+CONVERT(VARCHAR(20),@B3)+''''+' />'
		SET @xmlData=@xmlData+'<set label='+''''+'B4'+''''+' value='+''''+CONVERT(VARCHAR(20),@B4)+''''+' />'
		SET @xmlData=@xmlData+'<set label='+''''+'B5'+''''+' value='+''''+CONVERT(VARCHAR(20),@B5)+''''+' />'
		SET @xmlData=@xmlData+'<set label='+''''+'VVI'+''''+' value='+''''+CONVERT(VARCHAR(20),@VVI)+''''+' />'
		SET @xmlData=@xmlData+'<set label='+''''+'B4+VVI'+''''+' value='+''''+CONVERT(VARCHAR(20),@B4_VVI)+''''+' />'	
		SET @xmlData=@xmlData+'<set label='+''''+'SUB'+''''+' value='+''''+CONVERT(VARCHAR(20),@SUB)+''''+' />'		
		SET @xmlData=@xmlData+'</chart>'
		
		SELECT @xmlData AS xmlData		
END 















GO
