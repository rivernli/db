USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vw_E_quote_Supplier_VendorName]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[vw_E_quote_Supplier_VendorName]
as
select 
rtrim(OEM) as VendorName 
from ItemPriceMasterQuery_Data group by rtrim(OEM)  
GO
