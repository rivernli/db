USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_cem_forecast_mix_result]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_gam_cem_forecast_mix_result]
as
set nocount on


declare @currentPeriod int, @fperiod int, @i int,@sql nvarchar(max)
select @currentPeriod=multek_zh.dbo.fx_getCurrentPeriod()

create table #tmp_cemm
(userName nvarchar(100),cusOEM nvarchar(255),oemName nvarchar(255),plant nvarchar(50),
cusPart nvarchar(255),item nvarchar(255) null, cusASP real default 0, expASP real null,expASPPeriod int null,
maxASP real null,minASP real null,ttlAMT real null,ttlQty int null,ttlSQFT real null,layer int null,
tech nvarchar(100) null,surf nvarchar(100) null,remark nvarchar(1000) null )
select @i=1, @fperiod=multek_zh.dbo.fx_getAddPeriod(@currentPeriod,@i)
while(@i <=13)
begin
	SELECT @SQL = 'ALTER TABLE #tmp_cemm ADD [' + convert(varchar(10),@fperiod) + '] float default 0.0',
	@i=@i+1,@fperiod=multek_zh.dbo.fx_getAddPeriod(@currentPeriod,@i)
	Exec (@SQL)	
end
insert into #tmp_cemm exec dbo.sp_gam_forecast_output
--alter table #tmp drop column [userName]

delete gam_CEM_mix_Sales_forecast_result where period=@currentPeriod

insert into gam_CEM_mix_Sales_forecast_result
select @currentPeriod as period,'CEM'as username,rtrim(oem) as cusOEM,rtrim(oem) as oemName,plant,cpn,ipn,
0 as cusASP,asp as expASP,iperiod as expASPPeriod,maxASP,minASP,ttlAMT,ttlQTY,ttlSQFT,layer,tech,surf,'' as remark,
p1,p2,p3,p4,p5,p6,
p6 as p7,p6 as p8,p6 as p9,p6 as p10,p6 as p11,p6 as p12, p6 as p13
from dbo.GAM_CEM_Forecast where period = @currentPeriod
union all
select @currentPeriod as period,* from #tmp_cemm

drop table #tmp_cemm


delete gam_CEM_mix_Sales_forecast_result
from gam_CEM_mix_Sales_forecast_result as a
join 
(	select distinct oemName,plant from gam_CEM_mix_Sales_forecast_result
	where period = @currentPeriod and userName = 'CEM'
) as b 
on a.oemName=b.oemName and userName <> 'CEM' 
where a.period=@currentPeriod and cpn not like '%]%]%]'
/*
select * from gam_CEM_mix_Sales_forecast_result where period=@currentPeriod
order by oemName,plant,cusOEM
*/

set nocount off


GO
