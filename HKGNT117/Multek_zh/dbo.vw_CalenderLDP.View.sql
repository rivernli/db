USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vw_CalenderLDP]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--select * from dbo.vw_4RP_HubInvByDateCalender

create view [dbo].[vw_CalenderLDP]
as
select max(idate) as lastDate,iperiod from dbo.vw_calender_ext
group by iperiod 
--last day in every period

GO
