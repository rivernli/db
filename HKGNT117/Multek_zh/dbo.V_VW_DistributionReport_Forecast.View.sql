USE [Multek_ZH]
GO
/****** Object:  View [dbo].[V_VW_DistributionReport_Forecast]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[V_VW_DistributionReport_Forecast]
as
select * from [HKGNT111].[Multek_SZ_New].[dbo].[DistributionReport_Forecast] 

GO
