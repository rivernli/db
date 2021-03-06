USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[del_sp_gam_ForecastCursorAllData_getBySalesId]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[del_sp_gam_ForecastCursorAllData_getBySalesId]
@startPeriod int,
@endPeriod int,
@salesman int
as 

IF object_id('tempdb..#temp_fcst') IS NOT NULL
	drop table #temp_fcst

DECLARE @iperiod int 

DECLARE db_cursor CURSOR FOR select iperiod from multek_zh.dbo.vw_CalenderLDP where iperiod between @startPeriod and @endPeriod

OPEN db_cursor   
FETCH NEXT FROM db_cursor INTO @iperiod   
if @@FETCH_STATUS = 0

select @iperiod as iperiod,oemid,cusoem,isnull(fcst_id,0) as fcst_id,isnull(fcst_amt,0) as fcst_amt,isnull(actual_amt,0) as actual_amt
into #temp_fcst from gam_oem left join gam_forecast on oemid = oem_id and fiscal_period = @iperiod
where salesmanid = @salesman

FETCH NEXT FROM db_cursor INTO @iperiod   
WHILE @@FETCH_STATUS = 0   
BEGIN   
		insert into #temp_fcst
		select @iperiod as iperiod,oemid,cusoem,isnull(fcst_id,0) as fcst_id,isnull(fcst_amt,0) as fcst_amt,isnull(actual_amt,0) as actual_amt
		from gam_oem left join gam_forecast on oemid = oem_id and fiscal_period = @iperiod
		where salesmanid = @salesman
		FETCH NEXT FROM db_cursor INTO @iperiod      
END   

CLOSE db_cursor   
DEALLOCATE db_cursor

select * from #temp_fcst order by iperiod
/*
-- use pivot..
select oemid,[201101],[201102],[201103]
from (select oemid,iperiod,fcst_amt from #temp_fcst) ps
pivot (sum(fcst_amt) for iperiod in ([201101],[201102],[201103])) as pvt
*/
drop table #temp_fcst

GO
