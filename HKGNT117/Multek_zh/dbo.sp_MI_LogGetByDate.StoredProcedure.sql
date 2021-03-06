USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MI_LogGetByDate]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



create PROCEDURE [dbo].[sp_MI_LogGetByDate]
	@isDateList bit,
	@startDate datetime,
	@endDate datetime
as

if(@isDateList=1)
begin
select * from vw_MI_logByDate where convert(datetime,idate) between @startDate and @endDate;
end
else
begin
select convert(datetime,iDate) as dDate,iDate,count(uid) as nol from vw_MI_logByDate 
where convert(datetime,idate) between @startDate and @endDate
group by iDate order by iDate desc;
end


GO
