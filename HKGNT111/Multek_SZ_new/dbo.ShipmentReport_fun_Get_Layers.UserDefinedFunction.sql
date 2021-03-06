USE [Multek_SZ_New]
GO
/****** Object:  UserDefinedFunction [dbo].[ShipmentReport_fun_Get_Layers]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[ShipmentReport_fun_Get_Layers]
(
	-- Add the parameters for the function here
	@Item VARCHAR(500)
)
RETURNS INT
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ResultLayer CHAR(2),@i INT,@Layer INT

	-- Add the T-SQL statements to compute the return value here
	IF LEFT(@Item,3)<>'TCC' AND LEFT(@Item,3)<>'TTC'
		BEGIN
			IF LEN(@Item)=8
				BEGIN
					SET @ResultLayer=SUBSTRING(@Item,2,2) 
				END
			IF LEN(@Item)>8
				BEGIN
					SET @i=1
					WHILE @i<=LEN(@Item)
						BEGIN
							IF SUBSTRING(@Item,@i,1)='-' OR SUBSTRING(@Item,@i,1)='_'
								BEGIN
									SET @ResultLayer=SUBSTRING(@Item,@i+2,2)
									BREAK 
								END
							SET @i=@i+1
						END
					--SET @ResultLayer=SUBSTRING(@Item,2,2) 
				END
			-- Return the result of the function
			SET @ResultLayer=(CASE WHEN LEFT(@ResultLayer,1) NOT IN('0','1','2','3','4','5','6','7','8','9')OR RIGHT(@ResultLayer,1) NOT IN('0','1','2','3','4','5','6','7','8','9') THEN NULL ELSE @ResultLayer END)
			SET @Layer=@ResultLayer
		END
	RETURN (@Layer)

END
GO
