USE [BOC]
GO
/****** Object:  UserDefinedFunction [dbo].[Loading_pt_get_other_Margin$_Total]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE function [dbo].[Loading_pt_get_other_Margin$_Total](@type nvarchar(100),@plant nvarchar(10),@year int,@period int,@analyse_user nvarchar(50))
returns float
as
begin
	declare @output_percent float
	declare @total_output float
	declare @currect_output float
	declare @fweek int						--Fiscal Week
	
	if @period  = 1 or @period  = 4 or @period  = 7 or @period  = 10
			set @fweek = 5
	else
			set @fweek = 4
	if @type <> 'others' and @type <> 'Total' and @type <> 'Total per week' 
		begin
			select @currect_output = sum([Production Volume Booking (Units)]*[Profit per PCS]) 
			from tfsboc100180_analyse 
			where plant = @plant 
			and Fiscal_Year = @year 
			and Fiscal_Period = @Period 
			and Configuration = @type
			and Analysis_User = @analyse_user

			set @output_percent = cast(((@currect_output)) as decimal(18, 0))
		end

	if @type = 'others'
		begin
			select @currect_output = sum([Production Volume Booking (Units)]*[Profit per PCS]) 
			from tfsboc100180_analyse 
			where plant = @plant 
			and Fiscal_Year = @year 
			and Fiscal_Period = @Period 
			and Configuration  not in(select Product_Type from tfsboc107180 where plant = @plant)
			and Analysis_User = @analyse_user

			set @output_percent = cast(((@currect_output)) as decimal(18, 0))
		end
	if @type = 'Total'
		begin
			select @currect_output = sum([Production Volume Booking (Units)]*[Profit per PCS]) 
			from tfsboc100180_analyse 
			where plant = @plant 
			and Fiscal_Year = @year 
			and Fiscal_Period = @Period 
			and Analysis_User = @analyse_user

			set @output_percent = cast(((@currect_output)) as decimal(18, 0))
		end
	if @type = 'Total per week'
		begin
			select @currect_output = sum([Production Volume Booking (Units)]*[Profit per PCS]) 
			from tfsboc100180_analyse 
			where plant = @plant 
			and Fiscal_Year = @year 
			and Fiscal_Period = @Period 
			and Analysis_User = @analyse_user

			set @output_percent = cast(((@currect_output/@fweek)) as decimal(18, 0))
		end
	return @output_percent
end

GO
