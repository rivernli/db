USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[M6_auto_update_m6_Missdata_table - step 5]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[M6_auto_update_m6_Missdata_table - step 5]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE	@LOOP_H INT,@LOOP_V INT,@MAX INT,@LOOP_NUMBER NVARCHAR(2),@NUMBER INT,@sqlString	NVARCHAR(MAX)

    -- Insert statements for procedure here
	--IF NOT EXISTS(SELECT * FROM sysobjects where id = object_id('dbo.dbo.M6_Matrix_missData') and type = 'U')
	--	SELECT * INTO dbo.dbo.M6_Matrix_missData FROM dbo.M6_Matrix_Red WHERE 1 <> 1
		
	-- INIT MISSDATA TABLE 
	TRUNCATE TABLE dbo.M6_Matrix_missData_Red
	INSERT INTO dbo.M6_Matrix_missData_Red(Period)
	SELECT Period FROM dbo.M6_Matrix_Red

	TRUNCATE TABLE dbo.M6_Matrix_missData_Blue
	INSERT INTO dbo.M6_Matrix_missData_Blue(Period)
	SELECT Period FROM dbo.M6_Matrix_Red

	-- calc red miss data
	SELECT @MAX = MAX(ID) FROM dbo.M6_Matrix_Red
	SET @LOOP_H = 1
	WHILE @LOOP_H < 50
		BEGIN
			SET @NUMBER = 1
			SET @LOOP_V = 1
			WHILE @LOOP_V <=@MAX
				BEGIN
					SET @sqlString = 'SELECT @LOOP_NUMBER = [' + CAST(@LOOP_H AS NVARCHAR(2)) + '] FROM dbo.M6_Matrix_Red WHERE ID = '+CAST(@LOOP_V AS NVARCHAR(5))
					EXEC SP_EXECUTESQL @sqlString,N'@LOOP_NUMBER NVARCHAR(2) OUTPUT',@LOOP_NUMBER OUTPUT
					
					SET @LOOP_NUMBER= ISNULL(@LOOP_NUMBER,'')
					IF @LOOP_NUMBER <> ''
						BEGIN
							SET @NUMBER = 1
						END
					ELSE
						BEGIN
							SET @sqlString = 'UPDATE dbo.M6_Matrix_missData_Red SET ['+CAST(@LOOP_H AS NVARCHAR(3))+'] = '+CAST(@NUMBER AS NVARCHAR(10))+' FROM dbo.M6_Matrix_missData_Red WHERE ID = '+CAST(@LOOP_V AS NVARCHAR(5))
							EXEC (@sqlString)
							SET @NUMBER = @NUMBER + 1
						END 
					SET @LOOP_V = @LOOP_V + 1
				END
			SET @LOOP_H = @LOOP_H + 1
		END
		
	-- calc Blue miss data
	SELECT @MAX = MAX(ID) FROM dbo.M6_Matrix_Blue
	SET @LOOP_H = 1
	WHILE @LOOP_H < 50
		BEGIN
			SET @NUMBER = 1
			SET @LOOP_V = 1
			WHILE @LOOP_V <=@MAX
				BEGIN
					SET @sqlString = 'SELECT @LOOP_NUMBER = [' + CAST(@LOOP_H AS NVARCHAR(2)) + '] FROM dbo.M6_Matrix_Blue WHERE ID = '+CAST(@LOOP_V AS NVARCHAR(5))
					EXEC SP_EXECUTESQL @sqlString,N'@LOOP_NUMBER NVARCHAR(2) OUTPUT',@LOOP_NUMBER OUTPUT
					
					SET @LOOP_NUMBER= ISNULL(@LOOP_NUMBER,'')
					IF @LOOP_NUMBER <> ''
						BEGIN
							SET @NUMBER = 1
						END
					ELSE
						BEGIN
							SET @sqlString = 'UPDATE dbo.M6_Matrix_missData_Blue SET ['+CAST(@LOOP_H AS NVARCHAR(3))+'] = '+CAST(@NUMBER AS NVARCHAR(10))+' FROM dbo.M6_Matrix_missData_Blue WHERE ID = '+CAST(@LOOP_V AS NVARCHAR(5))
							EXEC (@sqlString)
							SET @NUMBER = @NUMBER + 1
						END 
					SET @LOOP_V = @LOOP_V + 1
				END
			SET @LOOP_H = @LOOP_H + 1
		END
END

GO
