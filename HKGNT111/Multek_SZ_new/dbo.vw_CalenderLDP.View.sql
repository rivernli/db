USE [Multek_SZ_New]
GO
/****** Object:  View [dbo].[vw_CalenderLDP]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_CalenderLDP]
as
SELECT     MAX(iDate) AS lastDate, iPeriod
FROM         dbo.vw_calender_ext
GROUP BY iPeriod
GO
