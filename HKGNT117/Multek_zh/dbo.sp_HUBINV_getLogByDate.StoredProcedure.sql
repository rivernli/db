USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_HUBINV_getLogByDate]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



create procedure [dbo].[sp_HUBINV_getLogByDate]
	@isDateList bit,
	@startDate datetime,
	@endDate datetime
as

if(@isDateList=1)
begin
select * from vw_HUBINV_logByDate where convert(datetime,idate) between @startDate and @endDate;
end
else
begin
select convert(datetime,iDate) as dDate,iDate,count(uid) as nol from vw_HUBINV_logByDate 
where convert(datetime,idate) between @startDate and @endDate
group by iDate order by iDate desc;
end

GO
