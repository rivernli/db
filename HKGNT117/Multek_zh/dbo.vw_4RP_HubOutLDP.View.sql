USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vw_4RP_HubOutLDP]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_4RP_HubOutLDP]
as
select iperiod,vw_4RP_HubOutByDate.* 
from vw_CalenderLDP left join vw_4RP_HubOutByDate
on lastDate=iDate

GO
