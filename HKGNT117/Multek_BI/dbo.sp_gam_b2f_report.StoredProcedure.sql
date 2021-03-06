USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_b2f_report]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[sp_gam_b2f_report] @up int =0, @msg nvarchar(200) output
as
set nocount on

select @msg = 'ok'

if(@up =0)
select @up=multek_zh.dbo.fx_getCurrentPeriod()

declare @period table (period int not null)
declare @tperiod int, @sql nvarchar(max)

select distinct oem,cpn,pn into #temp_oem_b2f  from dbo.GAM_B2F where uploadperiod = @up
insert into @period select distinct forecastperiod from dbo.GAM_B2F where uploadperiod = @up order by forecastperiod
if not exists (select 1 from #temp_oem_b2f)
begin
	select @msg = 'No record found'
	select * from #temp_oem_b2f
	return
end
	
while exists(select 1 from @period)
begin
	select top 1 @tperiod=period, @sql = N'alter table #temp_oem_b2f add '+
		'['+ convert(nchar(6), period) +'_sqft] decimal(18, 3) not null default 0, '+
		'['+ convert(nchar(6), period) +'_qty] int not null default 0, '+
		'['+ convert(nchar(6), period) +'_array] int not null default 0, '+
		'['+ convert(nchar(6), period) +'_smt] decimal(18, 3) not null default 0, '+
		'['+ convert(nchar(6), period) +'_fpc] decimal(18, 3) not null default 0, '+
		'['+ convert(nchar(6), period) +'_bom] decimal(18, 3) not null default 0 '
		from @period order by period
	delete @period where period=@tperiod
	exec(@sql)
	select @sql ='update #temp_oem_b2f set 
	['+ convert(nchar(6),@tperiod) +'_sqft]=b.sqft,
	['+ convert(nchar(6),@tperiod) +'_qty]=b.qty,
	['+ convert(nchar(6),@tperiod) +'_array]=b.array,
	['+ convert(nchar(6),@tperiod) +'_smt]=b.smtprice,
	['+ convert(nchar(6),@tperiod) +'_fpc]=b.fpcprice,
	['+ convert(nchar(6),@tperiod) +'_bom]=b.bomprice
	from #temp_oem_b2f as a left join GAM_B2F as b on 
	a.oem=b.oem and a.cpn=b.cpn and a.pn=b.pn
	where forecastperiod=@fcP and uploadperiod=@upP'
	execute sp_executesql @sql,N'@fcp int, @upP int',@fcp=@tperiod,@upP=@up
end
select * from #temp_oem_b2f
drop table #temp_oem_b2f
set nocount off
GO
