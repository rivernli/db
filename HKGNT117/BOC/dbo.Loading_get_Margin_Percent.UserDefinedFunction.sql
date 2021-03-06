USE [BOC]
GO
/****** Object:  UserDefinedFunction [dbo].[Loading_get_Margin_Percent]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE function [dbo].[Loading_get_Margin_Percent](@customer nvarchar(100),@plant nvarchar(10),@year int,@period int, @analyse_user nvarchar(50))
returns float
as
begin
	declare @total_profit float
	declare @total_book float
	declare @margin_percent float

	if @customer <> 'others' and @customer <> 'Total' and @customer <> 'Total per week'
		begin
			select @total_profit = sum([Profit per PCS]*[Production Volume Booking (Units)]) 
			from tfsboc100180_analyse 
			where plant = @plant 
			and Fiscal_Year = @year 
			and Fiscal_Period = @Period 
			and end_customer = @customer
			and Analysis_User = @analyse_user

			select @total_book = sum([Selling Price Per Unit (US$)]*[Production Volume Booking (Units)]) 
			from tfsboc100180_analyse 
			where plant = @plant 
			and Fiscal_Year = @year 
			and Fiscal_Period = @Period 
			and end_customer = @customer
			  and Analysis_User = @analyse_user
		end

	if @customer = 'others'
		begin
			select @total_profit = sum([Profit per PCS]*[Production Volume Booking (Units)]) 
			from tfsboc100180_analyse 
			where plant = @plant 
			and Fiscal_Year = @year 
			and Fiscal_Period = @Period 
			and end_customer not in(select Key_customer from tfsboc106180 where plant = @plant)
			and Analysis_User = @analyse_user

			select @total_book = sum([Selling Price Per Unit (US$)]*[Production Volume Booking (Units)]) 
			from tfsboc100180_analyse 
			where plant = @plant 
			and Fiscal_Year = @year 
			and Fiscal_Period = @Period 
			and end_customer not in(select Key_customer from tfsboc106180 where plant = @plant)
			and Analysis_User = @analyse_user
		end

	if @customer = 'Total'
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

	IF @total_book = 0
		SET @margin_percent = 0
	ELSE
		set @margin_percent = cast((@total_profit / @total_book)as decimal(18, 4))

	return @margin_percent
end

GO
