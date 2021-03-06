USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp__m6_anaylsis__currnet_perious]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
exec sp__addM6 '2-Nov-2010',5,	17,	24	,25,	36,	45, 15
*/

CREATE procedure [dbo].[sp__m6_anaylsis__currnet_perious]
as
set nocount on
declare @n int, @col nvarchar(10); set @n=0
CREATE TABLE #fb (number int default 0 not null)
while(@n<49)
begin
	select @n=@n+1,@col='n'+convert(varchar(10),@n)
	insert into #fb (number) values (@n)
	alter table #fb add cx int default 0 not null;
	exec tempdb..sp_rename '#fb.cx', @col, 'COLUMN'
end 

declare @sql nvarchar(100), @base int, @target int, @date datetime, @date2 datetime
select top 1 @date=date from m6 order by date
select top 1 @date2=date from m6 where date > @date order by date

while not @date2 is null
begin
	select * into #fbo from (select number as base from m6 where date=@date and isSP=0) as a left join (select number as target from m6 where date=@date2 and isSP=0) as b on 1=1
	select top 1 @base=base,@target=target from #fbo order by base, target
	while exists (select 1 from #fbo)
	begin
		select @sql= N'update #fb set n'+ convert(varchar(2),@target) +'=n'+ convert(varchar(2),@target) +'+1 where number='+ convert(varchar(2),@base)
		execute dbo.sp_executesql @sql
		delete #fbo where base=@base and target=@target
		select top 1 @base=base,@target=target from #fbo order by base, target
	end

	select @date=@date2
	if exists (select 1 from m6 where date > @date)
		select top 1 @date2=date from m6 where date > @date order by date
	else
		set @date2 = null
	drop table #fbo
end 
select * from #fb where number in(select number from m6 where date=@date and isSp=0)

drop table #fb
set nocount off
GO
