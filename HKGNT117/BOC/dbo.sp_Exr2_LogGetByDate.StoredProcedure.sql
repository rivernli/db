USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[sp_Exr2_LogGetByDate]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_Exr2_LogGetByDate]
	@isDateList bit,
	@startDate datetime,
	@endDate datetime
as

if(@isDateList=1)
begin
select * from [vw_Exr2_logByDate] where convert(datetime,idate) between @startDate and @endDate;
end
else
begin
select convert(datetime,iDate) as dDate,iDate,count(uid) as nol from vw_Exr2_logByDate 
where convert(datetime,idate) between @startDate and @endDate
group by iDate order by iDate desc;
end

GO
