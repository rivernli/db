USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[M6_auto_update_m6_to_analysis_table - step 2]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[M6_auto_update_m6_to_analysis_table - step 2] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE	@LOOP INT,@INTER_LOOP INT
	DECLARE	@MAX INT,@NUMBER	INT,@rowID INT
	DECLARE	@PERIOD DATETIME
	DECLARE	@sqlString	NVARCHAR(MAX)

    -- Insert statements for procedure here
	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('tempdb.#temp') AND TYPE = 'U')
		Drop table #temp

	TRUNCATE TABLE M6_MATRIX_Red
	TRUNCATE TABLE M6_MATRIX_Blue

	SELECT ROW_NUMBER() OVER(ORDER BY DATE ASC) AS ID,DATE INTO #temp FROM M6 
	WHERE DATE NOT IN(SELECT PERIOD FROM M6_MATRIX_Red) GROUP BY DATE
	
	IF @@ROWCOUNT >0
		BEGIN
			SELECT @MAX = MAX(ID) FROM #temp
			SET @LOOP = 1

			WHILE @LOOP <= @MAX
				BEGIN
					SELECT @PERIOD = [DATE] FROM #temp WHERE ID = @LOOP
					INSERT INTO M6_MATRIX_Red(PERIOD) VALUES(@PERIOD)
					INSERT INTO M6_MATRIX_Blue(PERIOD) VALUES(@PERIOD)
					--SET @rowID = SCOPE_IDENTITY()
					SELECT @rowID = MAX(ID) FROM M6_MATRIX_Red
				
					SELECT @NUMBER = NUMBER FROM M6 WHERE DATE = @PERIOD AND ISSP = 1
					SET @sqlString = 'UPDATE M6_MATRIX_Blue SET ['+CAST(@NUMBER AS NVARCHAR(2))+'] = '+CAST(@NUMBER AS NVARCHAR(2))+' FROM M6_MATRIX_Blue WHERE ID = '+CAST(@rowID AS NVARCHAR(4))
					EXEC (@sqlString)

					IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('tempdb.#temp_M6') AND TYPE = 'U')
						Drop table #temp_M6

					SELECT ROW_NUMBER() OVER(ORDER BY DATE ASC) ID,* INTO #temp_M6 FROM M6 WHERE DATE = @PERIOD AND ISSP = 0
					SET @INTER_LOOP = 1
					WHILE @INTER_LOOP < 7
						BEGIN
							SELECT @NUMBER = NUMBER FROM #temp_M6 WHERE ID = @INTER_LOOP
							SET @sqlString = 'UPDATE M6_Matrix_Red SET ['+CAST(@NUMBER AS NVARCHAR(2))+'] = '+CAST(@NUMBER AS NVARCHAR(2))+' FROM M6_Matrix_Red WHERE ID = '+CAST(@rowID AS NVARCHAR(4))
							EXEC (@sqlString)
							SET @INTER_LOOP = @INTER_LOOP + 1
						END
					SET @LOOP = @LOOP + 1
					Drop table #temp_M6
				END
		END
END

GO
