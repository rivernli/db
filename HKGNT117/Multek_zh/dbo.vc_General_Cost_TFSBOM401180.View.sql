USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vc_General_Cost_TFSBOM401180]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vc_General_Cost_TFSBOM401180]
AS
SELECT A.* 
FROM dbo.Cost_Sheet_Query_TFSBOM401180 AS A
WHERE A.T$PJNO IN 
(
	SELECT B.T$PJNO FROM dbo.vc_General_Cost_Project_List AS B
)

GO
