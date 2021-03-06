USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MRBST_Sycn_Suggestion]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_MRBST_Sycn_Suggestion]
AS

INSERT INTO MRBST_Suggestion
SELECT * FROM (
	SELECT DISTINCT 'Project' AS SuggestionType, Project AS SuggestionName FROM MRBST_Level33
	UNION ALL 
	SELECT DISTINCT 'Customer', Customer FROM MRBST_Level33
	UNION ALL 
	SELECT DISTINCT 'OEM', OEM FROM MRBST_Level33
	UNION ALL 
	SELECT DISTINCT 'Defect', Defect FROM MRBST_Level33
	UNION ALL 
	SELECT DISTINCT 'Technology', Technology FROM MRBST_Level33
	UNION ALL 
	SELECT DISTINCT 'Process', Process FROM MRBST_Level33
) AS TMP WHERE SuggestionName <> '' AND NOT EXISTS(
	SELECT * FROM MRBST_Suggestion WHERE SuggestionType=TMP.SuggestionType AND SuggestionName=TMP.SuggestionName
)

GO
