USE [AMD_Lab]
GO
/****** Object:  View [dbo].[2004-OCR]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[2004-OCR] as
SELECT tblAMDSamples.TN, tblAMDSamples.ReportTitle, '' AS Expr1, tblAMDSamples.YrBook, tblAMDSamples.AnalyticalTest
FROM tblAMDSamples
WHERE (((tblAMDSamples.TN) Between 1468 And 2257)) --AND (([tblAMDSamples].[Project Type])="Outgoing Cust Req"))
--ORDER BY tblAMDSamples.TN
GO
