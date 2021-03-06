USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp__m6_CurrentNext_buildTable]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[sp__m6_CurrentNext_buildTable]
as
set nocount on
/* Declare variable */
declare @sql nvarchar(4000), @base int, @target int, @date datetime, @date2 datetime, @n int, @col nvarchar(10);
declare @nSql nvarchar(4000)

CREATE TABLE #fb (keyDate int default(0) null, keyType varchar(10) null, number int default (0) not null);
CREATE TABLE #rs (keyDate int default(0) null, keyType varchar(10) null, number int default (0) not null);
set @n=0
while(@n<49)
begin
	select @n=@n+1,@col='n'+convert(varchar(10),@n);
	insert into #fb (keyType,number) values ('num',@n)
	alter table #fb add cx int default (0) not null; 
	exec tempdb..sp_rename '#fb.cx', @col, 'COLUMN';

	alter table #rs add cx int default (0) not null; 
	exec tempdb..sp_rename '#rs.cx', @col, 'COLUMN';
end 
insert into #fb (keyDate,keyType,number) values (0,'numSum',0);
insert into #fb (keyDate,keyType,number) values (0,'result',0);

/* start from long time ago */
select top 1 @date=date from m6 order by date; select top 1 @date2=date from m6 where date > @date order by date
while not @date2 is null 
begin
	update #fb set keyDate=Convert(varchar(8),@date2,112) where keyType in ('numSum','result')
		
	/*update #fb table*/
	/*
	select * into #fbo from (select number as base from m6 where date=@date and isSP=0) as a left join (select number as target from m6 where date=@date2 and isSP=0) as b on 1=1;
	select top 1 @base=base,@target=target from #fbo order by base, target
	while exists (select 1 from #fbo)
	begin
		select @sql= N'update #fb set n'+ convert(varchar(2),@target) +'=n'+ convert(varchar(2),@target) +'+1 where number='+ convert(varchar(2),@base)
		execute dbo.sp_executesql @sql
		delete #fbo where base=@base and target=@target
		select top 1 @base=base,@target=target from #fbo order by base, target
	end
	drop table #fbo
	*/
	/*end of update #fb table*/

	/*update #rs*/
	select number into #tn from m6 where date = @date2 and isSp=0
	if exists (select 1 from #tn)
	begin
		/*collect number from #fb*/
		insert into #rs select * from #fb where number in(select number from m6 where date=@date and isSp=0) or keyType in ('numSum','result');
		update #rs set keyDate=Convert(varchar(8),@date2,112) where keyDate=0
		select @nsql=N'update #rs set number=0'
		set @n=0
		while(@n<49)
		begin
			select @n=@n+1, @sql = N'update #rs set n'+ convert(varchar(2),@n) +'=(select sum(n'+ convert(varchar(2),@n) +') as x from #rs where keyType=''num'' and keyDate='+Convert(varchar(8),@date2,112)+') where keyType=''numSum'' and keyDate='+Convert(varchar(8),@date2,112)
			set @nsql = @nsql + N'+n'+ convert(varchar(2),@n)
			execute dbo.sp_executesql @sql
		end 
		set @nsql = @nsql +N' where keyType=''numSum'' and keyDate='+Convert(varchar(8),@date2,112)
		execute dbo.sp_executesql @nsql

		while exists (select 1 from #tn)
		begin
			select top 1 @target=number from #tn;delete #tn where number=@target;
			select @sql = N'update #rs set n'+ convert(varchar(2),@target) +'='+convert(varchar(2),@target) +' where keyType=''result'' and keyDate='+convert(varchar(8),@Date2,112);
			execute dbo.sp_executesql @sql
		end
	end
	drop table #tn
	/*end of update #rs*/

	/*update #fb table*/
	select * into #fbo from (select number as base from m6 where date=@date and isSP=0) as a left join (select number as target from m6 where date=@date2 and isSP=0) as b on 1=1;
	select top 1 @base=base,@target=target from #fbo order by base, target
	while exists (select 1 from #fbo)
	begin
		select @sql= N'update #fb set n'+ convert(varchar(2),@target) +'=n'+ convert(varchar(2),@target) +'+1 where number='+ convert(varchar(2),@base)
		execute dbo.sp_executesql @sql
		delete #fbo where base=@base and target=@target
		select top 1 @base=base,@target=target from #fbo order by base, target
	end
	drop table #fbo
	/*end of update #fb table*/

	/*perpare for next draw date*/
	select @date=@date2
	if exists (select 1 from m6 where date > @date)
		select top 1 @date2=date from m6 where date > @date order by date
	else
		set @date2 = null
	/*end of perpare for next draw date*/
end 

--select * from #rs where keyDate=20101111
if exists (select 1 from sysobjects where name = 'm6_currentNext')
	drop table m6_currentNext
select * into m6_currentNext from #rs
drop table #rs
drop table #fb
set nocount off



GO
