USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vc_General_Cost_TFSBOM400180]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vc_General_Cost_TFSBOM400180]
AS
SELECT * 
FROM dbo.Cost_Sheet_Query_TFSBOM400180
WHERE T$APRJ = ''
AND		T$PJNO NOT LIKE '@%'
AND		T$PJNO NOT LIKE '$%'

GO
