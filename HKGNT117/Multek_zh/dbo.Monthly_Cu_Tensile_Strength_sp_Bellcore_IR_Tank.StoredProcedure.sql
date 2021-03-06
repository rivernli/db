USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Monthly_Cu_Tensile_Strength_sp_Bellcore_IR_Tank]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Monthly_Cu_Tensile_Strength_sp_Bellcore_IR_Tank]
	@Year_s VARCHAR(10),
	@Year_e VARCHAR(10),	
	@Plant VARCHAR(4),
	@Process NVARCHAR(50) 
AS

BEGIN
SET NOCOUNT ON;

		 EXEC ('select m.* 
		,(select MAX(TestValue) from Monthly_Cu_Tensile_Strength_Bellcore_IR_Data d where ProcessTest=''Initial'' AND d.Year=m.Year AND right(100+d.month,2)=m.month AND d.Process=Process AND d.ProcessTest=ProcessTest) as [MAX_Initial] 
		,(select MIN(TestValue) from Monthly_Cu_Tensile_Strength_Bellcore_IR_Data d where ProcessTest=''Initial'' AND d.Year=m.Year AND right(100+d.month,2)=m.month AND d.Process=Process AND d.ProcessTest=ProcessTest) as [MIN_Initial] 
		,(select MAX(TestValue) from Monthly_Cu_Tensile_Strength_Bellcore_IR_Data d where ProcessTest=''24 hrs'' AND d.Year=m.Year AND right(100+d.month,2)=m.month AND d.Process=Process AND d.ProcessTest=ProcessTest) as [MAX_24hrs] 
		,(select MIN(TestValue) from Monthly_Cu_Tensile_Strength_Bellcore_IR_Data d where ProcessTest=''24 hrs'' AND d.Year=m.Year AND right(100+d.month,2)=m.month AND d.Process=Process AND d.ProcessTest=ProcessTest) as [MIN_24hrs] 
		 from
		(select * from (select [Year],right(100+Month,2) as [month],Process,ProcessTest,TestValue from Monthly_Cu_Tensile_Strength_Bellcore_IR_Data where CONVERT(VARCHAR,[Year])+right(100+Month,2) BETWEEN '''+@Year_s+''' AND '''+@Year_e+''' AND plant='''+@Plant+''' AND Process='''+@Process+''' AND SN=''Avg'') a pivot (max(TestValue) for ProcessTest in ([Initial],[24 hrs])) b) m , 
		(select [Year],right(100+Month,2) as [month], Process from Monthly_Cu_Tensile_Strength_Bellcore_IR_Data where CONVERT(VARCHAR,[Year])+right(100+Month,2) BETWEEN '''+@Year_s+''' AND '''+@Year_e+''' AND plant='''+@Plant+''' AND Process='''+@Process+''' AND SN=''Avg'' group by [Year],[month], Process) n
		where m.Year = n.Year and m.[month]=n.[month] order by Process ') 

END 


GO
