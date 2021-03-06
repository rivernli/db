USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp__m6_analysis_number]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--exec sp__m6_anaylsis_number 6,'2011-12-20',50
CREATE procedure [dbo].[sp__m6_analysis_number]
@n int, @lastD datetime,@top int = 50
as

set nocount on
/*
declare @n int, @lastD datetime, @top int,@sql nvarchar(4000)
set @n=49
set @lastD = '2011-12-18'
set @top = 50
*/
declare @sql nvarchar(4000)

CREATE TABLE #m6date (date datetime not null);
set @sql = 'insert into #m6date (date) select distinct date from m6 where Convert(varchar(8),date,112)  <= '''+ Convert(varchar(8),@lastD,112) +''' order by date desc';
if(@top > 0)
	set @sql = 'insert into #m6date (date) select distinct top '+ Convert(varchar(10),@top) +' date from m6 where Convert(varchar(8),date,112)  <= '''+ Convert(varchar(8),@lastD,112) +''' order by date desc';
execute(@sql)

select m6.* into #m6 from #m6date left join m6 on #m6date.date=m6.date where isSp=0
declare @bingo int, @lastDraw datetime,@firstDraw datetime, @timeGap int

select convert(varchar(8),dd.date,112) as dx,number into #sameWhenN from #m6 right join (select date from #m6 where number=@n) as dd on dd.date = #m6.date
select * from #sameWhenN

select @bingo=count(number),@lastDraw=max(dx),@firstDraw=min(dx) from #sameWhenN where number=@n group by number
--select @bingo=count(number),@lastDraw=max(date),@firstDraw=min(date) from #m6 where number=@n group by number
select @timeGap =count(date) from #m6date where date > @lastDraw

select count(date) as totalDraw,convert(varchar(8),max(date),112) as lastDate ,convert(varchar(8),min(date),112) as startFrom,@bingo as bingo,
convert(varchar(8),@lastDraw,112) as lastDraw,convert(varchar(8),@firstDraw,112) as firstDraw,@timeGap as timeGap from #m6date


select number,count(number) as drawTogether,max(dx) as lastTogether,min(dx) as firstTogether from #sameWhenN
group by number order by number

drop table #sameWhenN
drop table #m6
drop table #m6date
set nocount off


GO
