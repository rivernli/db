USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vw_Supplier_info]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[vw_Supplier_info]
as
select '180' as Company,* from TTCCOM020180
union all
select '183' as Company,* from ttccom020183

GO
