USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_forecast_download_all]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[sp_gam_forecast_download_all] @isCurrent bit=0
as
set nocount on

/*
declare  @isCurrent bit
set @isCurrent=0
*/

declare 
	@currentPeriod int, 
	@fperiod int, 
	@i int,
	@sql nvarchar(max),@past3month int

select 
	@currentPeriod=multek_zh.dbo.fx_getCurrentPeriod(),
	@i=1,@fperiod=@currentPeriod,
	@past3month = multek_zh.dbo.fx_getAddPeriod(@currentperiod,-3)

if(@isCurrent=0)
begin
	select 
		@currentPeriod=multek_zh.dbo.fx_getAddPeriod(@currentperiod,1),
		@fperiod=@currentPeriod,
		@past3month = multek_zh.dbo.fx_getAddPeriod(@currentperiod,-3)
end

update gam_part_forecast 
	set asp=a.asp 
	from dbo.gam_customerPart_remark as a left join gam_part_forecast as b 
	on a.oem_id=b.oemid and project=part_no and a.asp<>b.asp 
	where period >= @currentPeriod

create table #tmp
(
	forecastPeriod int, cusPart nvarchar(255),
	forecastAmount int, userName nvarchar(255),
	OEMID int, cusOEM nvarchar(500),
	oemName nvarchar(500), plant nvarchar(10),
	item nvarchar(100) null, expASP float null,
	expASPperiod int null, cusASP float default(0),
	maxASP float null, minASP float null,
	layer nvarchar(10), tech nvarchar(100),
	surf nvarchar(100), ttlAmt  int null,
	ttlSqft float null, ttlQty int null
)

insert into #tmp
	exec sp_gam_itemsDetailForForecastDownload @currentPeriod


/*technoloy ASP*/
declare @tmp2 table 
(
	[OEM] nvarchar(100),
	plant nvarchar(10),
	[groupTech] nvarchar(100),
	ttlAmt int,
	ttlQty int,
	ttlSQFT decimal(18,3),
	ASP  decimal(18,3)
)
insert into @tmp2
select OEM,plant,'['+groupTech+']',sum(amount),sum(qty),sum(sqft),sum(sqft)
	from gam_itemsDetail 
	where iperiod between @past3month and @currentPeriod and groupTech <> 'UNKNOW' 
	group by OEM,plant,groupTech 
	order by oem,plant 
	
delete @tmp2 where ttlAmt=0 or ttlSQFT=0; 
update @tmp2 set asp = ttlamt/ttlsqft

update #tmp 
	set tech=groupTech,expASP=asp 
	from #tmp as a left join @tmp2 as b
	on OEM=oemName and a.plant=b.plant and charindex(groupTech,cusPart,2)> 0 
	where tech is null and groupTech is not null



declare @tmp3 table 
(
	[OEM] nvarchar(100),
	plant nvarchar(10),
	ttlAmt int,
	ttlQty int,
	ttlSQFT decimal(18,3),
	ASP  decimal(18,3)
)

/* OEM avg ASP*/
insert into @tmp3
select OEM,plant,sum(amount),sum(qty),sum(sqft),sum(sqft)
	from gam_itemsDetail 
	where iperiod between @past3month and @currentPeriod 
	group by OEM,plant order by oem,plant;
	
delete @tmp3 where ttlAMT=0 or ttlSQFT=0;
update @tmp3 set asp = ttlamt/ttlsqft;

update #tmp 
	set expasp=ASP 
	from #tmp as a left join @tmp3 as b 
	on oemName=oem and a.plant=b.plant 
	where expasp is null and ASP is not null

select oemid,userName,cusOEM,rtrim(oemName) as oemName,plant,cusPart,item,cusASP,expASP,expASPPeriod,maxASP,minASP,ttlAMT,ttlQty,ttlSQFT,layer,tech,surf,isnull(remark,'') as remark 
	into #template 
	from #tmp left join dbo.gam_customerPart_remark 
	on oemid=oem_id and cusPart=part_no 
	group by oemid,userName,cusOEM,oemName,plant,cusPart,item,cusASP,expASP,expASPPeriod,maxASP,minASP,ttlAMT,ttlQty,ttlSQFT,layer,tech,surf,remark

declare @period table (forecastPeriod int)
insert into @period
select distinct forecastPeriod from #tmp order by forecastPeriod

select @i=0
while exists (select 1 from @period)
begin
	select top 1 @fperiod = forecastPeriod,@i=@i+1 from @period
	if(@i > 13)
		break
	delete @period where forecastPeriod=@fperiod
	SELECT @SQL = 'ALTER TABLE #template ADD [' + convert(varchar(10),@fperiod) + '] float default 0.0'
	Exec (@SQL)
	select @sql = 'update #template set ['+ convert(varchar(10),@fperiod) +']=0; update #template set ['+ convert(varchar(10),@fperiod) +
		']=forecastAmount from #template as p left join '+
		'#tmp as t on p.oemid=t.oemid and p.cuspart=t.cuspart and isnull(p.item,0)=isnull(t.item,0) where t.forecastPeriod='+  convert(varchar(10),@fperiod)
	exec(@sql)
