USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Monthly_Cu_Tensile_Strength_sp_Bellcore_IR_Monthly]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[Monthly_Cu_Tensile_Strength_sp_Bellcore_IR_Monthly]
	@Year VARCHAR(4),
	@Month VARCHAR(4),
	@Plant VARCHAR(4),
	@type int=0 
AS

BEGIN
SET NOCOUNT ON; 

if @type = 0
	BEGIN
		EXEC ('select m.* 
		,(select MAX(TestValue) from Monthly_Cu_Tensile_Strength_Bellcore_IR_Data d where ProcessTest=''Initial'' AND d.Year=m.Year AND d.month=m.month AND plant='''+@Plant+''' AND d.Process=m.Process) as [MAX_Initial]
		,(select MIN(TestValue) from Monthly_Cu_Tensile_Strength_Bellcore_IR_Data d where ProcessTest=''Initial'' AND d.Year=m.Year AND d.month=m.month AND plant='''+@Plant+''' AND d.Process=m.Process) as [MIN_Initial]
		,(select MAX(TestValue) from Monthly_Cu_Tensile_Strength_Bellcore_IR_Data d where ProcessTest=''24 hrs'' AND d.Year=m.Year AND d.month=m.month AND plant='''+@Plant+''' AND d.Process=m.Process) as [MAX_24hrs]
		,(select MIN(TestValue) from Monthly_Cu_Tensile_Strength_Bellcore_IR_Data d where ProcessTest=''24 hrs'' AND d.Year=m.Year AND d.month=m.month AND plant='''+@Plant+''' AND d.Process=m.Process) as [MIN_24hrs]
		 from
		(select * from (select [Year],[month],Process,ProcessTest,TestValue from Monthly_Cu_Tensile_Strength_Bellcore_IR_Data where year='''+@Year+''' AND Month='''+@Month+''' AND plant='''+@Plant+''' AND SN=''Avg'') a pivot (max(TestValue) for ProcessTest in ([Initial],[24 hrs])) b) m , 
		(select [Year],[month], Process from Monthly_Cu_Tensile_Strength_Bellcore_IR_Data where year='''+@Year+''' AND Month='''+@Month+''' AND plant='''+@Plant+''' AND SN=''Avg'' group by [Year],[month], Process) n
		where m.Year = n.Year and m.[month]=n.[month] and m.Process=n.Process and m.Process<>''After ENIG'' order by Process') 
	END  
ELSE
	BEGIN
		EXEC ('select m.* 
		,(select MAX(TestValue) from Monthly_Cu_Tensile_Strength_Bellcore_IR_Data d where ProcessTest=''Initial'' AND d.Year=m.Year AND d.month=m.month AND plant='''+@Plant+''' AND d.Process=m.Process) as [MAX_Initial]
		,(select MIN(TestValue) from Monthly_Cu_Tensile_Strength_Bellcore_IR_Data d where ProcessTest=''Initial'' AND d.Year=m.Year AND d.month=m.month AND plant='''+@Plant+''' AND d.Process=m.Process) as [MIN_Initial]
		,(select MAX(TestValue) from Monthly_Cu_Tensile_Strength_Bellcore_IR_Data d where ProcessTest=''24 hrs'' AND d.Year=m.Year AND d.month=m.month AND plant='''+@Plant+''' AND d.Process=m.Process) as [MAX_24hrs]
		,(select MIN(TestValue) from Monthly_Cu_Tensile_Strength_Bellcore_IR_Data d where ProcessTest=''24 hrs'' AND d.Year=m.Year AND d.month=m.month AND plant='''+@Plant+''' AND d.Process=m.Process) as [MIN_24hrs]
		 from
		(select * from (select [Year],[month],Process,ProcessTest,TestValue from Monthly_Cu_Tensile_Strength_Bellcore_IR_Data where year='''+@Year+''' AND Month='''+@Month+''' AND plant='''+@Plant+''' AND SN=''Avg'') a pivot (max(TestValue) for ProcessTest in ([Initial],[24 hrs])) b) m , 
		(select [Year],[month], Process from Monthly_Cu_Tensile_Strength_Bellcore_IR_Data where year='''+@Year+''' AND Month='''+@Month+''' AND plant='''+@Plant+''' AND SN=''Avg'' group by [Year],[month], Process) n
		where m.Year = n.Year and m.[month]=n.[month] and m.Process=n.Process and m.Process=''After ENIG'' order by Process') 
	END  

END
GO
