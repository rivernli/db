USE [Multek_ZH]
GO
/****** Object:  View [dbo].[v_scrap_sales_details_by_group2]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[v_scrap_sales_details_by_group2]
as
select FY,period,isnull(group2,'Other') as group2,sum(amt) as amt from (
select fiscalYearDesc as FY,t$prno as period,t$item as item,sum(t$amnt) as amt 
from v_scrap_sales_details group by fiscalYearDesc,t$prno,t$loca,t$item
) as a left join dbo.Scrap_Sales_ItemsGroup as b on item=b.no 
group by FY,period,group2

GO
