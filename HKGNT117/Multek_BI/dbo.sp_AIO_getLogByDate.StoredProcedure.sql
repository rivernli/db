USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_AIO_getLogByDate]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[sp_AIO_getLogByDate]
	@isDateList bit,
	@startDate datetime,
	@endDate datetime,
	@user nvarchar(50) = ''
as

if(@isDateList=1)
begin
	if(@user <>'')
		select * from vw_AIO_LogByDate where convert(datetime,idate) between @startDate and @endDate 
		and (uid like '%'+@user +'%' or userName like '%'+@user +'%')
		order by iDate desc,uid;
	else
		select * from vw_AIO_LogByDate where convert(datetime,idate) between @startDate and @endDate order by iDate desc,uid;
end
else
begin
	if(@user <>'')
		select convert(datetime,iDate) as dDate,iDate,count(uid) as nol from vw_AIO_LogByDate 
		where convert(datetime,idate) between @startDate and @endDate
		and (uid like '%'+@user +'%' or userName like '%'+@user +'%')
		group by iDate order by iDate desc;
	else
		select convert(datetime,iDate) as dDate,iDate,count(uid) as nol from vw_AIO_LogByDate 
		where convert(datetime,idate) between @startDate and @endDate
		group by iDate order by iDate desc;
end



GO
