USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vw_SupplierSummary_Log]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create view [dbo].[vw_SupplierSummary_Log]
as
select UserID,Operation,CONVERT(varchar,OperatedDate,120 ) as OperatedDate,Remark from SupplierSummary_Log 


GO
