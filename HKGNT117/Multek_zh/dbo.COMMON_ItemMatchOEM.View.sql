USE [Multek_ZH]
GO
/****** Object:  View [dbo].[COMMON_ItemMatchOEM]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[COMMON_ItemMatchOEM]
as
select 
t$item as ITEM,
t$csgs as OEM,
T$DESC as OEM_Name
from DataWarehouse.dbo.DW_DIM_Item_Match_OEM
GO
