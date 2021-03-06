USE [Multek_SZ_New]
GO
/****** Object:  UserDefinedFunction [dbo].[DistributionReport_fun_Valid_SQL_String]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[DistributionReport_fun_Valid_SQL_String]
(
	-- Add the parameters for the function here
	@SourceSQLString VARCHAR(MAX)
)
RETURNS VARCHAR(MAX)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ValidSQLString VARCHAR(MAX)

	-- Add the T-SQL statements to compute the return value here
	SET @ValidSQLString=@SourceSQLString
	SET @ValidSQLString=REPLACE(@ValidSQLString,'&',' ')
	SET @ValidSQLString=REPLACE(@ValidSQLString,'''',' ')
	SET @ValidSQLString=REPLACE(@ValidSQLString,'/',' ')
	SET @ValidSQLString=REPLACE(@ValidSQLString,'\',' ')
	SET @ValidSQLString=RTRIM(@ValidSQLString)
	-- Return the result of the function
	RETURN (@ValidSQLString)

END
GO
