USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vw_CalenderLDM]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_CalenderLDM]
as
SELECT     MAX(iDate) AS lastDate, iMonth
FROM         dbo.vw_calender_ext
GROUP BY iMonth

GO
