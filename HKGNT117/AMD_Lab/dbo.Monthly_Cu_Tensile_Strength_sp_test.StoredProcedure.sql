USE [AMD_Lab]
GO
/****** Object:  StoredProcedure [dbo].[Monthly_Cu_Tensile_Strength_sp_test]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 

CREATE proc [dbo].[Monthly_Cu_Tensile_Strength_sp_test]
AS

--select CONVERT(VARCHAR,[Year])+'.'+CONVERT(VARCHAR,right(100+[month],2)) as [Year],Tank,TankType,TS as [Avg] from Monthly_Cu_Tensile_Strength_Data where year='2014' and plant='B1' AND SN='Avg' and Tank='15-18'

declare @sql varchar(max)
select @sql = isnull(@sql + '],[' , '') + TankType from Monthly_Cu_Tensile_Strength_Data group by TankType
set @sql = '[' + @sql + ']' 
EXEC ('select m.* from
(select * from (select [Year],[month],ProductionLine,Tank,TankType,TS from Monthly_Cu_Tensile_Strength_Data where year=''2014'' and plant=''B1'' AND (SN=''Avg'' OR SN=''Maxvalue'' OR SN=''Minvalue'')) a pivot (max(TS) for TankType in (' + @sql + ')) b) m , 
(select [Year],[month], ProductionLine,Tank from Monthly_Cu_Tensile_Strength_Data group by [Year],[month], ProductionLine,Tank) n
where m.Year = n.Year and m.[month]=n.[month] and m.Tank=n.Tank order by Tank') 

GO
