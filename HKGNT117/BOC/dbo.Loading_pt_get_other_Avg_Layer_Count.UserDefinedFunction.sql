USE [BOC]
GO
/****** Object:  UserDefinedFunction [dbo].[Loading_pt_get_other_Avg_Layer_Count]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE function [dbo].[Loading_pt_get_other_Avg_Layer_Count](@type nvarchar(100),@plant nvarchar(10),@year int,@period int,@analyse_user nvarchar(50))
returns float
as
begin
	declare @output_percent float
	declare @Sum_SQFT  float
	declare @ALC float
	set @ALC = 0

	if @type <> 'others' and @type <> 'Total' and @type <> 'Total per week' 
		begin
			select @Sum_SQFT = sum([Production Volume Booking (Units)]*([Panel Size(sqft)]/[Unit_per_Panel])) 
			from tfsboc100180_analyse 
			where Configuration = @type  
			and plant = @plant 
			and Fiscal_Year = @year 
			and Fiscal_Period = @Period
			and Analysis_User = @analyse_user

			if @Sum_SQFT <> 0 
			begin
				select @ALC = @ALC+ (sum([Production Volume Booking (Units)]*([Panel Size(sqft)]/[Unit_per_Panel]))/(@Sum_SQFT)*cast(right(left([projects(8)],3),2) as int))
				from tfsboc100180_analyse
				where plant = @plant 
				and Fiscal_Year = @year 
				and Fiscal_Period = @Period 
				and Configuration = @type
				and Analysis_User = @analyse_user
				group by [projects(8)]
			end
			if(@ALC = 0)
				set @ALC = 0
			else
				set @ALC = cast(@ALC as decimal(18, 4))
		end

	if @type = 'others'
		begin
			-- get Total SQFT
			select @Sum_SQFT = sum([Production Volume Booking (Units)]*([Panel Size(sqft)]/[Unit_per_Panel])) 
			from tfsboc100180_analyse 
			where Configuration not in(select Product_Type from tfsboc107180 where plant = @plant)
			and plant = @plant 
			and Fiscal_Year = @year 
			and Fiscal_Period = @Period 
			and Analysis_User = @analyse_user

			--Calc ALC
			if @Sum_SQFT <> 0 
			begin
				select @ALC = @ALC+(sum([Production Volume Booking (Units)]*([Panel Size(sqft)]/[Unit_per_Panel]))/(@Sum_SQFT)*cast(right(left([projects(8)],3),2) as int))
				from tfsboc100180_analyse
				where plant = @plant 
				and Fiscal_Year = @year 
				and Fiscal_Period = @Period 
				and Configuration not in(select Product_Type from tfsboc107180 where plant = @plant)
				and Analysis_User = @analyse_user
				group by [projects(8)]
			end
	
			if(@ALC = 0)
				set @ALC = 0
			else
				set @ALC = cast(@ALC as decimal(18, 4))
		end
	if @type = 'Total'
		begin
			-- get Total SQFT
			select @Sum_SQFT = sum([Production Volume Booking (Units)]*([Panel Size(sqft)]/[Unit_per_Panel])) 
			from tfsboc100180_analyse 
			where plant = @plant 
			and Fiscal_Year = @year 
			and Fiscal_Period = @Period 
			and Analysis_User = @analyse_user

			--Calc ALC
			if @Sum_SQFT <> 0 
			begin
				select @ALC = @ALC+(sum([Production Volume Booking (Units)]*([Panel Size(sqft)]/[Unit_per_Panel]))/(@Sum_SQFT)*cast(right(left([projects(8)],3),2) as int))
				from tfsboc100180_analyse
				where plant = @plant 
				and Fiscal_Year = @year 
				and Fiscal_Period = @Period 
				--and Configuration not in(select Product_Type from tfsboc107180 where plant = @plant)
				and Analysis_User = @analyse_user
				group by [projects(8)]
			end

			if(@ALC = 0)
				set @ALC = 0
			else
				set @ALC = cast(@ALC as decimal(18, 4))
		end
	--if @type = 'Total per week'
	return @ALC
end
GO
