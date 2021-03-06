USE [ContractTracker]
GO
/****** Object:  UserDefinedFunction [dbo].[fun_Get_Products_Name]    Script Date: 11/06/2014 15:55:54 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fun_Get_Products_Name]
	(
		@Products VARCHAR(1000)
	)
RETURNS VARCHAR(1000) AS  
BEGIN 
	DECLARE @ProductsName VARCHAR(1000)

	SET @ProductsName=''
	WHILE CHARINDEX(',',@Products)>0
		BEGIN
			SET @ProductsName=@ProductsName+(SELECT Name FROM Product WHERE AutoID=LEFT(@Products,CHARINDEX(',',@Products)-1))+','
			SET @Products=RIGHT(@Products,LEN(@Products)-CHARINDEX(',',@Products))
			
		END
	IF LEN(@ProductsName)>0
		BEGIN
			SET @ProductsName=LEFT(@ProductsName,LEN(@ProductsName)-1)
		END
	RETURN (ISNULL(@ProductsName,''))
END
GO
