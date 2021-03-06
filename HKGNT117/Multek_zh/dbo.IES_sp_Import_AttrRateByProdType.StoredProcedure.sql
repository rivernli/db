USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[IES_sp_Import_AttrRateByProdType]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[IES_sp_Import_AttrRateByProdType] 	
		@FILEPATH VARCHAR(1000),
		@Building VARCHAR(10)
AS
DECLARE @SQLSTR VARCHAR(2000)
SET @SQLSTR = 
	'SELECT '''+@Building+''' AS Building, [ProductionType/Configutation], AttritionRate INTO #A 
		FROM OPENROWSET(''Microsoft.Jet.OLEDB.4.0'', 
						''Excel 8.0;DATABASE='+@FILEPATH+';HDR=YES;IMEX=1'', 
						''SELECT * FROM [AttritionRate$]'');
	UPDATE t1
		SET t1.AttritionRate = t2.AttritionRate
	FROM IES_AttrRateByProdType t1 INNER JOIN #A t2 
		ON t1.[PCType]= t2.[ProductionType/Configutation] AND t1.Building = t2.Building
		WHERE t1.Building = '''+@Building+''' AND ISNULL(t2.AttritionRate, 0) <> 0;
	DROP TABLE #A;'

				
EXEC(@SQLSTR)



GO
