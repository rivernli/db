USE [Multek_AsiaHome]
GO
/****** Object:  View [dbo].[vwCustomerVisitSchedule]    Script Date: 2014/11/12 17:07:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwCustomerVisitSchedule]
AS
SELECT dbo.Mul_CustomerVisitShedule.*,
	dbo.Mul_Site.Site_Code, 
      	dbo.Mul_Site.Site_Description
FROM dbo.Mul_CustomerVisitShedule INNER JOIN
      dbo.Mul_Site ON dbo.Mul_CustomerVisitShedule.Cust_SiteId = dbo.Mul_Site.Site_Id




GO
