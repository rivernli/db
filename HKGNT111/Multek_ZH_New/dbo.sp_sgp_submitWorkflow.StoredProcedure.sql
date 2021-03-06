USE [Multek_ZH_New]
GO
/****** Object:  StoredProcedure [dbo].[sp_sgp_submitWorkflow]    Script Date: 11/06/2014 15:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_sgp_submitWorkflow]
 @cost_id int, @price float, @qty int=0, @yield float = null,
@terms nvarchar(100) = null,
 @message nvarchar(100) output
as 

select @message = 'Cannot be saved, Already worked to workflow.'
--if (select status from dbo.sgp_pricing where cost_id=@cost_id) <= 1
if(select status from dbo.vw_SGP_pricing_simThin where costId=@cost_id) <=1
begin
	select @message = 'saved';
	exec [sp_sgp_savePriceOnly] @cost_id,@price,@qty,@yield,@terms;
	update dbo.sgp_pricing set status = 2 where cost_id=@cost_id;
end
GO
