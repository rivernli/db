USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Monthly_Cu_Tensile_Strength_sp_Tank]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[Monthly_Cu_Tensile_Strength_sp_Tank]
	@Year_s VARCHAR(10),
	@Year_e VARCHAR(10),	
	@Plant VARCHAR(4),
	@ProductionLine NVARCHAR(50),
	@Tank NVARCHAR(50),
	@TankType VARCHAR(2),
	@type NVARCHAR(50)
AS

BEGIN
SET NOCOUNT ON;

declare @sql varchar(max)
select @sql = isnull(@sql + '],[' , '') + SN from Monthly_Cu_Tensile_Strength_Data WHERE TankType=''+@TankType+'' AND SN='Avg' group by SN 
		set @sql = '[' + @sql + ']' 		
		
		EXEC ('select m.*,MaxValue,MinValue,(select TestValue from Monthly_Cu_Tensile_Strength_Data d where d.[Type]=''Thickness'' AND SN=''Avg'' AND d.TankType=m.TankType AND d.Year=m.Year AND d.month=m.month AND d.ProductionLine=m.ProductionLine AND d.Tank=m.Tank) as Thickness 
			from (select * from (select [Year],[month],ProductionLine,Tank,TankType,[Type],TestValue,SN from Monthly_Cu_Tensile_Strength_Data WHERE CONVERT(VARCHAR,[Year])+right(100+Month,2) BETWEEN '''+@Year_s+''' AND '''+@Year_e+''' AND plant='''+@Plant+''' AND ProductionLine='''+@ProductionLine+''' AND Tank='''+@Tank+''' AND TankType='''+@TankType+''' AND Type='''+@Type+''' AND SN=''Avg'') a pivot (max(TestValue) for SN in ('+@sql+')) b) m , 
			(select [Year],[month], ProductionLine,Tank,TankType,[Type],Max(TestValue) as MaxValue, Min(TestValue) as MinValue from Monthly_Cu_Tensile_Strength_Data group by [Year],[month], ProductionLine,Tank,TankType,[Type]) n
			where m.Year = n.Year and m.[month]=n.[month] and m.Tank=n.Tank and m.TankType=n.TankType and m.[Type]=n.[Type] order by ProductionLine,Tank ') 
	
END 
 
GO
