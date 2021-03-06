USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_fusionChart_TotalFGOutSqft]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE procedure [dbo].[sp_fusionChart_TotalFGOutSqft]
@plant char(4) = ''
as
declare @endperiod int
declare @startPeriod int
select @endperiod = multek_zh.dbo.fx_getCurrentPeriod()
set @startPeriod = @endPeriod-100

if(@plant <> '')
begin
	if(@plant = 'P2')
		set @plant = 'B1'

select iperiod,plant,round(sum(sqft),0) as sum_sqft from (
select substring(fyear,3,4)+substring(period,2,2) as iperiod,plant,[shipmentArea(sqft)] as sqft 
from boc.dbo.CostDetail
) as vw_4RP_FGOut_sqft
where iperiod between @startPeriod and @endPeriod and plant=@plant
group by iperiod,plant order by iperiod,plant

/*
select iperiod,plant,round(sum(sqft),0) as sum_sqft from (
select substring(fyear,3,4)+substring(period,2,2) as iperiod,plant,[shipmentArea(sqft)] as sqft 
from multek_zh.dbo.EXR2_Details 
) as vw_4RP_FGOut_sqft
where iperiod between @startPeriod and @endPeriod and plant=@plant
group by iperiod,plant order by iperiod,plant
*/

/*
	select iperiod,plant,round(sum(sqft),0) as sum_sqft from multek_zh.dbo.vw_4RP_FGOut_sqft
	where iperiod between @startPeriod and @endPeriod and plant=@plant
	group by iperiod,plant
	order by iperiod,plant
*/
end
else
begin

select iperiod,plant,round(sum(sqft),0) as sum_sqft from (
select substring(fyear,3,4)+substring(period,2,2) as iperiod,plant,[shipmentArea(sqft)] as sqft 
from boc.dbo.CostDetail 
) as vw_4RP_FGOut_sqft
where iperiod between @startPeriod and @endPeriod 
group by iperiod,plant order by iperiod,plant

/*
select iperiod,plant,round(sum(sqft),0) as sum_sqft from (
select substring(fyear,3,4)+substring(period,2,2) as iperiod,plant,[shipmentArea(sqft)] as sqft from multek_zh.dbo.EXR2_Details 
) as vw_4RP_FGOut_sqft
where iperiod between @startPeriod and @endPeriod 
group by iperiod,plant order by iperiod,plant
*/
/*
	select iperiod,plant,round(sum(sqft),0) as sum_sqft from multek_zh.dbo.vw_4RP_FGOut_sqft
	where iperiod between @startPeriod and @endPeriod
	group by iperiod,plant
	order by iperiod,plant
*/
end



GO
