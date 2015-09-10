USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_ITApps_loganalyst]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[sp_ITApps_loganalyst]
@start int, @end int
as /*
set @start = 20110901
set @end = 20110931
*/
select convert(varchar(8),calenderDate,112) as date from multek_zh.dbo.vw_calender where convert(varchar(8),calenderDate,112) between @start and @end
select * from ITApps_LogAnalyst where logdate between @start and @end order by logdate,logtype
 

GO
