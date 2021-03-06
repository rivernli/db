USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp__m7_analysis]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[sp__m7_analysis]
as

set nocount on
declare @resultTotalDrawn int
declare @lastDraw datetime
/* all number list */
select distinct date into #m6date from m6 order by date desc;
select @resultTotalDrawn=count(date) from #m6date;
select top 1 @lastDraw=date from #m6date order by date desc;

declare @n int; set @n=0
CREATE TABLE #rs (t int default 0 not null,percentage float default 0 not null, number int not null default 0,
lastTimeDisplay datetime null, timeGap int)
while(@n<49)
begin
	select @n=@n+1;insert into #rs (number) values (@n)
end 
/*
update #rs set t=tt,percentage=pp from 
(select count(number) as tt, round(cast(count(number) as float)/cast(@resultTotalDrawn as float)*100,2) as pp,number as nn from m6 group by number)
 as x where  nn = number
*/
select dd,count(dd) as ddN into #rsM from (select CONVERT(varchar(6),date,112) as dd from #m6date) as zz group by dd order by dd desc

declare @col varchar(10)
declare @nDate datetime
set @n=0
declare @nn int
while(@n<49)
begin
	select @n=@n+1,@col='n'+convert(varchar(10),@n)
	ALTER TABLE #rs ADD cx int default 0 not null;
	update #rs set cx=isnull(cnt1,0) from #rs left join (
	select number as num1,count(number) as cnt1 from m6 where date in (select date from m6 where number=@n) group by number
	) as rs on number=num1;

	select top 1 @nDate=date from m6 where number=@n order by date desc
	update #rs set t=cx, percentage=round(cast(cx as float)/cast(@resultTotalDrawn as float)*100,2),lastTimeDisplay=@nDate,timeGap=nx
	from (select count(date) as nx from #m6date where date between @nDate+1 and @lastDraw) as hqs,#rs
	where number=@n
	exec tempdb..sp_rename '#rs.cx', @col, 'COLUMN'

	alter table #rsM add tx int default 0 not null
	update #rsM set tx=isnull(ddN2,0) from 
	(select dd as dd2,count(dd) as ddN2 from (select Convert(varchar(6),date,112) as dd from m6 where number=@n) as d2 group by dd)
	as t2 where dd2=dd
	exec tempdb..sp_rename '#rsM.tx',@col,'Column'

	alter table #m6date add dx int default 0 not null;
	update #m6date set dx=@n
	from m6 where #m6date.date=m6.date and number=@n;
	exec tempdb..sp_rename '#m6date.dx',@col,'column'

end

/* display relation */
select * from #rs
drop table #rs

/* display month drawn */
select * from #rsM
drop table #rsM

select * from #m6date
drop table #m6date
set nocount off



GO
