USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vc_General_Cost_Project_List]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[vc_General_Cost_Project_List]
AS
SELECT DISTINCT T$PJNO FROM dbo.Cost_Sheet_Query_ProjectList 
WHERE	T$APRJ = ''				-- Standart cost
AND		T$PJNO NOT LIKE '$%'	-- Quick cost 
AND		T$PJNO NOT LIKE '@%'	-- Simple cost


GO
