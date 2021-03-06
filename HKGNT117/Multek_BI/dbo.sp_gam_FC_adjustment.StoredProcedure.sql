USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_FC_adjustment]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_gam_FC_adjustment] 
@bySales bit =1
as

declare @startPeriod int,@endPeriod int
select @startPeriod=multek_zh.dbo.fx_getCurrentPeriod()
select @startPeriod = multek_zh.dbo.fx_getAddPeriod(@startPeriod,1),@endPeriod=multek_zh.dbo.fx_getAddPeriod(@startPeriod,2)

select iperiod from multek_zh.dbo.vw_CalenderLDP where iperiod between @startPeriod and @endPeriod
select OEMID,CusOEM,salesmanid,isnull(userName,'') as salesman,GroupName,isnull(fiscal_period,0) as fiscal_period,
isnull(fcst_id,0) as fcst_id,isnull(fcst_amt_SumByPart,0) as fcst_amt,isnull(fcst_amt,0) as adjust_amt,
reverse(cusOEM) as reveseOEM
into #adj
from vw_gam_OEMcomb left join gam_forecast on oemid=oem_id and fiscal_period between @startPeriod and @endPeriod
where isValid=1 order by userName,cusOEM,oemid

if(@bySales = 1)
	select oemid,cusOEM,salesman,fiscal_period,fcst_id,fcst_amt,adjust_amt from #adj order by salesman,cusOEM
else
begin
	select oemid,cusOEM,salesman = case when charindex(' ',reveseOEM) > 0 then 
		 upper(reverse(SUBSTRING (reveseOEM , 1 , charindex(' ',reveseOEM)-1))) 
	else 'unknow' end,
	fiscal_period,fcst_id,fcst_amt,adjust_amt into #x
	 from #adj 
	select * from #x order by salesman,cusOEM
	drop table #x
end
drop table #adj
GO
