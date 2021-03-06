USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[SQM_sp_Query_CoA]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SQM_sp_Query_CoA]
	@str_Where NVARCHAR(max),
	@ItemType NVARCHAR(50)=NULL 

AS
SET NOCOUNT ON 

select * into #temp from 
(
	select b.T$UPRN,b.T$CAID,(CASE b.T$TYPE WHEN '2' THEN b.T$CAD1 WHEN '1' THEN b.T$CAD2 END) as result,b.T$ITEM  from tfspur018180 a
	INNER JOIN tfspur019180 b ON b.T$UPRN=a.T$UPRN AND b.T$ITEM=a.T$ITEM WHERE ltrim(a.T$CITG)=@ItemType  
) tb 


declare @sql varchar(max)
select @sql = isnull(@sql + '],[' , '') + T$CAID from tfsitm031180 group by T$CAID 
set @sql = '[' + @sql + ']'

IF @ItemType='IG004'
BEGIN
	EXEC ('
		select T$UPRN,[#STDT!] as [Delivery Date],[#STPO!] as [Purchase_Order_No],[#STLO!] as [Manufacturing Location],[#STDS!] as [Materials Description],
		[#STDN!] as [Materials Part.No],[#STLT!] as [Lot No./Batch No],[#STPD!] as [Manufacture Date],[#AC!] as [Appearance on copper-clad surface],
		[#AB!] as [Appearance of base meterial after],[#DI1!]+[#DI2!] as [Demension inspection],[#TC1!]+[#TC2!] as [Thickness(including Copper clad)],
		[#TG1!] as [Glass Transition temperature(Tg)],[#TS!] as [Thermal Stress*(solder Float)],[#AR!] as [Arc Resistance],[#FB1!]+[#FB2!] as [Flammability],
		[#DS1!]+[#DS2!] as [Dimensional Stability],[#PS!] as [Peel Strength],[#MA!] as [Moisture Absorption],[#TE!] as [Thermal expansion coeffcient],
		[#FS1!]+[#FS2!] as [Flexural Strength], [#WT1!] as [Warp/Twist], [#VR1!] as [Volume Resisivity], [#SR1!] as [Surface resistance], 
		[#PM!] as [Permittivity],[#LT!] as [Loss Tangent] from (select * from #temp) a pivot (max(result) for T$CAID in (' + @sql + ')) b '+@str_Where+'  
	')
END

IF @ItemType='IG005'
BEGIN 
	EXEC ('
		select T$UPRN,[#STDT!] as [Delivery Date],[#STPO!] as [Purchase_Order_No],[#STLO!] as [Manufacturing Location],[#STDS!] as [Materials Description],
		[#STDN!] as [Materials Part.No],[#STLT!] as [Lot No./Batch No],[#STPD!] as [Manufacture Date],[#SI!] as [Surface inspection],
		[#DR!] as [Dimension inspection],[#RC!] as [Resin content],[#RF!] as [Resin flow],
		[#GT!] as [Gel time],[#VC!] as [Volatile content],[#MV!] as [Minimum viscosity],[#TV!] as [Time to minimum viscosity],[#FC!] as [Filler content] 
		from (select * from #temp) a pivot (max(result) for T$CAID in (' + @sql + ')) b '+@str_Where+'  
	')
END 
 


GO
