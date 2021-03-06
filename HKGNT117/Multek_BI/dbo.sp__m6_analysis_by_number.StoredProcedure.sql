USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp__m6_analysis_by_number]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp__m6_analysis_by_number] @n int
as
/*
declare @n int
set @n=3
*/
set nocount on

declare @nLastDrawnDate datetime, @lastResultDate datetime
declare @nTotalDrawn int, @resultTotalDrawn int, @nNotDrawnTime int

/* all number list */
select distinct number into #m6no from m6 order by number;
select distinct date into #m6date from m6 order by date desc;

/* result for @n */
select * into #tmp from m6 where number=@n order by date desc;

/* fetch to variable */
select top 1 @nLastDrawnDate=date from #tmp order by date desc;
select top 1 @lastResultDate=date from m6 order by date desc;

select @nNotDrawnTime=count(date) from #m6date where date between @nlastDrawnDate+1 and @lastResultDate;
select @nTotalDrawn=count(date)  from #tmp;
select @resultTotalDrawn=count(date) from #m6date;

/* display summary */
select @lastResultDate as last_result_date,
@nlastDrawnDate as N_last_draw_date,
@nNotDrawnTime as N_not_draw_time_from_last,
@nTotalDrawn as N_draw_time,
@resultTotalDrawn as total_draw_time,
round(cast(@nTotalDrawn as float)/cast(@resultTotalDrawn as float)*100,2) as N_draw_percentage


select #m6no.number,isnull(cnt,0) as cnt from #m6no left join 
(select m6.number,count(m6.number) as cnt from #tmp left join m6 on #tmp.date = m6.date group by m6.number) as m2
on m2.number = #m6no.number order by #m6no.number --where m2.number <> @n ;

select #m6date.date,CONVERT(varchar(6), #m6date.date, 112) as dd, case when number is null then 0 else 1 end as bingo into #timeF
from #m6date left join #tmp on #m6date.date = #tmp.date;

select dd,round(cast(sum(bingo) as float)/cast(count(bingo) as float)*100,2) as drawPerecntage,sum(bingo) as drawn,count(bingo) as total from #timeF group by dd order by dd desc
select * from #timeF

drop table #timeF
drop table #m6date
drop table #m6no
drop table #tmp
set nocount off
GO
