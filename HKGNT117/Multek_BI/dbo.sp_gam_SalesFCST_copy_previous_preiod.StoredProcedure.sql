USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_SalesFCST_copy_previous_preiod]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[sp_gam_SalesFCST_copy_previous_preiod]( @sid int, @period int)
as
declare @lastPeriod int 
set nocount on
if(@period >= multek_zh.dbo.fx_PeriodAdd(multek_zh.[dbo].[fx_getPeriodDate](default),12))
begin
/******************************** **************/
/*** can only add for after next period 12   ***/
/***********************************************/
select @lastPeriod =multek_zh.dbo.fx_PeriodAdd(@period,-1)
--select 'copy from p11('+ cast(@lastPeriod as char(6)) +') to p12('+ cast(@period as char(6))+')'


/*makeing gam_part_forecate data*/
select period,a.oemid,project,amt,@sid as salesid into #tmp
from dbo.vw_gam_OEMcomb as a left join gam_part_forecast as b on a.oemid=b.oemid
where b.period = @lastPeriod and a.salesmanid=@sid and isValid=1 order by a.oemid

select isnull(sid,0) as sid,a.* into #tmp2 from #tmp as a left join gam_part_forecast as b 
on a.oemid=b.oemid and b.period=@period and a.project=b.project order by a.oemid 

drop table #tmp

-- insert into gam_part_forecast
insert into gam_part_forecast (period,oemid,project,amt,sqft,qty,isPart,asp,price,input_date,input_userId)
select @period,oemid,project,amt,0,0,1,0,0,getdate(),salesid from #tmp2 where sid=0

-- update gam_part_forecast
update gam_part_forecast set amt=b.amt,input_date=getdate() 
from gam_part_forecast as a join #tmp2 as b on a.sid=b.sid and a.project=b.project and a.oemid=b.oemid
where b.sid > 0

drop table #tmp2

exec sp_gam_forecat_ReCal_OEMPlantAmt_byPeriod_by_SalesId @period,@sid
/*
/*makeing gam_forecate data*/
select isnull(fcst_id,0) as fid,b.* into #tmp3 
from gam_forecast as a 
	right join 
		(select oemid,sum(amt) as tamt,@period as period from gam_part_forecast where period=@period group by oemid) as b
		on a.oem_id=b.oemid and a.fiscal_period=b.period
	left join 
		dbo.vw_gam_OEMcomb as c 
		on b.oemid=c.oemid
where c.salesmanid=@sid

--insert into gam_forecast
insert into gam_forecast (oem_id,fiscal_period,fcst_amt,actual_amt,inputed_by,user_type,fcst_amt_SumByPart)
select oemid,period,0,0,@sid,'n',tamt from #tmp3 where fid = 0
-- update gam_forecast
update gam_forecast set fcst_amt_SumByPart=b.tamt
from gam_forecast as a join #tmp3 as b on a.fcst_id=b.fid and a.oem_id=b.oemid and a.fiscal_period=b.period
where b.fid > 0
drop table #tmp3
*/
end

set nocount off

/*
delete gam_part_forecast where period = 201405 and oemid not in (428,427)
delete gam_forecast where fiscal_period=201405 and oem_id not in (428,427)
select * from gam_part_forecast where period = 201405 and oemid not in (428,427)
select * from gam_forecast where fiscal_period = 201405 and oem_id not in (428,427)
*/




GO
