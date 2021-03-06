USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Monthly_Cu_Tensile_Strength_sp_Tank_T]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Monthly_Cu_Tensile_Strength_sp_Tank_T]
	@Year_s VARCHAR(10),
	@Year_e VARCHAR(10),	
	@Plant VARCHAR(4),
	@ProductionLine NVARCHAR(50),
	@Tank NVARCHAR(50),
	@type NVARCHAR(50)
AS

BEGIN
SET NOCOUNT ON;

--declare @sql varchar(max)
--select @sql = isnull(@sql + '],[' , '') + TankType from Monthly_Cu_Tensile_Strength_Data group by TankType order by TankType DESC  
--set @sql = '[' + @sql + ']' 	
		
		EXEC ('select m.* 
,(select MAX(TestValue) from Monthly_Cu_Tensile_Strength_Data d where d.[Type]='''+@type+''' AND plant='''+@Plant+''' AND TankType=''V'' AND d.Year=m.Year AND right(100+d.month,2)=m.month AND d.ProductionLine=m.ProductionLine AND d.Tank=m.Tank) as [MAX_V]
,(select MIN(TestValue) from Monthly_Cu_Tensile_Strength_Data d where d.[Type]='''+@type+''' AND plant='''+@Plant+''' AND TankType=''V'' AND d.Year=m.Year AND right(100+d.month,2)=m.month AND d.ProductionLine=m.ProductionLine AND d.Tank=m.Tank) as [MIN_V]
,(select MAX(TestValue) from Monthly_Cu_Tensile_Strength_Data d where d.[Type]='''+@type+''' AND plant='''+@Plant+''' AND TankType=''H'' AND d.Year=m.Year AND right(100+d.month,2)=m.month AND d.ProductionLine=m.ProductionLine AND d.Tank=m.Tank) as [MAX_H]
,(select MIN(TestValue) from Monthly_Cu_Tensile_Strength_Data d where d.[Type]='''+@type+''' AND plant='''+@Plant+''' AND TankType=''H'' AND d.Year=m.Year AND right(100+d.month,2)=m.month AND d.ProductionLine=m.ProductionLine AND d.Tank=m.Tank) as [MIN_H]
,(select TestValue from Monthly_Cu_Tensile_Strength_Data d where d.[Type]=''Thickness'' AND plant='''+@Plant+''' AND SN=''Avg'' AND TankType=''V'' AND d.Year=m.Year AND right(100+d.month,2)=m.month  AND d.ProductionLine=m.ProductionLine AND d.Tank=m.Tank) as [Thickness_V]
,(select TestValue from Monthly_Cu_Tensile_Strength_Data d where d.[Type]=''Thickness'' AND plant='''+@Plant+''' AND SN=''Avg'' AND TankType=''H'' AND d.Year=m.Year AND right(100+d.month,2)=m.month  AND d.ProductionLine=m.ProductionLine AND d.Tank=m.Tank) as [Thickness_H] 
 from
(select * from (select [Year],right(100+Month,2) as [month],ProductionLine,Tank,TankType,TestValue from Monthly_Cu_Tensile_Strength_Data where CONVERT(VARCHAR,[Year])+right(100+Month,2) BETWEEN '''+@Year_s+''' AND '''+@Year_e+''' AND plant='''+@Plant+''' AND ProductionLine='''+@ProductionLine+''' AND Tank='''+@Tank+''' AND Type='''+@Type+''' AND SN=''Avg'') a pivot (max(TestValue) for TankType in ([V],[H])) b) m , 
(select [Year],right(100+Month,2) as [month], ProductionLine,Tank from Monthly_Cu_Tensile_Strength_Data where CONVERT(VARCHAR,[Year])+right(100+Month,2) BETWEEN '''+@Year_s+''' AND '''+@Year_e+''' AND plant='''+@Plant+''' AND ProductionLine='''+@ProductionLine+''' AND Tank='''+@Tank+''' AND Type='''+@Type+''' AND SN=''Avg'' group by [Year],[month], ProductionLine,Tank) n
where m.Year = n.Year and m.[month]=n.[month] and m.Tank=n.Tank order by ProductionLine,Tank ') 


		--EXEC ('select m.* 
		--	from (select * from (select [Year],[month],ProductionLine,Tank,TankType,[Type],TestValue,SN from Monthly_Cu_Tensile_Strength_Data WHERE CONVERT(VARCHAR,[Year])+right(100+Month,2) BETWEEN '''+@Year_s+''' AND '''+@Year_e+''' AND plant='''+@Plant+''' AND ProductionLine='''+@ProductionLine+''' AND Tank='''+@Tank+''' AND Type='''+@Type+''' AND SN=''Avg'') a pivot (max(TestValue) for SN in ('+@sql+')) b) m , 
		--	(select [Year],[month], ProductionLine,Tank,TankType,[Type],Max(TestValue) as MaxValue, Min(TestValue) as MinValue from Monthly_Cu_Tensile_Strength_Data group by [Year],[month], ProductionLine,Tank,TankType,[Type]) n
		--	where m.Year = n.Year and m.[month]=n.[month] and m.Tank=n.Tank and m.TankType=n.TankType and m.[Type]=n.[Type] order by ProductionLine,Tank ') 
	
END 
GO
