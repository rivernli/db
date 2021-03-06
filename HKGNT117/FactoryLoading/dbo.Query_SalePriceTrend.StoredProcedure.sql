USE [FactoryLoading]
GO
/****** Object:  StoredProcedure [dbo].[Query_SalePriceTrend]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Query_SalePriceTrend]
	@YearFrom	INT,
	@PeriodFrom	INT,
	@YearTo		INT,
	@PeriodTo	INT,
	@Operation	nvarchar(10)
AS
BEGIN
	SET NOCOUNT ON;
	
	declare @DateFrom		datetime
	declare @DateTo			datetime
	declare	@TempYear		int
	declare	@TempPeriod		int
	declare	@Loop			int
	declare	@LoopCount		int
	declare @sqlString		nvarchar(1000)
	declare @tempYearFrom	INT
	declare @tempPeriodFrom	INT
	declare @tempYearTo		INT
	declare @tempPeriodTo	INT
	declare @tempField		nvarchar(1000)

	set	   @TempYear	   = @YearFrom
	set    @TempPeriod     = @PeriodFrom
	set	   @tempYearFrom   = @YearFrom
	set	   @tempYearTo     = @YearTo
	set    @tempPeriodFrom = @PeriodFrom
	set    @tempPeriodTo   = @PeriodTo
	set	   @Loop		   = 1

	if @YearFrom > @YearTo
		begin
			raiserror('The Year To less then Year From,Please check !',16,1)
			return
		end

	if @YearFrom = @YearTo
		set @Loop = @PeriodTo - @PeriodFrom + 1

	if @YearFrom < @YearTo
		set @Loop = (@YearTo - @YearFrom) * 12 - @PeriodFrom + @PeriodTo + 1

	set @LoopCount = @Loop
/*======================================= Interagtion to finial result ============================*/
	if exists(select * from sysobjects where id = object_id(N'temp..#saleperiod') and type = 'U')
		drop table #saleperiod

	create table #saleperiod(Item NVARCHAR(50),Price FLOAT,Customer	NVARCHAR(50),Delivery NVARCHAR(50),Delivery_Term NVARCHAR(50),Del_Qty FLOAT,FYear INT,FPeriod INT)

	while @Loop > 0 
		begin
			-- Get Start Date & End Date
			select @DateFrom   = t$stdt from dbo.TTFGLD005180 where T$YEAR = @tempYearFrom and T$PRNO = @tempPeriodFrom and T$PTYP = 1
			set @TempPeriod = @TempPeriod + 1
			if @TempPeriod > 12
				begin
					set @TempYear = @TempYear + 1
					set @TempPeriod = 1
				end
			select @DateTo   = t$stdt from dbo.TTFGLD005180 where T$YEAR = @TempYear and T$PRNO = @TempPeriod and T$PTYP = 1
			set @DateTo = @DateTo - 1 

			-- Get Data
			INSERT INTO #saleperiod
			select a.t$item,c.t$pric,b.t$cuno,b.t$cdel,b.t$cdec as Delivery_Term,sum(a.t$dqua) as Del_Qty,@tempYearFrom as Year,@tempPeriodFrom as Period
			from dbo.TTDSLS041180      as a 
			left join dbo.TTDSLS040180 as b on b.t$orno = a.t$orno
			left join dbo.TFHSLS041180 as c on c.t$orno = a.t$orno and c.t$pono = a.t$pono
			where a.t$ddta between @DateFrom and @DateTo
			and	  a.t$sflg <> 2
			and	  a.t$dqua > 0
			and	  a.t$oqua > 0
			and	  a.t$item not like 'TTC%'
			and   a.t$item not like 'TCC%'
			--and	  a.t$item = '202P418D                        '
			--and	  a.t$item = '607L736A                        '
			--and	  a.t$item = 'E04J609B                        '
			--and		a.t$item = 'E06E892B                        '
			group by a.t$item,c.t$pric,b.t$cuno,b.t$cdel,b.t$cdec
			order by a.t$item,c.t$pric,b.t$cuno,b.t$cdel,b.t$cdec
--			having count(*) > 2
			-- 
			set @tempYearFrom   = @TempYear
			set @tempPeriodFrom = @TempPeriod
			set @Loop			= @Loop - 1
		end

	if exists(select * from sysobjects where id = object_id(N'temp..#saleperiod1') and type = 'U')
		drop table #saleperiod1

	select FYear,FPeriod,Item,Customer,Delivery,Delivery_Term,cast(sum(price*Del_Qty)/sum(Del_Qty) as decimal(18,4)) as price,sum(Del_Qty) as Del_Qty
	into #saleperiod1
	from #saleperiod
	group by FYear,FPeriod,item,Customer,Delivery,Delivery_Term

--	select * from #saleperiod1

/*======================================= Interagtion to finial result ============================*/
	if exists(select * from sysobjects where id = object_id(N'temp..#saleperiodResult') and type = 'U')
		drop table #saleperiodResult

	create table #saleperiodResult(Item	NVARCHAR(50),Customer NVARCHAR(50),Delivery	NVARCHAR(50),Delivery_Term	NVARCHAR(50))

	set	   @TempYear	   = @YearFrom
	set    @TempPeriod     = @PeriodFrom
	set	   @tempYearFrom   = @YearFrom
	set	   @tempYearTo     = @YearTo
	set    @tempPeriodFrom = @PeriodFrom
	set    @tempPeriodTo   = @PeriodTo
	set	   @Loop		   = @LoopCount
	
	while @Loop > 0 
		begin
			-- dyn add period field 
			set @tempField = 'FY'+cast(@TempYear as nvarchar(5))+'P'+cast(@TempPeriod as nvarchar(5))+'_Price'
			set @sqlString = 'alter table #saleperiodResult add '+@tempField+' float'
			execute(@sqlString)

