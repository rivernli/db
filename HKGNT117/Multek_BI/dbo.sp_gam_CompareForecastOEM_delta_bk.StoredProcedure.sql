USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_CompareForecastOEM_delta_bk]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
declare @basePeriod int, @comparePeriod int, @message nvarchar(max)
select @basePeriod=0,@comparePeriod=0
*/

create procedure [dbo].[sp_gam_CompareForecastOEM_delta_bk] @basePeriod int =0, @comparePeriod int=0, @message nvarchar(max) output
as


set nocount on
/**** prepare data and variables ****/
declare 
	@baseStartPeriod int, @baseStartQuarter int,
	@compareStartPeriod int, @compareStartQuarter int,
	@currentPeriod int,@currentDisplayPeriod nvarchar(7)
select 
	@currentPeriod=multek_zh.[dbo].[fx_getPeriodDate](default),
	@currentDisplayPeriod=dbo.fx_period2String(@currentPeriod,'P')
	
select 0 as oem_id,0 as fiscal_quarter,0 as AMT,0 as OLS, 0 as TS, 0 as ActualLoad into #baseData where 1=0
select oem_id,fiscal_quarter,amt,ols,ts into #compareData from #baseData 
/**** end of prepare data and variables ****/

select @message = 'Current Period: '+@currentDisplayPeriod +'.\n '
if(@basePeriod=0)
	select @baseperiod=@currentPeriod
	
if(@comparePeriod >= @basePeriod)
begin
	select 
		@message = @message +'Compare Period cannot greater equal to Base Period. system set Compare Period to Base Period - 1.\n ',
		@comparePeriod=0
end


/**** MAKE BASE DATA ****/
/*	1: making base data for compare. */
/*	1.1 validate @basePeriod */
if(@basePeriod > @currentPeriod)
begin
	select 
		@message = @message + 'Base Period cannot greater then Current Period '+ @currentDisplayPeriod +
		'. system set base period to Current Period.\n ',
		@basePeriod=@currentPeriod
end

/*	1.2 if @basePeriod = current period */
if(@basePeriod=@currentPeriod)
begin
	/*	1.2.1.1 making baseStart variables for current data. */
	select 
		@baseStartQuarter = [dbo].[fx_period2Quarter](@currentPeriod),
		@baseStartPeriod = @basePeriod,
		@message = @message +'Base data [Master data] start from '+ 
		@currentDisplayPeriod +	'('+ dbo.fx_period2String(@baseStartQuarter,'Q') +').\n '
	
	/*	1.2.1.2 create data from master data start from base Quarter. that already include actual and loading data. */
	insert into #baseData
	select oem_id,fiscal_quarter,sum(amt),sum(ols),sum(topside),sum(actuLoad) from vw_gam_forecast_OEM 
	where fiscal_quarter>=@baseStartQuarter
	group by  oem_id,fiscal_quarter
end
else
begin
	/*	1.2.2.1 making baseStart variables for log data */
	select 
		@baseStartPeriod = multek_zh.dbo.fx_getAddPeriod(@basePeriod,1),
		@baseStartQuarter = [dbo].[fx_period2Quarter](@baseStartPeriod),
		@message = @message +'Base data [Log Data] log at ' + dbo.fx_period2String(@basePeriod,'P')+
		' start from '+ dbo.fx_period2String(@baseStartPeriod,'P')+'('+ dbo.fx_period2String(@baseStartQuarter,'Q')+').\n '
	
	/*	1.2.2.2 create data from log data logged period equal to BASE PERIOD (it will started from BASE START QUARTER).
		and getting master data that before or equal to BASE PERIOD and same BASE START QUARTER */
	insert into #baseData
	select oem_id,fiscal_quarter,sum(AMT) as amt,sum(ols) as OLS, sum(topside) as TS, 0 from 
	(
		select oem_id,fiscal_quarter,amt,ols,topside from vw_gam_forecast_OEM_log where logPeriod=@basePeriod
		union all
		select oem_id,fiscal_quarter,amt,ols,topside from vw_gam_forecast_OEM where fiscal_period<=@basePeriod and fiscal_quarter=@baseStartQuarter
	)
	as FC group by oem_id,fiscal_quarter
	
	/*	1.2.2.3 update Actual/Loading Data from master data */
	update #baseData set actualLoad=act from #baseData as a left join 
	(select oem_id,fiscal_quarter,sum(actuLoad) as act from vw_gam_forecast_OEM 
	where fiscal_quarter>=@baseStartQuarter group by oem_id,fiscal_quarter)
	as b on a.oem_id=b.oem_id and a.fiscal_quarter=b.fiscal_quarter
	
end
/**** END OF MAKE BASE DATA ****/


/**** MAKE COMPARE DATA ****/
/*	2: making compare data */
/*	2.1 validate @comparePeriod */
if(@comparePeriod = 0 or @comparePeriod >= @basePeriod)
	set @comparePeriod= multek_zh.dbo.fx_getAddPeriod(@basePeriod,-1)

