USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vw_CalenderLDFY]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_CalenderLDFY]
as
SELECT     MAX(iDate) AS lastDate, fiscalYear
FROM         dbo.vw_calender_ext
GROUP BY fiscalYear;
GO
