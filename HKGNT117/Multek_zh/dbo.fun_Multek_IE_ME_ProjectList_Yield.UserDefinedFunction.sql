USE [Multek_ZH]
GO
/****** Object:  UserDefinedFunction [dbo].[fun_Multek_IE_ME_ProjectList_Yield]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fun_Multek_IE_ME_ProjectList_Yield]
(
@Project	nvarchar(10)
)
RETURNS decimal(18,4)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Return_val DECIMAL(18,4)

	-- Add the T-SQL statements to compute the return value here
	SELECT TOP 1 @Return_val = T$busp FROM dbo.TFSBOM400180 WHERE t$pjno = @Project and t$stat = 2 order by t$sern desc

	-- Return the result of the function
	RETURN @Return_val

END

GO
