USE [BOC]
GO
/****** Object:  UserDefinedFunction [dbo].[Exr2_fun_GetParentMenuName]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[Exr2_fun_GetParentMenuName]
	(
		@MenuID VARCHAR(50) 
	)  
RETURNS VARCHAR(8000) AS  
BEGIN 
	DECLARE @MenuName VARCHAR(8000),@SourceMenuID VARCHAR(50),@i INT
	
	SET @MenuName=''	
	SET @SourceMenuID=''
	SET @i=1

	WHILE  @i<=LEN(@MenuID)/5
		BEGIN
			SET @SourceMenuID= LEFT(@MenuID,@i*5)
			SET @MenuName=@MenuName+' -> '+(SELECT [Description] FROM [Exr2_Menu] WHERE [ID]=@SourceMenuID)
			SET @i=@i+1
		END

	RETURN (RIGHT(@MenuName,LEN(@MenuName)-4))
 
END










GO
