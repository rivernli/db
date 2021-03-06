USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_forecat_ReCal_OEMPlantAmt_byPeriod]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_gam_forecat_ReCal_OEMPlantAmt_byPeriod] @period int
as

declare @cp int
select @cp=multek_zh.dbo.fx_getCurrentPeriod()
/*
2013-10-28
if(@period <= @cp)
	return
*/	
if(@period < @cp)
	return
	
	
set nocount on
	
DECLARE @tmp TABLE (oemid int,tamt int,period int, oemname nvarchar(100), plant nvarchar(10),salesid int)
declare @tmp3 table (fid int, oemid int,tamt int, period int,oemname nvarchar(100),plant nvarchar(10),salesid int)

insert into @tmp 
select b.oemid,tamt,period,c.oemname,c.plant,c.SalesmanId as salesid from 
	(select oemid,sum(amt) as tamt,@period as period from gam_part_forecast where period=@period group by oemid) as b
	left join dbo.vw_gam_OEMcomb as c on b.oemid=c.oemid

/*check if cem in #tmp table*/
select oemid into #ud from @tmp join gam_cem_oemName on oemname=gam_cem_oemName.baanName
declare @oid int,@tamt int
while exists (select 1 from #ud)
begin
	select top 1 @oid=oemid from #ud
	exec [sp_gam_forecastCustomerPart_Update_autoUpdateTotalAmount] @period,@oid,0,@tamt output
	update @tmp set tamt=@tamt where oemid=@oid
	delete #ud where oemid=@oid
end
drop table #ud

--select isnull(fcst_id,0) as fid,b.* into #tmp3 
insert into @tmp3
select isnull(fcst_id,0) as fid,b.* 
from gam_forecast as a right join @tmp as b on a.oem_id=b.oemid and a.fiscal_period=b.period
--drop table @tmp

--insert into gam_forecast
insert into gam_forecast (oem_id,fiscal_period,fcst_amt,actual_amt,inputed_by,user_type,fcst_amt_SumByPart)
select oemid,period,0,0,salesid,'n',tamt from @tmp3 where fid = 0
-- update gam_forecast
update gam_forecast set fcst_amt_SumByPart=b.tamt
from gam_forecast as a join @tmp3 as b 
on a.fcst_id=b.fid and a.oem_id=b.oemid and a.fiscal_period=b.period and a.fcst_amt_SumByPart <> b.tamt
where b.fid > 0

--drop table #tmp3

set nocount off
GO
