USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp__m6_CurrentNextStepByStep]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[sp__m6_CurrentNextStepByStep]
as
declare @n int
declare @d datetime,@startD datetime,@str nvarchar(500), @col nvarchar(10),@sql nvarchar(max)

set nocount on
select @startD='2013-08-01'

/*create historical data table*/
CREATE TABLE #tt (R nvarchar(50) null,number int default 0 not null);
set @n=0
while(@n<49)
begin
	select @n=@n+1,@col='n'+convert(varchar(10),@n);
	insert into #tt (number) values (@n)
	alter table #tt add cx int default (0) not null;
	exec tempdb..sp_rename '#tt.cx', @col, 'COLUMN';
end 
/* end */
select * into #t2 from #tt where 1=0;
alter table #tt drop column R;

select @n=0
while(@n<49)
begin
	select @n=@n+1
	select date into #t from m6 where number=@n and date < @startD
	select top 1 @d=date from #t
	while exists (select 1 from #t)
	begin
		select @str = N'update #tt set number='+ convert(nvarchar(10),@n)
		select top 7 @str = @str +',n'+ convert(nvarchar(10),number)+'=n'+ convert(nvarchar(10),number) +'+1' from m6 where date > @d order by date
		select @str = @str +' where number= '+ convert(nvarchar(10),@n)
		execute dbo.sp_executesql @str
		delete #t where date=@d
		select top 1 @d=date from #t
	end
	drop table #t
end


select distinct date into #d from m6 where date >=@startD order by date
while exists(select 1 from #d)
begin
	select top 1 @d=date from #d order by date
	delete #d where date=@d
	
	select number into #number from m6 where date=@d
	
	insert into #t2 
	select convert(nvarchar(10),@d,102) as R,#tt.* from #tt right join #number on #tt.number=#number.number
	
	insert into #t2
	select convert(nvarchar(10),@d,102),999
	,0,0,0,0,0,0,0	,0,0,0,0,0,0,0	,0,0,0,0,0,0,0	,0,0,0,0,0,0,0
	,0,0,0,0,0,0,0	,0,0,0,0,0,0,0	,0,0,0,0,0,0,0
	insert into #t2
	select convert(nvarchar(10),@d,102),888
	,sum(n1),sum(n2),sum(n3),sum(n4),sum(n5),sum(n6),sum(n7),sum(n8),sum(n9),sum(n10)
	,sum(n11),sum(n12),sum(n13),sum(n14),sum(n15),sum(n16),sum(n17),sum(n18),sum(n19),sum(n20)
	,sum(n21),sum(n22),sum(n23),sum(n24),sum(n25),sum(n26),sum(n27),sum(n28),sum(n29),sum(n30)
	,sum(n31),sum(n32),sum(n33),sum(n34),sum(n35),sum(n36),sum(n37),sum(n38),sum(n39),sum(n40)
	,sum(n41),sum(n32),sum(n43),sum(n44),sum(n45),sum(n46),sum(n47),sum(n48),sum(n49)
	from #t2 where R=convert(nvarchar(10),@d,102)

	select @str = N'update #tt set number=$$ ',@sql=''
	select @str = @str +',n'+ convert(nvarchar(10),number)+'=n'+ convert(nvarchar(10),number) +'+1' 
	from m6 where date =(select top 1 date from #d order by date)

	while exists(select 1 from #number)
	begin
		select top 1 @n=number from #number
		delete #number where number=@n
		
		if @startD=@d 
			select @sql= replace(@str,'$$',convert(nvarchar(10),@n))+' where number='+convert(nvarchar(10),@n)
		else
			select @sql= replace(@str,'$$',convert(nvarchar(10),@n))+' where number='+convert(nvarchar(10),@n)+
			'; update #t2 set n'+convert(nvarchar(10),@n) +'='+convert(nvarchar(10),@n) +' where number=999 and R='''+ 
			convert(nvarchar(10),@startD,102)+''''
		execute dbo.sp_executesql @sql
	end
	drop table #number	
	select @startD=@d
end
drop table #d
--select * from #t2 where number=999

select * from #t2 order by R desc,number;
drop table #tt
drop table #t2

set nocount off



GO
