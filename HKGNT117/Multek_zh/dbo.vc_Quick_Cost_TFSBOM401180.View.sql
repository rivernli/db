USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vc_Quick_Cost_TFSBOM401180]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vc_Quick_Cost_TFSBOM401180]
AS
SELECT * 
FROM dbo.Cost_Sheet_Query_TFSBOM401180
WHERE T$PJNO LIKE '$%'
GO
