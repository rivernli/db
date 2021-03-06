USE [BOC]
GO
/****** Object:  UserDefinedFunction [dbo].[Loading_PT_get_Margin_Percent]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[Loading_PT_get_Margin_Percent](@Production_Type nvarchar(100),@plant nvarchar(10),@year int,@period int, @analyse_user nvarchar(50))
returns float
as
begin
	declare @total_profit float
	declare @total_book float
	declare @margin_percent float

	if @Production_Type <> 'others' and @Production_Type <> 'Total' and @Production_Type <> 'Total per week'
		begin
			select @total_profit = sum([Profit per PCS]*[Production Volume Booking (Units)]) 
			from tfsboc100180_analyse 
			where plant = @plant 
			and Fiscal_Year = @year 
			and Fiscal_Period = @Period 
			and Configuration = @Production_Type
			and Analysis_User = @analyse_user

			select @total_book = sum([Selling Price Per Unit (US$)]*[Production Volume Booking (Units)]) 
			from tfsboc100180_analyse 
			where plant = @plant 
			and Fiscal_Year = @year 
			and Fiscal_Period = @Period 
			and Configuration = @Production_Type
			  and Analysis_User = @analyse_user
		end

	if @Production_Type = 'others'
		begin
			select @total_profit = sum([Profit per PCS]*[Production Volume Booking (Units)]) 
			from tfsboc100180_analyse 
			where plant = @plant 
			and Fiscal_Year = @year 
			and Fiscal_Period = @Period 
			and Configuration not in(select Product_Type from tfsboc107180 where plant = @plant)
			and Analysis_User = @analyse_user

			select @total_book = sum([Selling Price Per Unit (US$)]*[Production Volume Booking (Units)]) 
			from tfsboc100180_analyse 
			where plant = @plant 
			and Fiscal_Year = @year 
			and Fiscal_Period = @Period 
			and Configuration not in(select Product_Type from tfsboc107180 where plant = @plant)
			and Analysis_User = @analyse_user
		end

	if @Production_Type = 'Total'
		begin
			select @total_profit = sum([Profit per PCS]*[Production Volume Booking (Units)]) 
			from tfsboc100180_analyse 
			where plant = @plant 
			and Fiscal_Year = @year 
			and Fiscal_Period = @Period 
			and Analysis_User = @analyse_user

			select @total_book = sum([Selling Price Per Unit (US$)]*[Production Volume Booking (Units)]) 
			from tfsboc100180_analyse 
			where plant = @plant 
			and Fiscal_Year = @year 
			and Fiscal_Period = @Period 
			and Analysis_User = @analyse_user
		end

	set @margin_percent = cast((@total_profit / @total_book)as decimal(18, 3))

	return @margin_percent
end
GO
