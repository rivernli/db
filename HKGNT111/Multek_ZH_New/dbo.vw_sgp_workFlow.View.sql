USE [Multek_ZH_New]
GO
/****** Object:  View [dbo].[vw_sgp_workFlow]    Script Date: 11/06/2014 15:50:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[vw_sgp_workFlow]
as
select b.*,modDate from Workflow_Pricing.dbo.QuoteApproval as b 
left join Workflow_Pricing.dbo.WFModDate as c on b.id=c.id
GO