/*	2.2 making compareStart variables for compare log data */
select 	
	@compareStartPeriod = multek_zh.dbo.fx_getAddPeriod(@comparePeriod,1),
	@compareStartQuarter = [dbo].[fx_period2Quarter](@compareStartPeriod),
	@message=@message + 'Compare Data [Log Data] log at ' + dbo.fx_period2String(@comparePeriod,'P')+
		' start from '+ dbo.fx_period2String(@compareStartPeriod,'P')+'('+ dbo.fx_period2String(@compareStartQuarter,'Q')+
		'), Base vs Compare data display started from '+ dbo.fx_period2String(@baseStartQuarter,'Q')+'.\n '

/*	2.3 create data from log data Logged period=COMPARE PERIOD (it will started from COMPARE QUARTER).
	and quarter greater equal BASE START QUARTER. 
	and getting master data that before COMPARE PERIOD and same BASE START QUARTER.	*/
insert into #compareData
select oem_id,fiscal_quarter,sum(AMT) as amt,sum(ols) as OLS, sum(topside) as TS from 
(
	select oem_id,fiscal_quarter,amt,ols,topside from vw_gam_forecast_OEM_log where logperiod=@comparePeriod and fiscal_quarter>=@baseStartQuarter
	union all
	select oem_id,fiscal_quarter,amt,ols,topside from vw_gam_forecast_OEM where fiscal_period<=@comparePeriod and fiscal_quarter=@baseStartQuarter
)
as FC group by oem_id,fiscal_quarter
/**** END OF MAKE COMPARE DATA ****/


