USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[sp_Automatically_Recompile_StoreProcedure]    Script Date: 11/06/2014 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Automatically_Recompile_StoreProcedure]
AS

DECLARE @TableName VARCHAR(200),@RECompileString VARCHAR(2000)
DECLARE Table_C CURSOR FOR
SELECT Name FROM SysObjects WHERE XType='P' OR XType ='IF'

OPEN Table_C
FETCH NEXT FROM Table_C INTO @TableName

WHILE @@FETCH_STATUS=0
	BEGIN
		SET @RECompileString='SP_RECOMPILE '+@TableName
		EXECUTE (@RECompileString)
		FETCH NEXT FROM Table_C INTO @TableName
	END
CLOSE Table_C
DEALLOCATE Table_C
GO
