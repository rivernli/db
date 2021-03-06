USE [Multek_ZH_New]
GO
/****** Object:  StoredProcedure [dbo].[sp_sgp_savePriceOnly]    Script Date: 11/06/2014 15:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_sgp_savePriceOnly]
 @cost_id int, @price float, @qty int=0, @yield float = null,@terms nvarchar(100) = null
as 
declare @status tinyint
if(@yield is null )
	select @yield=yield from vw_sgp_cost where id=@cost_id
	
select @status = status from sgp_pricing where cost_id= @cost_id and status >0

if(@status is null)
	insert into sgp_pricing (cost_id,price,qty,yield,status,create_date,payment_terms)
	values (@cost_id,@price,@qty,@yield,1,getdate(),@terms)
if(@status=1)
begin
	update sgp_pricing set price=@price,qty=@qty, yield=@yield, last_update=getdate()
	where cost_id=@cost_id and status=@status
	if(@terms is not null)
		update sgp_pricing set payment_terms=@terms where cost_id=@cost_id
end
GO