/*	3:PREPARE DISPLAY DATA */
/*	3.1 create OEM table from baseData and compareData. */
select oemid,cusOEM,oemName,plant,existsOEM = case when plant is null then 0 else 1 end into #base from 
(select distinct oem_id from 
		(select oem_id from #baseData union all select oem_id from #compareData) as h
) as b left join dbo.vw_gam_OEMcomb on oem_id=oemid where isValid=1


/*	3.1.1 update plant where null*/
--update #base set plant = reverse(left(reverse(cusOEM),charindex(' ',reverse(cusOEM))-1)) where plant is null
update #base set plant = reverse(left(reverse(cusOEM),charindex(' ',reverse(cusOEM))-1)) where existsOEM = 0
update #base set oemName=rtrim(replace(cusOEM,plant,'')) where existsOEM=0
update #base set plant = 'HK' where plant='VVI'

select distinct plant into #basePlant from #base

select distinct OEMName into #baseOEM from #base

/*	3.2 Collect Quarter from baseData and compareData Only 5 Quarter will be displayed */
select top 5 fiscal_quarter into #Q from (select fiscal_quarter from #baseData union all select fiscal_quarter from #compareData) as h2 
group by  fiscal_quarter order by fiscal_quarter

/*	3.3 prepare variables for display and working */
declare @tempQuarter int,@sql nvarchar(max),@sqlplant nvarchar(max), @sqlOem nvarchar(max),
@displayQuarter nvarchar(7),@baseDisplayPeriod nvarchar(7),@compareDisplayPeriod nvarchar(7)

select 
	@baseDisplayPeriod=dbo.fx_period2String(@basePeriod,'P'),
	@compareDisplayPeriod=dbo.fx_period2String(@comparePeriod,'P')

/*	3.4 Loop the QUARTER table*/
while( exists (select 1 from #Q))
begin
	/*	3.4.1 alter #base table to adding forecase data columns */
	select top 1 @tempQuarter=fiscal_quarter,@displayQuarter=left(fiscal_quarter,4)+'Q'+right(fiscal_quarter,2),
	@sql=N'ALTER TABLE #base 
	ADD [' + @displayQuarter +'_ActualLoad] int default 0,
	[' + @displayQuarter + '_FC_'+ @baseDisplayPeriod +'] int default 0,
	[' + @displayQuarter + '_FC_'+ @compareDisplayPeriod +'] int default 0,
	[' + @displayQuarter + '_Var] int default 0,
	[' + @displayQuarter + '_VarP] decimal(18, 4) default 0',
	@sqlplant=N'alter table #basePlant 
	ADD [' + @displayQuarter +'_ActualLoad] int default 0,
	[' + @displayQuarter + '_FC_'+ @baseDisplayPeriod +'] int default 0,
	[' + @displayQuarter + '_FC_'+ @compareDisplayPeriod +'] int default 0,
	[' + @displayQuarter + '_Var] int default 0,
	[' + @displayQuarter + '_VarP] decimal(18, 4) default 0',
	@sqlOEM=N'alter table #baseOEM
	ADD [' + @displayQuarter +'_ActualLoad] int default 0,
	[' + @displayQuarter + '_FC_'+ @baseDisplayPeriod +'] int default 0,
	[' + @displayQuarter + '_FC_'+ @compareDisplayPeriod +'] int default 0,
	[' + @displayQuarter + '_Var] int default 0,
	[' + @displayQuarter + '_VarP] decimal(18, 4) default 0'
	from #Q 

	
	/*	3.4.2 delete the used QUATER*/	
	delete #Q where fiscal_quarter=@tempQuarter
	Exec (@SQL)
	exec (@sqlplant)
	exec (@sqlOEM)
		
	/*	3.4.3 Adding DATA to #base from #baseData and #compareData*/
	--cast((isnull(b.AMT,0) - c.AMT) as float)/c.AMT
	--cast((isnull(b.a2,0) - b.a3) as float)/b.a3
	select @sql = 'update #base set 
	[' + @displayQuarter+ '_ActualLoad]=isnull(b.ActualLoad,0),
	[' + @displayQuarter + '_FC_'+ @baseDisplayPeriod +']=isnull(b.AMT,0),
	[' + @displayQuarter + '_FC_'+ @compareDisplayPeriod +']=isnull(c.AMT,0),
	[' + @displayQuarter + '_Var]=isnull(b.AMT,0) - isnull(c.AMT,0),
	[' + @displayQuarter + '_VarP]= case when isnull(c.AMT,0) =0 then 0 else cast(isnull(b.AMT,0) as float)/c.AMT -1 end 
	from #base 
	left join #baseData as b on b.oem_id=oemid and b.fiscal_quarter='+  convert(varchar(6),@tempQuarter)+'
	left join #compareData as c on c.oem_id=oemid and c.fiscal_quarter='+  convert(varchar(6),@tempQuarter)
	,
	@sqlplant = 'update #basePlant set 
	[' + @displayQuarter+ '_ActualLoad]=isnull(b.a1,0),
	[' + @displayQuarter + '_FC_'+ @baseDisplayPeriod +']=isnull(b.a2,0),
	[' + @displayQuarter + '_FC_'+ @compareDisplayPeriod +']=isnull(b.a3,0),
	[' + @displayQuarter + '_Var]=isnull(b.a2,0) - isnull(b.a3,0),
	[' + @displayQuarter + '_VarP]= case when isnull(b.a3,0)=0 then 0 else cast(isnull(b.a2,0) as float)/b.a3 -1 end 
	from #baseplant left join 
	(
	select 
	plant,
	sum([' + @displayQuarter+ '_ActualLoad]) as a1,
	sum([' + @displayQuarter + '_FC_'+ @baseDisplayPeriod +']) as a2,
	sum([' + @displayQuarter + '_FC_'+ @compareDisplayPeriod +']) as a3
	from #base group by plant
	) as b on #baseplant.plant=b.plant'
	,
	@sqlOEM = 'update #baseOEM set 
	[' + @displayQuarter+ '_ActualLoad]=isnull(b.a1,0),
	[' + @displayQuarter + '_FC_'+ @baseDisplayPeriod +']=isnull(b.a2,0),
	[' + @displayQuarter + '_FC_'+ @compareDisplayPeriod +']=isnull(b.a3,0),
	[' + @displayQuarter + '_Var]=isnull(b.a2,0) - isnull(b.a3,0),
	[' + @displayQuarter + '_VarP]= case when isnull(b.a3,0)=0 then 0 else cast(isnull(b.a2,0) as float)/b.a3 -1 end 
	from #baseOEM left join 
	(
	select 
	oemName,
	sum([' + @displayQuarter+ '_ActualLoad]) as a1,
	sum([' + @displayQuarter + '_FC_'+ @baseDisplayPeriod +']) as a2,
	sum([' + @displayQuarter + '_FC_'+ @compareDisplayPeriod +']) as a3
	from #base group by oemName
	) as b on #baseOem.oemName=b.oemName'

	exec(@sql)
	exec(@sqlplant)
	exec(@sqlOEM)
end
/*
Select b.oem_id,
	substring((
	Select top 5 ','+a.comment +' ['+ a.author+'@'+ convert(varchar,a.comment_date,106)+'] \n '  AS [text()]
    From gam_oem_comments as a Where a.oem_id = b.oem_id and a.active=1 ORDER BY a.comment_date desc
    For XML PATH ('')
    ),2, 1000) as last5Comments
into #tmpComments
From (select distinct oem_id from gam_oem_comments where active=1) as b
*/

--select * from #base order by cusOEM,plant
/*
select b.last5Comments,* from #base left join #tmpComments as b
on oemid=oem_id order by plant,oemName
drop table #tmpComments*/
select * from #base order by plant,oemName


select * from #baseplant
select * from #baseOEM
--select @message

drop table #baseplant

drop table #Q
drop table #base
drop table #baseData
drop table #compareData
--drop table 
set nocount off
GO
