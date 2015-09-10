USE [BOC]
GO
/****** Object:  UserDefinedFunction [dbo].[Loading_get_other_percent_total_output_FT]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE function [dbo].[Loading_get_other_percent_total_output_FT](@type nvarchar(100),@plant nvarchar(10),@year int,@period int,@analyse_user nvarchar(50))
returns float
as
begin
	declare @output_percent float
	declare @total_output float
	declare @currect_output float
	
	if @type <> 'others' and @type <> 'Total' and @type <> 'Total per week' 
		begin
			select @currect_output = sum([Production Volume Booking (Units)]*([Panel Size(sqft)]/[Unit_per_Panel])) 
			from tfsboc100180_analyse 
			where plant = @plant 
			and Fiscal_Year = @year 
			and Fiscal_Period = @Period 
			and end_customer = @type
			and Analysis_User = @analyse_user

			select @total_output   = sum([Production Volume Booking (Units)]*([Panel Size(sqft)]/[Unit_per_Panel])) 
			from tfsboc100180_analyse 
			where plant = @plant 
			and Fiscal_Year = @year 
			and Fiscal_Period = @Period
			and Analysis_User = @analyse_user

			if(@total_output = 0)
				set @output_percent = 0
			else
				set @output_percent = cast(((@currect_output/@total_output)) as decimal(18, 3))
		end

	if @type = 'others'
		begin
			select @currect_output = sum([Production Volume Booking (Units)]*([Panel Size(sqft)]/[Unit_per_Panel])) 
			from tfsboc100180_analyse 
			where plant = @plant 
			and Fiscal_Year = @year 
			and Fiscal_Period = @Period 
			and end_customer  not in(select Key_customer from tfsboc106180 where plant = @plant)
			and Analysis_User = @analyse_user

			select @total_output   = sum([Production Volume Booking (Units)]*([Panel Size(sqft)]/[Unit_per_Panel])) 
			from tfsboc100180_analyse 
			where plant = @plant 
			and Fiscal_Year = @year 
			and Fiscal_Period = @Period
			and Analysis_User = @analyse_user

			if(@total_output = 0)
				set @output_percent = 0
			else
				set @output_percent = cast(((@currect_output/@total_output)) as decimal(18, 3))
		end
	if @type = 'Total'
		begin
			select @currect_output = sum([Production Volume Booking (Units)]*([Panel Size(sqft)]/[Unit_per_Panel])) 
			from tfsboc100180_analyse 
			where plant = @plant 
			and Fiscal_Year = @year 
			and Fiscal_Period = @Period 
			and Analysis_User = @analyse_user

			select @total_output   = sum([Production Volume Booking (Units)]*([Panel Size(sqft)]/[Unit_per_Panel])) 
			from tfsboc100180_analyse 
			where plant = @plant 
			and Fiscal_Year = @year 
			and Fiscal_Period = @Period
			and Analysis_User = @analyse_user

			if(@total_output = 0)
				set @output_percent = 0
			else
				set @output_percent = cast(((@currect_output/@total_output)) as decimal(18, 3))
		end

	return @output_percent
end



GO
