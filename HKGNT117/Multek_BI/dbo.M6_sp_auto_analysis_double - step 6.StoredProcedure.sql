USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[M6_sp_auto_analysis_double - step 6]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[M6_sp_auto_analysis_double - step 6]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE	@LOOP INT
	DECLARE @sqlString NVARCHAR(MAX)
	
	TRUNCATE TABLE dbo.M6_Relation_double
	INSERT INTO  dbo.M6_Relation_double(ID)
	SELECT ID FROM dbo.M6_Matrix_Red
	
	SET @LOOP = 1
	WHILE @LOOP < 50
		BEGIN
			IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('tempdb.#mainTable') AND TYPE = 'U')
				DROP TABLE #mainTable
				
			--IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('tempdb.#subTable') AND TYPE = 'U')
			--	DROP TABLE #subTable
				
			CREATE TABLE #mainTable (AUTOID INT IDENTITY,ID INT,VALUE INT)
			
			SET @sqlString = 'INSERT INTO #mainTable(ID) SELECT ID FROM dbo.M6_Matrix_Red WHERE ['+CAST(@LOOP AS NVARCHAR(2))+'] = '+CAST(@LOOP AS NVARCHAR(2))
			EXEC (@sqlString)

			--SELECT * INTO #subTable FROM #mainTable
			
			UPDATE #mainTable SET ID = ID + 1
			
			SET @sqlString = 'UPDATE #mainTable SET VALUE = '+CAST(@LOOP AS NVARCHAR(2))+' FROM #mainTable AS A,dbo.M6_Matrix_Red AS B WHERE A.ID = B.ID AND ['+CAST(@LOOP AS NVARCHAR(2))+'] = '+CAST(@LOOP AS NVARCHAR(2))
			EXEC (@sqlString)
			
			SET @sqlString = 'UPDATE dbo.M6_Relation_double SET ['+CAST(@LOOP AS NVARCHAR(2))+'] = B.VALUE FROM dbo.M6_Relation_double AS A, #mainTable AS B WHERE A.ID=B.ID '
			EXEC (@sqlString)

			DROP TABLE #mainTable
			SET @LOOP = @LOOP + 1
		END
END

GO
