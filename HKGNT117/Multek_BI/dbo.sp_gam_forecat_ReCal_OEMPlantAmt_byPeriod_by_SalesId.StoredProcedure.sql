USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_forecat_ReCal_OEMPlantAmt_byPeriod_by_SalesId]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[sp_gam_forecat_ReCal_OEMPlantAmt_byPeriod_by_SalesId] 
@period int,@sid int
as
set nocount on
select b.*,c.oemname,plant into #tmp from 
	(select oemid,sum(amt) as tamt,@period as period from gam_part_forecast where period=@period group by oemid) as b
	left join dbo.vw_gam_OEMcomb as c on b.oemid=c.oemid where c.salesmanid=@sid
/*check if cem in #tmp table*/
select oemid into #ud from #tmp join gam_cem_oemName on oemname=baanName
declare @oid int,@tamt int
while exists (select 1 from #ud)
begin
	select top 1 @oid=oemid from #ud
	exec [sp_gam_forecastCustomerPart_Update_autoUpdateTotalAmount] @period,@oid,0,@tamt output
	update #tmp set tamt=@tamt where oemid=@oid
	delete #ud where oemid=@oid
end
drop table #ud

select isnull(fcst_id,0) as fid,b.* into #tmp3 
from gam_forecast as a 	right join #tmp as b on a.oem_id=b.oemid and a.fiscal_period=b.period
drop table #tmp

--insert into gam_forecast
insert into gam_forecast (oem_id,fiscal_period,fcst_amt,actual_amt,inputed_by,user_type,fcst_amt_SumByPart)
select oemid,period,0,0,@sid,'n',tamt from #tmp3 where fid = 0
-- update gam_forecast
update gam_forecast set fcst_amt_SumByPart=b.tamt
from gam_forecast as a join #tmp3 as b on a.fcst_id=b.fid and a.oem_id=b.oemid and a.fiscal_period=b.period
where b.fid > 0
drop table #tmp3
set nocount off
GO
