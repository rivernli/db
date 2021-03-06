USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[Calc_Total_ALC]    Script Date: 2014/11/12 17:02:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create proc [dbo].[Calc_Total_ALC]   -- 计算Total ALC 平均层数:Sum(Production_Book_SqFt*(Layer_Count-2)/2)/Sum(Production_Book_SqFt)*2+2
@Fiscal_Year int,
@Fiscal_Period int,
@plant nvarchar(10),
@User nvarchar(50),
@UID	int
as
declare @Customer nvarchar(100)

select @Customer = Customer from tfsboc103180_analyse where id = @UID

if exists((select sum(gg.Total_SQFT)
	from 
	(
	select right(left([projects(8)],3),2) as Leyer,((sum([Production Volume Booking (Units)])+(dbo.Get_Cus_sumsqft(@Fiscal_Year,@Fiscal_Period,@plant,right(left([projects(8)],3),2),1000,@Customer)))) as Total_SQFT
	from dbo.tfsboc100180
	where fiscal_year = @Fiscal_Year
	and fiscal_period = @Fiscal_Period
	and plant = @plant
	--group by customer_name
	group by right(left([projects(8)],3),2)
	--order by right(left([projects(8)],3),2)
	) as gg))

	update tfsboc103180_analyse set Avg_Layer_Count = 
	(select 
	(
	select sum(g.Total_SQFT)
	from 
	(
	select right(left([projects(8)],3),2) as Leyer,((sum([Production Volume Booking (Units)])+(dbo.Get_Cus_sumsqft(@Fiscal_Year,@Fiscal_Period,@plant,right(left([projects(8)],3),2),1000,@Customer)))*(cast(right(left([projects(8)],3),2) as int)-2)/2) as Total_SQFT
	from dbo.tfsboc100180
	where fiscal_year = @Fiscal_Year
	and fiscal_period = @Fiscal_Period
	and plant = @plant
	--group by customer_name
	group by right(left([projects(8)],3),2)
	--order by right(left([projects(8)],3),2)
	) as g)/(select sum(gg.Total_SQFT)

	from 
	(
	select right(left([projects(8)],3),2) as Leyer,((sum([Production Volume Booking (Units)])+(dbo.Get_Cus_sumsqft(@Fiscal_Year,@Fiscal_Period,@plant,right(left([projects(8)],3),2),1000,@Customer)))) as Total_SQFT
	from dbo.tfsboc100180
	where fiscal_year = @Fiscal_Year
	and fiscal_period = @Fiscal_Period
	and plant = @plant
	--group by customer_name
	group by right(left([projects(8)],3),2)
	--order by right(left([projects(8)],3),2)
	) as gg)*2 +2 
	)
	where customer = 'Total'
	and [User] = @User


GO
