USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MCOS_QueryByQuarter]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_MCOS_QueryByQuarter]

@startYear int,@endYear int,@startQuarter int,@endQuarter int,
@b1 bit,@b2f bit,@b3 bit,@b4 bit,@b5 bit,@hk bit,@revenueType tinyint,@materialType tinyint
as
begin

declare @salesType nvarchar(100);set @salesType = dbo.fx_getRevenueType(@revenueType)
declare @productionType nvarchar(100);set @productionType = dbo.fx_getMaterialType(@materialType)
declare @_b1 char(3);declare @_b2f char(3);declare @_b3 char(3);declare @_b4 char(3);declare @_b5 char(3);declare @_hk char(3)
set @_hk = '_HK';set @_b1='_B1';set @_b2f='_B2F';set @_b3='_B3';set @_b4='_B4';set @_b5='_B5'
if(@b1=1) set @_b1 ='B1'; if(@b2f=1) set @_b2f ='2F'; if(@b3=1) set @_b3 ='B3'; if(@b4=1) set @_b4 = 'B4'; if(@b5=1) set @_b5 = 'B5'; if(@hk=1) set @_hk = 'HK';
if exists (select 1 from sysobjects where name = '#tempMaterial') drop table #tempMaterial
if exists (select 1 from sysobjects where name = '#tempRevenue') drop table #tempRevenue
create table #tempMaterial(p char(10),y char(10),amt float)
create table #tempRevenue(p char(10),y char(10),amt float)

declare @startQ int; set @startQ = @startYear * 100 + @startQuarter;
declare @endQ int; set @endQ = @endYear * 100 + @endQuarter;
--MCOS_daily_4RP_MaterialSum , vw_4RP_materialSum
--MCOS_daily_4RP_RevenueSum , vw_4RP_RevenueSum

	if(@productionType='')
	begin
		insert into #tempMaterial (p,y,amt)	
		select plant as p,dbo.fx_getFiscalYearAndPeriod(fiscalyear,quarter) as y,sum([sum]) as amt from MCOS_daily_4RP_MaterialSum 
		where dbo.fx_getFiscalYearAndPeriod(fiscalyear,quarter) between @startQ and @endQ 
		and plant in (@_b1,@_b2f,@_b3,@_b4,@_b5,@_hk) group by plant,fiscalyear,quarter order by plant,fiscalyear,quarter;
	end
	else
	begin
		insert into #tempMaterial (p,y,amt)	
		select plant as p,dbo.fx_getFiscalYearAndPeriod(fiscalyear,quarter) as y,sum([sum]) as amt from MCOS_daily_4RP_MaterialSum 
		where dbo.fx_getFiscalYearAndPeriod(fiscalyear,quarter) between @startQ and @endQ 
		and plant in (@_b1,@_b2f,@_b3,@_b4,@_b5,@_hk) and productionType=@productionType group by plant,fiscalyear,quarter order by plant,fiscalyear,quarter;
	end	

	if(@salesType ='')
	begin
		insert into #tempRevenue (p,y,amt)	
		select plant as p,dbo.fx_getFiscalYearAndPeriod(fiscalyear,quarter) as y,sum([sum]) as amt from MCOS_daily_4RP_RevenueSum 
		where dbo.fx_getFiscalYearAndPeriod(fiscalyear,quarter) between @startQ and @endQ 
		and plant in (@_b1,@_b2f,@_b3,@_b4,@_b5,@_hk) group by plant,fiscalyear,quarter order by plant,fiscalyear,quarter;
	end
	else
	begin
		insert into #tempRevenue (p,y,amt)	
		select plant as p,dbo.fx_getFiscalYearAndPeriod(fiscalyear,quarter) as y,sum([sum]) as amt from MCOS_daily_4RP_RevenueSum 
		where dbo.fx_getFiscalYearAndPeriod(fiscalyear,quarter) between @startQ and @endQ 
		and plant in (@_b1,@_b2f,@_b3,@_b4,@_b5,@_hk) and salesType = @salesType group by plant,fiscalyear,quarter order by plant,fiscalyear,quarter;
	end

	--result 
	select isnull(m.p,r.p) as plant,isnull(m.y,r.y) as y,
	perc = case when r.amt is null or r.amt=0 then 999.99 else isnull(m.amt,0) / r.amt * 100 end,
	m.amt mamt,r.amt as ramt
	from #tempMaterial m full join #tempRevenue r on m.p=r.p and m.y=r.y order by plant,y

	drop table #tempMaterial	
	drop table #tempRevenue
end






GO
