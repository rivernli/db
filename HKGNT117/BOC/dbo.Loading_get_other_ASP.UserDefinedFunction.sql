USE [BOC]
GO
/****** Object:  UserDefinedFunction [dbo].[Loading_get_other_ASP]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[Loading_get_other_ASP](@type nvarchar(100),@plant nvarchar(10),@year int,@period int ,@analyse_user nvarchar(50))
returns float
as
begin
	declare @ASP float
	declare @Output_Ft2 float
	declare @Output_amount float
	declare @fweek int						--Fiscal Week
	
	if @period  = 1 or @period  = 4 or @period  = 7 or @period  = 10
			set @fweek = 5
	else
			set @fweek = 4

	if @type <> 'others' and @type <> 'Total' and @type <> 'Total per week' 
		begin
			set @Output_Ft2 = dbo.Loading_get_other_output_Ft2(@type,@plant,@year,@period,@analyse_user)
			set @Output_amount = dbo.Loading_get_other_output_amount(@type,@plant,@year,@period,@analyse_user)

			if(@Output_Ft2 = 0)
				set @ASP = 0
			else
				set @ASP = @Output_amount/@Output_Ft2
			--return cast(@ASP as decimal(18, 4))
		end

	if @type = 'others'
		begin
			set @Output_Ft2 = dbo.Loading_get_other_output_Ft2('others',@plant,@year,@period,@analyse_user)
			set @Output_amount = dbo.Loading_get_other_output_amount('others',@plant,@year,@period,@analyse_user)

			if(@Output_Ft2 = 0)
				set @ASP = 0
			else
				set @ASP = @Output_amount/@Output_Ft2
			--return cast(@ASP as decimal(18, 4))
		end
	if @type = 'Total'
		begin
			set @Output_Ft2 = dbo.Loading_get_other_output_Ft2('Total',@plant,@year,@period,@analyse_user)
			set @Output_amount = dbo.Loading_get_other_output_amount('Total',@plant,@year,@period,@analyse_user)

			if(@Output_Ft2 = 0)
				set @ASP = 0
			else
				set @ASP = @Output_amount/@Output_Ft2
			--return cast(@ASP as decimal(18, 4))
		end
	if @type = 'Total per week'
		begin 
			set @Output_Ft2 = dbo.Loading_get_other_output_Ft2('Total',@plant,@year,@period,@analyse_user)
			set @Output_amount = dbo.Loading_get_other_output_amount('Total',@plant,@year,@period,@analyse_user)
			if(@Output_Ft2 = 0)
				set @ASP = 0
			else
				set @ASP = @Output_amount/@Output_Ft2

			set @ASP = @ASP/@fweek
		end

	return cast(@ASP as decimal(18, 4))
end

GO
