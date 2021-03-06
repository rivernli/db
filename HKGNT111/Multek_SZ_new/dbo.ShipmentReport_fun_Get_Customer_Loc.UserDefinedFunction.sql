USE [Multek_SZ_New]
GO
/****** Object:  UserDefinedFunction [dbo].[ShipmentReport_fun_Get_Customer_Loc]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[ShipmentReport_fun_Get_Customer_Loc]
(
	-- Add the parameters for the function here
	@Customer VARCHAR(500)
)
RETURNS VARCHAR(500)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Return VARCHAR(500),@Loc VARCHAR(10)

	-- Add the T-SQL statements to compute the return value here
	SET @Return=''

	DECLARE Loc_C CURSOR FOR
	SELECT Loc FROM ShipmentReport_Shipped_All
	WHERE [Customer Name] = @Customer
		AND RTRIM(ISNULL(Loc,''))<>''
	GROUP BY Loc
	ORDER BY Loc
	
	OPEN Loc_C
	FETCH NEXT FROM Loc_C INTO @Loc
	WHILE @@FETCH_STATUS=0
		BEGIN
			SET @Return=@Return+@Loc+','
			FETCH NEXT FROM Loc_C INTO @Loc
		END
	CLOSE Loc_C
	DEALLOCATE Loc_C

	-- Return the result of the function
	IF LEN(@Return)>0
		BEGIN
			SET @Return=LEFT(@Return,LEN(@Return)-1)
		END
	RETURN (@Return)

END
GO
