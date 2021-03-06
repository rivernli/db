USE [Multek_AsiaHome]
GO
/****** Object:  View [dbo].[vwSuggestion]    Script Date: 2014/11/12 17:07:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwSuggestion]
AS
SELECT
      dbo.Mul_Suggestion.Sug_Id, dbo.Mul_Suggestion.Sug_CategoryId, 
      dbo.Mul_Suggestion.Sug_Subject, dbo.Mul_Suggestion.Sug_Description, 
      dbo.Mul_Suggestion.Sug_Ip, dbo.Mul_Suggestion.Sug_UpdateBy, 
      dbo.Mul_Suggestion.Sug_UpdateDate,
 dbo.Mul_Suggestion_Category.Sgc_Category
FROM dbo.Mul_Suggestion INNER JOIN
      dbo.Mul_Suggestion_Category ON 
      dbo.Mul_Suggestion.Sug_CategoryId = dbo.Mul_Suggestion_Category.Sgc_Id




GO
