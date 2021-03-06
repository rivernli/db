USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_b2f_forecast_result]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_gam_b2f_forecast_result]
as
set nocount on

declare @sp int 
--select @sp=201406 
select @sp=multek_zh.dbo.fx_getCurrentPeriod()

--select distinct uploadPeriod,sales,oem+' B2F' as cusOEM,oem as OEMName,'B2F' as Plant,cpn,pn into #base from GAM_B2F where uploadPeriod=@sp
select distinct sales,oem+' B2F' as cusOEM,oem as OEMName,'B2F' as Plant,cpn,pn,
0 as cusASP,0 as expASP,0 as expASPPeriod,0 as maxASP,0 as minASP,0 as ttlAMT,0 as ttlQTY,0 as ttlSQFT,
'' as layer,'' as tech, '' as surf,'' as remark
into #base from GAM_B2F where uploadPeriod=@sp

declare @cp int,@sql nvarchar(max),@i int
select @i=1
while(@i<=13)
begin
	select @cp = multek_zh.dbo.fx_periodAdd(201406,@i),@i=@i+1
	SELECT @SQL = 'ALTER TABLE #base ADD [' + convert(varchar(10),@cp) + '] float default 0.0'
	Exec (@SQL)
	select @sql = 'update #base  set ['+ convert(varchar(10),@cp) +']= 0; update #base  set ['+ convert(varchar(10),@cp) +']= isnull(amt,0) from #base as p left join '+
	' (select sales,oem,cpn,pn,qty * (smtPrice+fpcprice+bomprice) as amt from gam_b2f where uploadperiod=' +
	convert(varchar(10),@sp) +' and forecastPeriod='+convert(varchar(10),@cp) +' ) as t '+
	'on p.oemName=t.oem and p.sales=t.sales and p.cpn=t.cpn and p.pn=t.pn '
	exec (@sql)
end
select * from #base
drop table #base

set nocount off
GO
