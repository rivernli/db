USE [Multek_ZH]
GO
/****** Object:  View [dbo].[V_VWFSOLP109180]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[V_VWFSOLP109180]
as
select (CASE T$PLNT WHEN 'B1' THEN 'P2' ELSE T$PLNT END)AS Plant,* from [HKGNT111].[Multek_SZ_New].[dbo].[TFSOLP109180]
 
GO
