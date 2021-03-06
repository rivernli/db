USE [Multek_ZH]
GO
/****** Object:  View [dbo].[Delivery_GetAISPN]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



create view [dbo].[Delivery_GetAISPN]
as
select item,convert(varchar(20),Sflf) as Shelflife from HKGNT137.misDB.dbo.tAttr_board
UNION ALL 
select item,convert(varchar(20),Sflf) as Shelflife from HKGNT137.misDB.dbo.tAttr_foil
UNION ALL
select item,convert(varchar(20),Sflf) as Shelflife from HKGNT137.misDB.dbo.tAttr_dryfilm
UNION ALL
select item,convert(varchar(20),Sflf) as Shelflife FROM  HKGNT137.misDB.dbo.tAttr_laminate 
UNION ALL
select item,convert(varchar(20),Sflf) as Shelflife from  HKGNT137.misDB.dbo.tAttr_prepreg 
UNION ALL
select item,convert(varchar(20),Sflf) as Shelflife from  HKGNT137.misDB.dbo.tAttr_rcc
UNION ALL
select item,convert(varchar(20),Sflf) as Shelflife from HKGNT137.misDB.dbo.tAttr_smcm
UNION ALL 
select item,convert(varchar(20),Sflf) as Shelflife from HKGNT137.misDB.dbo.tAttr_general 
UNION ALL
select item,convert(varchar(20),Sflf) as Shelflife from HKGNT137.misDB.dbo.tAttr_fccl 
UNION ALL
select item,convert(varchar(20),Sflf) as Shelflife from HKGNT137.misDB.dbo.tAttr_coverlay
UNION ALL 
select item,convert(varchar(20),Sflf) as Shelflife from HKGNT137.misDB.dbo.tAttr_adhesive 
UNION ALL
select item,convert(varchar(20),Sflf) as Shelflife from HKGNT137.misDB.dbo.tAttr_stiffener
UNION ALL 
select item,convert(varchar(20),Sflf) as Shelflife from HKGNT137.misDB.dbo.tAttr_sheildling_film
UNION ALL
select item,convert(varchar(20),Sflf) as Shelflife from HKGNT137.misDB.dbo.tAttr_chemical 
UNION ALL
select item,convert(varchar(20),Sflf) as Shelflife from HKGNT137.misDB.dbo.tAttr_smd 
UNION ALL
select item,convert(varchar(20),Sflf) as Shelflife from HKGNT137.misDB.dbo.tAttr_metal
UNION ALL
select item,convert(varchar(20),Sflf) as Shelflife from HKGNT137.misDB.dbo.tAttr_packing 
UNION ALL
select item,convert(varchar(20),Sflf) as Shelflife from HKGNT137.misDB.dbo.tAttr_non_inventory

GO
