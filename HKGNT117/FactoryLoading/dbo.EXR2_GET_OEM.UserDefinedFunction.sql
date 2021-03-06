USE [FactoryLoading]
GO
/****** Object:  UserDefinedFunction [dbo].[EXR2_GET_OEM]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[EXR2_GET_OEM]
(
	@Porject	NVARCHAR(30)
)
RETURNS NVARCHAR(30)
AS
BEGIN
	-- Declare the return variable here
		DECLARE @OEM_NAME	NVARCHAR(30)

		SET @OEM_NAME = ''
		SET @Porject = LTRIM(RTRIM(@Porject))
		SET @Porject = ISNULL(@Porject,'')

	-- Add the T-SQL statements to compute the return value here
		SELECT @OEM_NAME = MCS044.T$DSCA FROM dbo.TTIITM001180 AS ITM001
			LEFT OUTER JOIN dbo.TTCMCS044180  AS MCS044
			ON	MCS044.T$CSGP = ITM001.T$CSGP
		WHERE	ITM001.T$ITEM = @Porject

	-- Return the result of the function
		RETURN @OEM_NAME

END

GO
