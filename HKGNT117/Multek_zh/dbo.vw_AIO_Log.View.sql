USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vw_AIO_Log]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[vw_AIO_Log]
as
select uid,actionTime,action,description,url,'hub' as logType from HUBINV_log
union all
select uid,actionTime,action,description,url,'mcos' from dbo.MCOS_log
union all
select uid,actionTime,action,description,url,'noninventory' from dbo.nonInventory_log
GO
