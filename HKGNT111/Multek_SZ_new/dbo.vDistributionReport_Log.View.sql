USE [Multek_SZ_New]
GO
/****** Object:  View [dbo].[vDistributionReport_Log]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vDistributionReport_Log]
as
select UserID as UID,OperatedDate as ActionTime,Operation as [action],Remark as [description],'' as URL
from DistributionReport_Log
GO
