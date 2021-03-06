USE [BOC]
GO
/****** Object:  UserDefinedFunction [dbo].[Loading_get_no_Proj]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[Loading_get_no_Proj](@customer nvarchar(100),@plant nvarchar(10),@year int,@period int,@analyse_user nvarchar(50))
returns int
as
begin
	declare @no_of_Project int
--	declare @fweek int						--Fiscal Week
--	
--	if @period  = 1 or @period  = 4 or @period  = 7 or @period  = 10
--			set @fweek = 5
--	else
--			set @fweek = 4

--	if @customer = 'others'
--		begin
			select distinct @no_of_Project = count([Projects(8)]) 
			from tfsboc100180_analyse 
			where end_customer = @customer--not in(select Key_customer from tfsboc106180 where plant = @plant)
			and plant = @plant 
			and Fiscal_Year = @year 
			and Fiscal_Period = @Period
			and Analysis_User = @analyse_user
--		end
--	if @customer = 'Total'
--		begin
--			select distinct @no_of_Project = count([Projects(8)]) 
--			from tfsboc100180_analyse 
--			where plant = @plant 
--			and Fiscal_Year = @year 
--			and Fiscal_Period = @Period
--		end
--	if @customer = 'Total per week'
--		begin 
--			select distinct @no_of_Project = count([Projects(8)]) 
--			from tfsboc100180_analyse 
--			where plant = @plant 
--			and Fiscal_Year = @year 
--			and Fiscal_Period = @Period
--
--			set @no_of_Project = @no_of_Project / @fweek
--		end

	return @no_of_Project
end
GO
