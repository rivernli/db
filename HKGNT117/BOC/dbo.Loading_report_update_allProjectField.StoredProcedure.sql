USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[Loading_report_update_allProjectField]    Script Date: 2014/11/12 17:02:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[Loading_report_update_allProjectField]
	@Plant			nvarchar(10),
	@Fiscal_Year	int,
	@Fiscal_Period	int,
	@Analysis_User	nvarchar(20),
	@Project		nvarchar(20),
	@SellingPrice	float,
	@BookUnit		float

	--UPDATE tfsboc100180_analyse 
	--SET [Selling Price Per Unit (US$)] = @column18,[Production Volume Booking (Units)] = @column25
	--WHERE [Analysis_User] = @Analysis_User 
	--AND [Fiscal_Year] = @Fiscal_Year 
	--AND [@Fiscal_Period] = @@Fiscal_Period 
	--AND [Plant] = @Plant
	--and [Projects(8)] = @column1

as
	declare @total_sqft		  float
	declare @total_sale		  float
	declare @total_margin	  float
	declare @total_Consumed1  float
	declare @total_Consumed2  float
	declare @total_Consumed3  float
	declare @total_Consumed4  float
	declare @total_Consumed5  float
	declare @total_Consumed6  float
	declare @total_Consumed7  float
	declare @total_Consumed8  float
	declare @total_Consumed9  float
	declare @total_Consumed10 float
	declare @total_Consumed11 float
	declare @total_Consumed12 float
	declare @total_Consumed13 float
	declare @total_Consumed14 float
	declare @total_Consumed15 float

	IF @BookUnit = 0
		BEGIN
			RAISERROR('Production Volume Booking (Units) can not equal 0',16,1)
			RETURN
		END

	IF @SellingPrice = 0
		BEGIN
			RAISERROR('Selling Price Per Unit (US$) can not equal 0',16,1)
			RETURN
		END

	-- update field that no percent
	update tfsboc100180_analyse 
	set [Selling Price Per Unit (US$)]		  = @SellingPrice,
		[Production Volume Booking (Units)]   = @BookUnit,
		[Profit per PCS]					  = @SellingPrice-[Total Cost per unit(US$)],
		[Production Volume Booking (Square F] = @BookUnit*([Panel Size(sqft)]/[Unit_per_Panel]),
		[Total Sales (USD)]					  = @BookUnit*@SellingPrice,
		[ASP US$]							  = (@BookUnit * @SellingPrice)/(@BookUnit * ([Panel Size(sqft)]/[Unit_per_Panel])),
		[Margin$ (total)]					  = (@SellingPrice-[Total Cost per unit(US$)]) * @BookUnit,
		[%Margin]							  = (@SellingPrice-[Total Cost per unit(US$)])/@SellingPrice*100,
		[Material Cost _Sale(Current)]		  = [Material cost (Scrap included)] * 100 / @SellingPrice,
		[Boc Consumed1]						  = @BookUnit/[Unit_per_Panel] * [Cycle time1]  / 60,
		[Boc Consumed2]						  = @BookUnit/[Unit_per_Panel] * [Cycle time2]  / 60,
		[Boc Consumed3]						  = @BookUnit/[Unit_per_Panel] * [Cycle time3]  / 60,
		[Boc Consumed4]						  = @BookUnit/[Unit_per_Panel] * [Cycle time4]  / 60,
		[Boc Consumed5]						  = @BookUnit/[Unit_per_Panel] * [Cycle time5]  / 60,
		[Boc Consumed6]						  = @BookUnit/[Unit_per_Panel] * [Cycle time6]  / 60,
		[Boc Consumed7]						  = @BookUnit/[Unit_per_Panel] * [Cycle time7]  / 60,
		[Boc Consumed8]						  = @BookUnit/[Unit_per_Panel] * [Cycle time8]  / 60,
		[Boc Consumed9]						  = @BookUnit/[Unit_per_Panel] * [Cycle time9]  / 60,
		[Boc Consumed10]					  = @BookUnit/[Unit_per_Panel] * [Cycle time10] / 60,
		[Boc Consumed11]					  = @BookUnit/[Unit_per_Panel] * [Cycle time11] / 60,
		[Boc Consumed12]					  = @BookUnit/[Unit_per_Panel] * [Cycle time12] / 60,
		[Boc Consumed13]					  = @BookUnit/[Unit_per_Panel] * [Cycle time13] / 60,
		[Boc Consumed14]					  = @BookUnit/[Unit_per_Panel] * [Cycle time14] / 60,
		[Boc Consumed15]					  = @BookUnit/[Unit_per_Panel] * [Cycle time15] / 60
	where plant         = @plant
	and	  Fiscal_Year   = @Fiscal_Year
	and   Fiscal_Period = @Fiscal_Period
	and   Analysis_User = @Analysis_User
	and   [Projects(8)] = @Project

-- update  percent field
	select 
	@total_sqft =		sum([Production Volume Booking (Square F]),
	@total_sale =		sum([Total Sales (USD)]),
	@total_margin =		sum([Margin$ (total)]),
	@total_Consumed1 =	sum([Boc Consumed1]),
	@total_Consumed2 =	sum([Boc Consumed2]),
	@total_Consumed3 =	sum([Boc Consumed3]),
	@total_Consumed4 =	sum([Boc Consumed4]),
	@total_Consumed5 =	sum([Boc Consumed5]),
	@total_Consumed6 =	sum([Boc Consumed6]),
	@total_Consumed7 =	sum([Boc Consumed7]),
	@total_Consumed8 =	sum([Boc Consumed8]),
	@total_Consumed9 =	sum([Boc Consumed9]),
	@total_Consumed10 = sum([Boc Consumed10]),
	@total_Consumed11 = sum([Boc Consumed11]),
	@total_Consumed12 = sum([Boc Consumed12]),
	@total_Consumed13 = sum([Boc Consumed13]),
	@total_Consumed14 = sum([Boc Consumed14]),
	@total_Consumed15 = sum([Boc Consumed15])
	from tfsboc100180_analyse
	where	plant	  = @plant
	and Fiscal_Year   = @Fiscal_Year
	and Fiscal_Period = @Fiscal_Period
	and Analysis_User = @Analysis_User

	if @total_sqft       = 0 set @total_sqft = 1
	if @total_sale       = 0 set @total_sale = 1
	if @total_margin     = 0 set @total_margin = 1
	if @total_Consumed1  = 0 set @total_Consumed1 = 1
	if @total_Consumed2  = 0 set @total_Consumed2 = 1
	if @total_Consumed3  = 0 set @total_Consumed3 = 1
	if @total_Consumed4  = 0 set @total_Consumed4 = 1
	if @total_Consumed5  = 0 set @total_Consumed5 = 1
	if @total_Consumed6  = 0 set @total_Consumed6 = 1
	if @total_Consumed7  = 0 set @total_Consumed7 = 1
	if @total_Consumed8  = 0 set @total_Consumed8 = 1
	if @total_Consumed9  = 0 set @total_Consumed9 = 1
	if @total_Consumed10 = 0 set @total_Consumed10 = 1
	if @total_Consumed11 = 0 set @total_Consumed11 = 1
	if @total_Consumed12 = 0 set @total_Consumed12 = 1
	if @total_Consumed13 = 0 set @total_Consumed13 = 1
	if @total_Consumed14 = 0 set @total_Consumed14 = 1
	if @total_Consumed15 = 0 set @total_Consumed15 = 1

	update tfsboc100180_analyse 
	set [% of Production Volume (Square Foot] = [Production Volume Booking (Square F]*100/(@total_sqft),
		[% of Margin (total)]		= [Margin$ (total)] * 100 / @total_margin,
		[% of Total Sales]			= [Total Sales (USD)] * 100 / @total_sale,
		[Percent of Boc Consumed1]  = [Boc Consumed1] * 100 /@total_Consumed1,
		[Percent of Boc Consumed2]  = [Boc Consumed1] * 100 /@total_Consumed2,
		[Percent of Boc Consumed3]  = [Boc Consumed1] * 100 /@total_Consumed3,
		[Percent of Boc Consumed4]  = [Boc Consumed1] * 100 /@total_Consumed4,
		[Percent of Boc Consumed5]  = [Boc Consumed1] * 100 /@total_Consumed5,
		[Percent of Boc Consumed6]  = [Boc Consumed1] * 100 /@total_Consumed6,
		[Percent of Boc Consumed7]  = [Boc Consumed1] * 100 /@total_Consumed7,
		[Percent of Boc Consumed8]  = [Boc Consumed1] * 100 /@total_Consumed8,
		[Percent of Boc Consumed9]  = [Boc Consumed1] * 100 /@total_Consumed9,
		[Percent of Boc Consumed10] = [Boc Consumed1] * 100 /@total_Consumed10,
		[Percent of Boc Consumed11] = [Boc Consumed1] * 100 /@total_Consumed11,
		[Percent of Boc Consumed12] = [Boc Consumed1] * 100 /@total_Consumed12,
		[Percent of Boc Consumed13] = [Boc Consumed1] * 100 /@total_Consumed13,
		[Percent of Boc Consumed14] = [Boc Consumed1] * 100 /@total_Consumed14,
		[Percent of Boc Consumed15] = [Boc Consumed1] * 100 /@total_Consumed15
	where plant         = @plant
	and   Fiscal_Year   = @Fiscal_Year
	and   Fiscal_Period = @Fiscal_Period
	and   Analysis_User = @Analysis_User
	and   [Projects(8)] = @Project


GO
