USE [FactoryLoading]
GO
/****** Object:  UserDefinedFunction [dbo].[fun_Get_Nearest_Record]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fun_Get_Nearest_Record]
(
	-- Add the parameters for the function here
	@PJNO VARCHAR(50),
	@Date DATETIME
)
RETURNS VARCHAR(50)
AS
BEGIN
	DECLARE @Return VARCHAR(50),@SERN INT

	-- Add the T-SQL statements to compute the return value here
	SET @PJNO=@PJNO+'%'
	SET @SERN=(
					SELECT MAX(T$SERN)
					FROM TFSBOM400180 WITH (INDEX (ProjectLCDate))
					WHERE T$PJNO LIKE @PJNO
							AND T$LCDT<=@Date
				)
	IF @SERN IS NOT NULL
		BEGIN
				SET @Return=(SELECT TOP 1 T$PJNO FROM TFSBOM400180 WHERE T$PJNO LIKE @PJNO AND T$SERN=@SERN ORDER BY T$LCDT DESC)+','+CONVERT(VARCHAR(10),@SERN)
		END
	ELSE
		BEGIN
			SET @SERN=(
							SELECT MIN(T$SERN)
							FROM TFSBOM400180 WITH (INDEX (ProjectLCDate))
							WHERE T$PJNO LIKE @PJNO
								AND T$LCDT>@Date
						)
			SET @Return=(SELECT TOP 1 T$PJNO FROM TFSBOM400180 WHERE T$PJNO LIKE @PJNO AND T$SERN=@SERN ORDER BY T$LCDT ASC)+','+CONVERT(VARCHAR(10),@SERN)
		END
			
	-- Return the result of the function
	RETURN @Return

END

GO
