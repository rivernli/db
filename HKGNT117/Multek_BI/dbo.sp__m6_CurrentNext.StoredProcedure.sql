USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp__m6_CurrentNext]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp__m6_CurrentNext] @iDate datetime
as

/*
declare @iDate datetime
set @iDate = '2011-12-15'
*/
set nocount on
/* Declare variable */
declare @sql nvarchar(100), @base int, @target int, @date datetime, @date2 datetime, @n int, @col nvarchar(10);

/* create table for CURRENT NEXT */
CREATE TABLE #fb (number int default 0 not null);
set @n=0
while(@n<49)
begin
	select @n=@n+1,@col='n'+convert(varchar(10),@n);
	insert into #fb (number) values (@n)
	alter table #fb add cx int default (0) not null; exec tempdb..sp_rename '#fb.cx', @col, 'COLUMN';
end 

select top 1 @date=date from m6 order by date
select top 1 @date2=date from m6 where date > @date order by date

while not @date2 is null and @date2 < @iDate
begin
	select * into #fbo from (select number as base from m6 where date=@date and isSP=0) as a left join (select number as target from m6 where date=@date2 and isSP=0) as b on 1=1;
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

insert into #fb (number) values (convert(integer,convert(varchar(8),@iDate,112)));
select number into #tn from m6 where date = @iDate and isSp=0
if exists (select 1 from #tn)
begin
	insert into #fb (number) values (99);
	select * into #rs from #fb where number in(select number from m6 where date=@date and isSp=0) or number = convert(varchar(8),@iDate,112) or number = 99;

	declare @nSql nvarchar(4000)
	select @nsql=N'update #rs set number=0'
	set @n=0
	while(@n<49)
	begin
		select @n=@n+1, @sql = N'update #rs set n'+ convert(varchar(2),@n) +'=(select sum(n'+ convert(varchar(2),@n) +') as x from #rs) where number=99'
		set @nsql = @nsql + N'+n'+ convert(varchar(2),@n)
		--set @nsql=@nsql2
		execute dbo.sp_executesql @sql
	end 
	set @nsql = @nsql +N' where number=99'
	execute dbo.sp_executesql @nsql
	while exists (select 1 from #tn)
	begin
		select top 1 @target=number from #tn;delete #tn where number=@target;
		select @sql = N'update #rs set n'+ convert(varchar(2),@target) +'=1 where number='+convert(varchar(8),@iDate,112);
		execute dbo.sp_executesql @sql
	end
	select * from #rs order by number;
	drop table #rs
end
else
begin
	select * from #fb where number in(select number from m6 where date=@date and isSp=0)
end

drop table #fb
drop table #tn
set nocount off
GO
