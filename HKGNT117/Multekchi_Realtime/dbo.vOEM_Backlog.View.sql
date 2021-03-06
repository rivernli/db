USE [multekchi_realtime]
GO
/****** Object:  View [dbo].[vOEM_Backlog]    Script Date: 2014/11/12 17:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[vOEM_Backlog]
as
select oem_name from dbo.vMKT_Backlog_CN_New group by oem_name
union all
select oem_name from dbo.vMKT_Backlog_DE_New group by oem_name
union all
select oem_name from dbo.vMKT_Backlog_BR_New group by oem_name
GO
