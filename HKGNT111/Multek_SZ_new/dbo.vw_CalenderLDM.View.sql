USE [Multek_SZ_New]
GO
/****** Object:  View [dbo].[vw_CalenderLDM]    Script Date: 11/06/2014 15:47:50 ******/
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
