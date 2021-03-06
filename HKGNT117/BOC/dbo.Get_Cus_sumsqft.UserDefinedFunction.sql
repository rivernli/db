USE [BOC]
GO
/****** Object:  UserDefinedFunction [dbo].[Get_Cus_sumsqft]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE function [dbo].[Get_Cus_sumsqft]
(
@fiscal_year int,
@fiscal_perild int,
@plant nvarchar(10),
@Layer nvarchar(10),
@change_value int,
@customer nvarchar(50)
)
returns float
as
begin 
declare @output_val float

if exists(select count(*) from dbo.tfsboc100180_analyse where fiscal_year = @fiscal_year and fiscal_period = @fiscal_perild	and end_customer = @customer and plant = @plant)
	begin
		select	@output_val = (@change_value * (cast(count(right(left([projects(8)],3),2))*1.00/(select count(*) from dbo.tfsboc100180_analyse 
												where fiscal_year = @fiscal_year
												and fiscal_period = @fiscal_perild
												and end_customer = @customer
												and plant = @plant) as decimal(18, 4))))
		from dbo.tfsboc100180_analyse
		where fiscal_year = @fiscal_year
		and fiscal_period = @fiscal_perild
		and plant = @plant
		and right(left([projects(8)],3),2) = @Layer
		and end_customer = @customer
	end

	return @output_val
end

GO
