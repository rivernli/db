USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Monthly_Cu_Tensile_Strength_sp_Monthly_T]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 

CREATE proc [dbo].[Monthly_Cu_Tensile_Strength_sp_Monthly_T]
	@Year VARCHAR(4),
	@Month VARCHAR(4),
	@Plant VARCHAR(4),
	@type NVARCHAR(50)
AS

BEGIN
SET NOCOUNT ON; 
	
--declare @sql varchar(max)
--select @sql = isnull(@sql + '],[' , '') + TankType from Monthly_Cu_Tensile_Strength_Data group by TankType order by TankType DESC  
--set @sql = '[' + @sql + ']' 


EXEC ('select m.* 
,(select MAX(TestValue) from Monthly_Cu_Tensile_Strength_Data d where d.[Type]='''+@type+''' AND TankType=''V'' AND d.Year=m.Year AND d.month=m.month AND plant='''+@Plant+''' AND d.ProductionLine=m.ProductionLine AND d.Tank=m.Tank) as [MAX_V]
,(select MIN(TestValue) from Monthly_Cu_Tensile_Strength_Data d where d.[Type]='''+@type+''' AND TankType=''V'' AND d.Year=m.Year AND d.month=m.month AND plant='''+@Plant+''' AND d.ProductionLine=m.ProductionLine AND d.Tank=m.Tank) as [MIN_V]
,(select MAX(TestValue) from Monthly_Cu_Tensile_Strength_Data d where d.[Type]='''+@type+''' AND TankType=''H'' AND d.Year=m.Year AND d.month=m.month AND plant='''+@Plant+''' AND d.ProductionLine=m.ProductionLine AND d.Tank=m.Tank) as [MAX_H]
,(select MIN(TestValue) from Monthly_Cu_Tensile_Strength_Data d where d.[Type]='''+@type+''' AND TankType=''H'' AND d.Year=m.Year AND d.month=m.month AND plant='''+@Plant+''' AND d.ProductionLine=m.ProductionLine AND d.Tank=m.Tank) as [MIN_H]
,(select TestValue from Monthly_Cu_Tensile_Strength_Data d where d.[Type]=''Thickness'' AND SN=''Avg'' AND TankType=''V'' AND d.Year=m.Year AND d.month=m.month AND plant='''+@Plant+''' AND d.ProductionLine=m.ProductionLine AND d.Tank=m.Tank) as [Thickness_V]
,(select TestValue from Monthly_Cu_Tensile_Strength_Data d where d.[Type]=''Thickness'' AND SN=''Avg'' AND TankType=''H'' AND d.Year=m.Year AND d.month=m.month AND plant='''+@Plant+''' AND d.ProductionLine=m.ProductionLine AND d.Tank=m.Tank) as [Thickness_H]
 from
(select * from (select [Year],[month],ProductionLine,Tank,TankType,TestValue from Monthly_Cu_Tensile_Strength_Data where year='''+@Year+''' AND Month='''+@Month+''' AND plant='''+@Plant+''' AND [Type]='''+@type+''' AND SN=''Avg'') a pivot (max(TestValue) for TankType in ([V],[H])) b) m , 
(select [Year],[month], ProductionLine,Tank from Monthly_Cu_Tensile_Strength_Data where year='''+@Year+''' AND Month='''+@Month+''' AND plant='''+@Plant+''' AND [Type]='''+@type+''' AND SN=''Avg'' group by [Year],[month], ProductionLine,Tank) n
where m.Year = n.Year and m.[month]=n.[month] and m.ProductionLine=n.ProductionLine and m.Tank=n.Tank order by ProductionLine,Tank') 

END  

GO
