USE [Multek_ZH_New]
GO
/****** Object:  StoredProcedure [dbo].[sp_sgp_rpt_time2go]    Script Date: 11/06/2014 15:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_sgp_rpt_time2go]
 @oem nvarchar(100)='',@project nvarchar(100)='',@rfq nvarchar(100)='',@salesman nvarchar(100)='', @state int=99
as
set nocount on

--select @oem='',@project='',@rfq='',@salesman='', @state=99
declare @sqlstr nvarchar(4000) 
select @sqlstr = 'select top 1000 * from vw_sgp_rpt_timeGoing where 1=1 '
+ dbo.fx_field2Value(case when @state = 99 then '' else  cast(@state as char(2)) end,'WFStatus',1) 
+ dbo.fx_field2Value(@salesman,'salesman',0) +
+ dbo.fx_field2Value(@project,'project',0) +
+ dbo.fx_field2Value(@rfq,'rfq',0) +
+ dbo.fx_field2Value(@oem,'oem',0) +
' order by adate desc'
exec(@sqlstr)

set nocount off
GO
