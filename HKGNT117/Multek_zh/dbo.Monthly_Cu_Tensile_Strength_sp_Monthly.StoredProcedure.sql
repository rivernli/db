USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Monthly_Cu_Tensile_Strength_sp_Monthly]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[Monthly_Cu_Tensile_Strength_sp_Monthly]
	@Year VARCHAR(4),
	@Month VARCHAR(4),
	@Plant VARCHAR(4),
	@TankType VARCHAR(2),
	@type NVARCHAR(50)
AS

BEGIN
SET NOCOUNT ON;

declare @sql varchar(max)
select @sql = isnull(@sql + '],[' , '') + SN from Monthly_Cu_Tensile_Strength_Data WHERE TankType=''+@TankType+'' AND SN='Avg' group by SN 
		set @sql = '[' + @sql + ']' 
		


		--EXEC ('select m.* from
		--(select * from (select [Year],[month],ProductionLine,Tank,TankType,TS from Monthly_Cu_Tensile_Strength_Data where year='''+@Year+''' and Month='''+@Month+''' and plant='''+@Plant+''' AND (SN=''Avg'' OR SN=''Max'' OR SN=''Min'')) a pivot (max(TS) for TankType in (' + @sql + ')) b) m , 
		--(select [Year],[month], ProductionLine,Tank from Monthly_Cu_Tensile_Strength_Data where (TankType=''V'' OR TankType=''VMax'' OR TankType=''VMin'') group by [Year],[month], ProductionLine,Tank) n
		--where m.Year = n.Year and m.[month]=n.[month] and m.Tank=n.Tank order by ProductionLine,Tank') 
		
		EXEC ('select m.*,MaxValue,MinValue,(select TestValue from Monthly_Cu_Tensile_Strength_Data d where d.[Type]=''Thickness'' AND SN=''Avg'' AND d.TankType=m.TankType AND d.Year=m.Year AND d.month=m.month AND d.ProductionLine=m.ProductionLine AND d.Tank=m.Tank) as Thickness 
			from (select * from (select [Year],[month],ProductionLine,Tank,TankType,[Type],TestValue,SN from Monthly_Cu_Tensile_Strength_Data where year='''+@Year+''' and Month='''+@Month+''' and plant='''+@Plant+''' AND TankType='''+@TankType+''' AND Type='''+@Type+''' AND SN=''Avg'') a pivot (max(TestValue) for SN in ('+@sql+')) b) m , 
			(select [Year],[month], ProductionLine,Tank,TankType,[Type],Max(TestValue) as MaxValue, Min(TestValue) as MinValue from Monthly_Cu_Tensile_Strength_Data group by [Year],[month], ProductionLine,Tank,TankType,[Type]) n
			where m.Year = n.Year and m.[month]=n.[month] and m.Tank=n.Tank and m.TankType=n.TankType and m.[Type]=n.[Type] order by ProductionLine,Tank ') 
	


--declare @sql varchar(max)
--select @sql = isnull(@sql + '],[' , '') + TankType from Monthly_Cu_Tensile_Strength_Data group by TankType
--set @sql = '[' + @sql + ']' 
--EXEC ('select m.Year,m.Month,m.ProductionLine,m.Tank,ISNULL(m.H,0) as H,ISNULL(m.[H Max],0) as HMax,ISNULL(m.[H Min],0) as HMin,
--ISNULL(m.V,0) as V,ISNULL(m.[V Max],0) as VMax,ISNULL(m.[V Min],0) as VMin from
--(select * from (select [Year],[month],ProductionLine,Tank,TankType,TS from Monthly_Cu_Tensile_Strength_Data where year='''+@Year+''' and Month='''+@Month+''' and plant='''+@Plant+''' AND (SN=''Avg'' OR SN=''Maxvalue'' OR SN=''Minvalue'')) a pivot (max(TS) for TankType in (' + @sql + ')) b) m , 
--(select [Year],[month], ProductionLine,Tank from Monthly_Cu_Tensile_Strength_Data group by [Year],[month], ProductionLine,Tank) n
--where m.Year = n.Year and m.[month]=n.[month] and m.Tank=n.Tank order by ProductionLine,Tank') 

END 
GO
