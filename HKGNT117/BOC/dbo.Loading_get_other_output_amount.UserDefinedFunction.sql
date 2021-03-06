USE [BOC]
GO
/****** Object:  UserDefinedFunction [dbo].[Loading_get_other_output_amount]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE function [dbo].[Loading_get_other_output_amount](@type nvarchar(100),@plant nvarchar(10),@year int,@period int,@analyse_user nvarchar(50))
returns int
as
begin
	declare @Total_sales int
	declare @fweek int						--Fiscal Week
	
	if @period  = 1 or @period  = 4 or @period  = 7 or @period  = 10
			set @fweek = 5
	else
			set @fweek = 4

	set @Total_sales = 0

	if @type <> 'others' and @type <> 'Total' and @type <> 'Total per week'
		begin
			select @Total_sales = sum([Production Volume Booking (Units)]*[Selling Price Per Unit (US$)]) 
			from tfsboc100180_analyse 
			where end_customer = @type
			and plant = @plant 
			and Fiscal_Year = @year 
			and Fiscal_Period = @Period
			and Analysis_User = @analyse_user

			if(@Total_sales is null)
				set @Total_sales = 0	
		end

	if @type = 'others'
		begin
			select @Total_sales = sum([Production Volume Booking (Units)]*[Selling Price Per Unit (US$)]) 
			from tfsboc100180_analyse 
			where end_customer  not in(select Key_customer from tfsboc106180 where plant = @plant)
			and plant = @plant 
			and Fiscal_Year = @year 
			and Fiscal_Period = @Period
			and Analysis_User = @analyse_user

			if(@Total_sales is null)
				set @Total_sales = 0	
		end
	if @type = 'Total'
		begin
			select @Total_sales = sum([Production Volume Booking (Units)]*[Selling Price Per Unit (US$)]) 
			from tfsboc100180_analyse 
			where plant = @plant 
			and Fiscal_Year = @year 
			and Fiscal_Period = @Period
			and Analysis_User = @analyse_user

			if(@Total_sales is null)
				set @Total_sales = 0
		end
	if @type = 'Total per week'
		begin
			select @Total_sales = sum([Production Volume Booking (Units)]*[Selling Price Per Unit (US$)]) 
			from tfsboc100180_analyse 
			where plant = @plant 
			and Fiscal_Year = @year 
			and Fiscal_Period = @Period
			and Analysis_User = @analyse_user

			if(@Total_sales is null)
				set @Total_sales = 0
			
			set @Total_sales = @Total_sales / @fweek
		end
	return @Total_sales
end

GO
