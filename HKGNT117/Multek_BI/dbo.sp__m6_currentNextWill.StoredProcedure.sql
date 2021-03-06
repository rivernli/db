USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp__m6_currentNextWill]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp__m6_currentNextWill]
as

declare @n int
declare @d datetime,@i int,@d2 datetime,@str nvarchar(500), @col nvarchar(10);

set nocount on

CREATE TABLE #tt (number int default 0 not null);
set @n=0
while(@n<49)
begin
	select @n=@n+1,@col='n'+convert(varchar(10),@n);
	insert into #tt (number) values (@n)
	alter table #tt add cx int default (0) not null;
	exec tempdb..sp_rename '#tt.cx', @col, 'COLUMN';
end 
select @n=0
while(@n<49)
begin
	select @n=@n+1
	select date into #t from m6 where number=@n
	select top 1 @d=date from #t
	while exists (select 1 from #t)
	begin
		select @str = N'update #tt set number='+ convert(nvarchar(10),@n)
		select top 7 @str = @str +',n'+ convert(nvarchar(10),number)+'=n'+ convert(nvarchar(10),number) +'+1' from m6 where date > @d order by date
		--select @d,@str +' where number='+ convert(nvarchar(2),@n)
		select @str = @str +' where number= '+ convert(nvarchar(10),@n)
		execute dbo.sp_executesql @str
		delete #t where date=@d
		select top 1 @d=date from #t
	end
	drop table #t
end
select * from #tt
drop table #tt

set nocount off
GO
