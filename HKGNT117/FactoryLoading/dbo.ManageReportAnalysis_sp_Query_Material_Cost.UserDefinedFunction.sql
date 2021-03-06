USE [FactoryLoading]
GO
/****** Object:  UserDefinedFunction [dbo].[ManageReportAnalysis_sp_Query_Material_Cost]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[ManageReportAnalysis_sp_Query_Material_Cost]
(
	@Item		nvarchar(35),
	@Plant		nvarchar(10),
	@FYear		nvarchar(10),
	@FPeriod	nvarchar(10),
	@Type		nvarchar(10)
)
RETURNS decimal(18,4)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Return_cost	decimal(18,4)
	DECLARE	@Fiscal_Year	int
	DECLARE	@Fiscal_Period	int
	DECLARE @End_date		DATETIME

	IF @Plant = 'B1'
		SET @Plant = 'P2'

	SET @Fiscal_Year   = CAST(RIGHT(@FYear,4) AS INT) - 1
	SET @Fiscal_Period = CAST(RIGHT(@FPeriod,2) AS INT)

	SET @Fiscal_Period = @Fiscal_Period + 1
	IF @Fiscal_Period > 12
		BEGIN
			SET @Fiscal_Year = @Fiscal_Year + 1
			SET @Fiscal_Period = 1
		END

	SELECT @End_date = T$STDT FROM dbo.TTFGLD005180 WHERE t$ptyp = 1 AND t$year = @Fiscal_Year AND t$prno = @Fiscal_Period

	SET @End_date = @End_date - 1  

	IF @Type = 'INCLUDE'
		BEGIN
			SELECT top 1 @Return_cost = T$CISU FROM FACTORYLOADING.DBO.TFSBOM400180 
			WHERE LEFT(T$PJNO,8) = @Item
			AND T$PLNT = @Plant
			AND T$LCDT <= @End_date
			AND T$STAT = '2'
			ORDER BY T$LCDT DESC
		END

	IF @Type = 'EXCLUDE'
		BEGIN
			SELECT top 1 @Return_cost = T$CESU FROM FACTORYLOADING.DBO.TFSBOM400180 
			WHERE LEFT(T$PJNO,8) = @Item
			AND T$PLNT = @Plant
			AND T$LCDT <= @End_date
			AND T$STAT = '2'
			ORDER BY T$LCDT DESC
		END
	
	-- Return the result of the function
	RETURN @Return_cost
END

GO
