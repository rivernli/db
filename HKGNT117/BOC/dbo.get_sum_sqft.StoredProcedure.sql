USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[get_sum_sqft]    Script Date: 2014/11/12 17:02:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create proc [dbo].[get_sum_sqft]
@fiscal_year int,
@fiscal_perild int,
@plant nvarchar(10),
@Layer nvarchar(10),
@change_value int,
@customer nvarchar(50)
as
declare @output_val float
begin 
select	@output_val = (@change_value * (cast(count(right(left([projects(8)],3),2))*1.00/(select count(*) from dbo.tfsboc100180 
												where fiscal_year = @fiscal_year
												and fiscal_period = @fiscal_perild
												and customer_name = @customer
												and plant = @plant) as decimal(18, 4))))
from dbo.tfsboc100180
where fiscal_year = @fiscal_year
and fiscal_period = @fiscal_perild
and plant = @plant
and right(left([projects(8)],3),2) = @Layer
and customer_name = @customer

return @output_val
end


GO
