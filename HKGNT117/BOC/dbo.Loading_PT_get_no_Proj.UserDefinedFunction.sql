USE [BOC]
GO
/****** Object:  UserDefinedFunction [dbo].[Loading_PT_get_no_Proj]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE function [dbo].[Loading_PT_get_no_Proj](@Production_Type nvarchar(100),@plant nvarchar(10),@year int,@period int,@analyse_user nvarchar(50))
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

	if @Production_Type <> 'others' and @Production_Type <> 'Total' and @Production_Type <> 'Total per week'
		begin
			select distinct @no_of_Project = count([Projects(8)]) 
			from tfsboc100180_analyse 
			where Configuration = @Production_Type
			and plant = @plant 
			and Fiscal_Year = @year 
			and Fiscal_Period = @Period
			and Analysis_User = @analyse_user

			IF @no_of_Project = 0
				BEGIN
					SELECT DISTINCT @no_of_Project = count([Projects(8)]) 
					FROM	tfsboc100180_analyse AS A 
					WHERE A.Configuration in(select dbo.tfsboc112180.t$type from dbo.tfsboc112180 ,tfsboc107180 where tfsboc107180.Product_Type = tfsboc112180.t$matp and tfsboc107180.plant = @plant and tfsboc112180.t$matp = @Production_Type)
					and		A.plant  	    = @plant 
					and		A.Fiscal_Year   = @year 
					and		A.Fiscal_Period = @Period
					and		A.Analysis_User = @analyse_user
				END
		end

	if @Production_Type = 'others'
		begin
			select distinct @no_of_Project = count([Projects(8)]) 
			from tfsboc100180_analyse AS A left join dbo.tfsboc112180 AS B
			on		a.Configuration = b.t$matp
			where Configuration not in(select Product_Type from tfsboc107180 where plant = @plant)
			and   Configuration not in(select t$type from dbo.tfsboc112180 ,tfsboc107180 where tfsboc107180.Product_Type = tfsboc112180.t$matp and plant = @plant)
			and plant = @plant 
			and Fiscal_Year = @year 
			and Fiscal_Period = @Period
			and Analysis_User = @analyse_user
		end

	if @Production_Type = 'Total'
		begin
			select distinct @no_of_Project = count([Projects(8)]) 
			from tfsboc100180_analyse 
			where plant = @plant 
			and Fiscal_Year = @year 
			and Fiscal_Period = @Period
			and Analysis_User = @analyse_user
		end
--	if @Production_Type = 'Total per week'
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