--			set @sqlString = 'update #saleperiodResult set '+@tempField+'=b.Price from #saleperiodResult as a,#saleperiod as b 
--				where a.Item = b.Item and a.Customer = b.Customer and a.Delivery = b.Delivery and a.Delivery_Term = b.Delivery_Term and a.'+@tempField+' is null and b.FYear='+cast(@TempYear as nvarchar(5))+' and b.FPeriod = '+cast(@TempPeriod as nvarchar(5))

			set @sqlString = 'insert into #saleperiodResult(Item,Customer,Delivery,Delivery_Term) select a.Item,a.Customer,a.Delivery,a.Delivery_Term from #saleperiod1 as a where not exists(select b.* from #saleperiodResult as b where a.item = b.item and a.customer = b.customer and a.Delivery = b.Delivery and a.Delivery_Term = b.Delivery_Term) and a.Fyear ='+cast(@TempYear as nvarchar(5))+' and a.FPeriod = '+cast(@TempPeriod as nvarchar(5))
			execute(@sqlString)

			set @sqlString = 
			'update #saleperiodResult 
			set '+@tempField+'=b.Price 
			from #saleperiodResult as a,#saleperiod1 as b 
			where a.Item = b.Item 
			and a.Customer = b.Customer 
			and a.Delivery = b.Delivery 
			and a.Delivery_Term = b.Delivery_Term 
			and a.'+@tempField+' is null 
			and b.price not in (select '+@tempField+' from #saleperiodResult as c where c.Item = b.item and '+@tempField+' = b.price)
			and b.FYear='+cast(@TempYear as nvarchar(5))+' 
			and b.FPeriod = '+cast(@TempPeriod as nvarchar(5))
			execute(@sqlString)

			set @tempField = 'FY'+cast(@TempYear as nvarchar(5))+'P'+cast(@TempPeriod as nvarchar(5))+'_Del_Qty'
			set @sqlString = 'alter table #saleperiodResult add '+@tempField+' float'
			execute(@sqlString)

			set @sqlString = 
			'update #saleperiodResult 
			set '+@tempField+'=b.Del_Qty 
			from #saleperiodResult as a,#saleperiod1 as b 
			where a.Item = b.Item 
			and a.Customer = b.Customer 
			and a.Delivery = b.Delivery 
			and a.Delivery_Term = b.Delivery_Term 
			and a.'+@tempField+' is null 
			and b.price not in (select FY'+cast(@TempYear as nvarchar(5))+'P'+cast(@TempPeriod as nvarchar(5))+'_Price from #saleperiodResult as c where c.Item = b.item and '+@tempField+' = b.price)
			and b.FYear='+cast(@TempYear as nvarchar(5))+' 
			and b.FPeriod = '+cast(@TempPeriod as nvarchar(5))
			execute(@sqlString)

			set @TempPeriod = @TempPeriod + 1
			if @TempPeriod > 12
				begin
					set @TempYear = @TempYear + 1
					set @TempPeriod = 1
				end
			set @Loop = @Loop - 1
		end

	alter table #saleperiodResult add Diff float
	
	-- ( Last period price - first period price ) * Last period qty
	set @tempField = '(FY'+cast(@YearTo as nvarchar(5))+'P'+cast(@PeriodTo as nvarchar(5))+'_Price - '
	--set @tempField = @tempField + 'FY'+cast(@YearFrom as nvarchar(5))+'P'+cast(@PeriodFrom as nvarchar(5))+'_Price)'
	set @tempField = @tempField + 'isnull((select top 1 price from #saleperiod1 where Item = #saleperiodResult.item and Customer = #saleperiodResult.Customer and #saleperiodResult.Delivery = Delivery and #saleperiodResult.Delivery_Term = Delivery_Term order by FYear,FPeriod),0)) '
	set @tempField = @tempField + ' * isnull(FY'+cast(@YearTo as nvarchar(5))+'P'+cast(@PeriodTo as nvarchar(5))+'_Del_Qty,0)'
	set @sqlString = 'update #saleperiodResult set Diff = '+@tempField
	--print @sqlString
	execute(@sqlString)

/*===================================================================*/

--	set @sqlString = 'select * from #saleperiodResult order by Diff desc'
--	execute(@sqlString)

	if exists(select * from sysobjects where id = object_id(N'temp..#tempsort') and type = 'U')
		drop table #tempsort

	select * into #tempsort from #saleperiodResult  where 1 <> 1

	alter table #tempsort add id int identity

	insert into #tempsort(Item,Diff) select Item,cast(sum(Diff) as decimal(18,2)) as Total_Diff from #saleperiodResult group by Item order by Total_Diff desc

	insert into #saleperiodResult(Item,Diff) select Item,Diff from #tempsort

	alter table #saleperiodResult add id int
	
	update #saleperiodResult set diff = cast(diff as decimal(18,2)),id = (select id from #tempsort as a where #saleperiodResult.item = a.item)

	delete #saleperiodResult where diff is null

	if @Operation = 'Desc'
		select * from #saleperiodResult order by id desc,customer desc
	if @Operation = 'Asc'
		select * from #saleperiodResult order by id ,customer desc

	drop table #saleperiodResult
	drop table #tempsort
	drop table #saleperiod
	drop table #saleperiod1

END



GO
