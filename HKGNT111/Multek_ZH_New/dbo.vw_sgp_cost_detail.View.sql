USE [Multek_ZH_New]
GO
/****** Object:  View [dbo].[vw_sgp_cost_detail]    Script Date: 11/06/2014 15:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[vw_sgp_cost_detail]
as 
select *, 1 - scrap_rate_being_used /100 as yield ,
set_pnl * Unit_Set as unit_pnl
from sgp_cost
GO
