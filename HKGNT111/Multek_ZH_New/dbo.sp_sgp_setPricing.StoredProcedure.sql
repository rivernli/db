USE [Multek_ZH_New]
GO
/****** Object:  StoredProcedure [dbo].[sp_sgp_setPricing]    Script Date: 11/06/2014 15:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_sgp_setPricing]
 @cost_id int, @price float, @qty int=0, @yield float = null,@terms nvarchar(100) = null
as 
/*
declare @cost_id int, @price float, @qty int, @yield float
select @cost_id=4,@price = 12.34,@qty=1000
*/

exec [sp_sgp_savePriceOnly] @cost_id,@price,@qty,@yield,@terms;

select * from dbo.vw_SGP_pricing_simAll where costId=@cost_id
GO
