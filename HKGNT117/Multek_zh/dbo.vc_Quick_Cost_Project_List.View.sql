USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vc_Quick_Cost_Project_List]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vc_Quick_Cost_Project_List]
AS
SELECT DISTINCT T$PJNO
FROM dbo.Cost_Sheet_Query_ProjectList WHERE T$PJNO LIKE '$%'


GO
