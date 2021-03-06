USE [BOC]
GO
/****** Object:  UserDefinedFunction [dbo].[Loading_get_other_ASP_Layer]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE function [dbo].[Loading_get_other_ASP_Layer](@type nvarchar(100),@plant nvarchar(10),@year int,@period int,@analyse_user nvarchar(50))
returns float
as
begin
	declare @ALC float
	declare @ASP$  float
	declare @ASP_Layer float

	if @type <> 'others' and @type <> 'Total' and @type <> 'Total per week' 
		begin
			set @ALC = dbo.Loading_get_other_Avg_Layer_Count(@type,@plant,@year ,@period ,@analyse_user)
			set @ASP$ = dbo.Loading_get_other_ASP(@type,@plant,@year ,@period ,@analyse_user)
			if @ALC = 0
				set @ASP_Layer = 0
			else
				set @ASP_Layer = @ASP$/@ALC

			if(@ASP_Layer = 0)
				set @ASP_Layer = 0
			else
				set @ASP_Layer = cast(@ASP_Layer as decimal(18, 4))
		end

	if @type = 'others'
		begin
			set @ALC = dbo.Loading_get_other_Avg_Layer_Count('others',@plant,@year ,@period ,@analyse_user)
			set @ASP$ = dbo.Loading_get_other_ASP('others',@plant,@year ,@period ,@analyse_user)
			if @ALC = 0
				set @ASP_Layer = 0
			else
				set @ASP_Layer = @ASP$/@ALC

			if(@ASP_Layer = 0)
				set @ASP_Layer = 0
			else
				set @ASP_Layer = cast(@ASP_Layer as decimal(18, 4))
		end
	if @type = 'Total'
		begin
			set @ALC = dbo.Loading_get_other_Avg_Layer_Count('Total',@plant,@year ,@period ,@analyse_user)
			set @ASP$ = dbo.Loading_get_other_ASP('Total',@plant,@year ,@period ,@analyse_user)
			IF @ALC = 0
				SET @ASP_Layer = 0
			ELSE
				set @ASP_Layer = @ASP$/@ALC

			if(@ASP_Layer = 0)
				set @ASP_Layer = 0
			else
				set @ASP_Layer = cast(@ASP_Layer as decimal(18, 4))
		end
	--if @type = 'Total per week'

	return @ASP_Layer
end

GO
