USE [Multek_ZH]
GO
/****** Object:  View [dbo].[v_scrap_sales_details_by_items]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[v_scrap_sales_details_by_items]
as
select fiscalYearDesc as fy,t$prno as period,isnull(Name,'Other') as itemName,
sum(t$amnt) as amt
from v_scrap_sales_details as a left join dbo.Scrap_Sales_ItemsGroup as b 
on a.t$item=b.no group by fiscalYearDesc,t$prno,t$item,Name 

GO
