USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vw_production_with_no_bom_withQ_report]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[vw_production_with_no_bom_withQ_report]
as
select *,dbo.fx_getQuarter(issue_date) as quarter from vw_production_with_no_bom_report;

GO
