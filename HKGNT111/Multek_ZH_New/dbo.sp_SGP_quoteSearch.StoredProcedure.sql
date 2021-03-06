USE [Multek_ZH_New]
GO
/****** Object:  StoredProcedure [dbo].[sp_SGP_quoteSearch]    Script Date: 11/06/2014 15:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_SGP_quoteSearch] 
@rfq nvarchar(100)='',
@salesman nvarchar(100)='',
@part nvarchar(100)='',
@oem nvarchar(100)='',
@cem nvarchar(100)='',
@programme nvarchar(100)='',
@status nvarchar(100)='',
@type nvarchar(100)='',
@project nvarchar(50)='',
@orderfield nvarchar(100)='adate',@orderby nvarchar(100)='desc'

as

declare @sqlstr nvarchar(4000) 
select @sqlstr = 'select * from vw_sgp_QuoteCostPricing where 1=1'
+ dbo.fx_field2Value(@rfq,'rfq',0) 
+ dbo.fx_field2Value(@part,'tpn',0) 
+ dbo.fx_field2Value(@oem,'oem',0) 
+ dbo.fx_field2Value(@cem,'cem',0) 
+ dbo.fx_field2Value(@programme,'programme',0) 
+ dbo.fx_field2Value(@salesman,'salesman',0) 
+ dbo.fx_field2Value(@project,'project',0) 

if @type = 'New' 
	select @sqlstr = @sqlstr +' and (price is null)'
if @type = 'Priced' 
	select @sqlstr = @sqlstr +' and (price is not null)'

select @sqlstr = 'select top 500 * from ('+ @sqlstr+' ) as x order by '+ dbo.fx_trim(@orderfield) +' '+ dbo.fx_trim(@orderby) 
exec(@sqlstr)
GO
