USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[IES_sp_Import_AttritionRate]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[IES_sp_Import_AttritionRate] 	
		@FILEPATH VARCHAR(1000),
		@Building VARCHAR(10)
AS

DECLARE @SQLSTR VARCHAR(2000)
SET @SQLSTR = 
	'SELECT Project, AttritionRate INTO #A 
		FROM OPENROWSET(''Microsoft.Jet.OLEDB.4.0'', 
						''Excel 8.0;DATABASE='+@FILEPATH+';HDR=YES;IMEX=1'', 
						''SELECT * FROM [AttritionRate$]'');
	UPDATE t
		SET t.AttritionRate = (SELECT AttritionRate FROM #A WHERE Project = t.Project)
	FROM IES_PJDatabase t
		WHERE t.Building = '''+@Building+''' AND t.Project IN(SELECT Project FROM #A);
	DROP TABLE #A;'

				
EXEC(@SQLSTR)


GO
