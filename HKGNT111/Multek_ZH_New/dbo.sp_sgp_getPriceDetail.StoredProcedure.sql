USE [Multek_ZH_New]
GO
/****** Object:  StoredProcedure [dbo].[sp_sgp_getPriceDetail]    Script Date: 11/06/2014 15:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_sgp_getPriceDetail] @cost_id int, @more bit =0
as
if(@more =0)
select * from dbo.vw_SGP_pricing_simALL where costid=@cost_id;
else
select * from dbo.vw_sgp_pricingDetail_PUAS where costid=@cost_id;
GO