end
while(@i < 13)
begin
	select @i=@i+1,@fperiod=multek_zh.dbo.fx_getAddPeriod(@currentPeriod,@i),
	@SQL = 'ALTER TABLE #template ADD [' + convert(varchar(10),@fperiod) + '] float default 0.0'
	Exec (@SQL)
	select @sql= 'update #template set [' + convert(varchar(10),@fperiod) + '] =0'
	Exec (@SQL)
	
end

alter table #template drop column oemid
drop table #tmp

declare @c1 int
select @c1 = multek_zh.dbo.fx_getAddPeriod(@currentperiod,-1)
/* added on 2014-01-09 */
/* if getting next month result and CEM not yet uploaded */
/* return perious month CEM forecast result */
declare @RS table 
(
	userName nvarchar(100),
	cusOEM nvarchar(100),
	oemName nvarchar(100),
	plant nvarchar(10),
	cpn nvarchar(100),
	ipn nvarchar(100),
	cusASP decimal(18,3) default 0,
	expASP decimal(18,3) default 0,
	expASPPeriod int,
	maxASP decimal(18,3),
	minASP decimal(18,3),
	ttlAMT int,
	ttlQTY int,
	ttlSQFT decimal(18,3),
	layer nvarchar(10) null,
	tech nvarchar(100) null,
	surf nvarchar(100) null,
	remark nvarchar(1000) null,
	p1 decimal(18,3), p2 decimal(18,3), p3 decimal(18,3), p4 decimal(18,3),p5 decimal(18,3),
	p6 decimal(18,3), p7 decimal(18,3), p8 decimal(18,3), p9 decimal(18,3), p10 decimal(18,3), 
	p11 decimal(18,3), p12 decimal(18,3), p13 decimal(18,3)	
)
insert into @RS
select 'CEM'as username,rtrim(oem) as cusOEM,rtrim(oem) as oemName,plant,cpn,ipn,
0 as cusASP,asp as expASP,iperiod as expASPPeriod,maxASP,minASP,ttlAMT,ttlQTY,ttlSQFT,layer,tech,surf,'' as remark,
p1,p2,p3,p4,p5,p6,p6 as p7,p6 as p8,p6 as p9,p6 as p10,p6 as p11,p6 as p12, p6 as p13
from dbo.GAM_CEM_Forecast where period = @c1

if not exists(select 1 from GAM_CEM_Forecast where period = @c1) and @isCurrent=0
begin
	--select 'not yet upload this month cem!'
	select @c1 = multek_zh.dbo.fx_getAddPeriod(@c1,-1)
	delete @RS
	insert into @RS
	select 'CEM'as username,rtrim(oem) as cusOEM,rtrim(oem) as oemName,plant,cpn,ipn,
	0 as cusASP,asp as expASP,iperiod as expASPPeriod,maxASP,minASP,ttlAMT,ttlQTY,ttlSQFT,layer,tech,surf,'' as remark,
	p2,p3,p4,p5,p6,p6,p6 as p7,p6 as p8,p6 as p9,p6 as p10,p6 as p11,p6 as p12, p6 as p13
	from dbo.GAM_CEM_Forecast where period = @c1
end

select * into #tmpH from #template where 0=1

insert into @RS
select * from #template

drop table #template

delete @RS from @RS join [dbo].[gam_cem_oemName] on baanName=oemName where cpn not like '%]%]%]' and userName <> 'CEM'
select * into #tmpresult from @RS

select 
	@currentPeriod as forecastPeriod,
	cpn as cusPart,
	p1 as forecastAmt,
	userName,0 as oemid,cusOEM,oemName,plant,ipn as item,expASP,expASPPeriod,cusASP,maxASP,minASP,layer,tech,surf,ttlAMt,ttlSQFT,ttlQty,remark
	into #tmpV 
	from #tmpresult

select @i=1,@fperiod=@currentPeriod
while(@i <= 12)
begin
	select @fperiod=multek_zh.dbo.fx_getAddPeriod(@currentPeriod,@i), @i=@i+1
	select @sql = N'insert into #tmpV 
	select ' + cast(@fperiod as nchar(6)) +N' as forecastPeriod,cpn as cusPart,p'+ cast(@i as nchar(3)) +N' as forecastAmt,
	userName,0 as oemid,cusOEM,oemName,plant,ipn as item,expASP,expASPPeriod,cusASP,maxASP,minASP,layer,tech,surf,ttlAMt,ttlSQFT,ttlQty,remark
	from #tmpresult'
	exec sp_executesql @sql
end

select * from #tmpV order by forecastPeriod

select * from #tmpH
union all
select * from #tmpresult

drop table #tmpresult
drop table #tmpV
drop table #tmpH
set nocount off



GO
