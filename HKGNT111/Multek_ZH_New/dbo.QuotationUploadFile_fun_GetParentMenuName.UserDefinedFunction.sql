USE [Multek_ZH_New]
GO
/****** Object:  UserDefinedFunction [dbo].[QuotationUploadFile_fun_GetParentMenuName]    Script Date: 11/06/2014 15:50:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create FUNCTION [dbo].[QuotationUploadFile_fun_GetParentMenuName]
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
			SET @MenuName=@MenuName+' -> '+(SELECT Description FROM QuotationUploadFile_Menu WHERE ID=@SourceMenuID)
			SET @i=@i+1
		END

	RETURN (RIGHT(@MenuName,LEN(@MenuName)-4))
 
END
GO
