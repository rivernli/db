USE [Multek_ZH_New]
GO
/****** Object:  View [dbo].[vw_sgp_quotation]    Script Date: 11/06/2014 15:50:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[vw_sgp_quotation]
as

select isnull(b.id,0) as cost_id,a.* from dbo.sgp_data as a left join dbo.sgp_cost as b
on a.id=b.sgp_id
GO
