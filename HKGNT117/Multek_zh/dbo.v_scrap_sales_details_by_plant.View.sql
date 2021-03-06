USE [Multek_ZH]
GO
/****** Object:  View [dbo].[v_scrap_sales_details_by_plant]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[v_scrap_sales_details_by_plant]
as
select fiscalYearDesc as FY,t$prno as period,
case when t$plnt = '2f' then 'B2F' else
case when t$plnt = 'P2' then 'B1' else t$plnt end end as plant
,sum(t$amnt) as amt from v_scrap_sales_details 
group by fiscalYearDesc,t$prno,t$plnt 
GO
