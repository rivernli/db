USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vw_4RP_HubOutByDate]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_4RP_HubOutByDate]
as
SELECT     iDate, OEM, SUM(amount) AS amt
FROM         dbo.vw_4RP_HUBOUT
GROUP BY iDate, OEM
GO
