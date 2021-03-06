USE [Multek_SZ_New]
GO
/****** Object:  UserDefinedFunction [dbo].[DistributionReport_fun_Get_RMA_Amount]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[DistributionReport_fun_Get_RMA_Amount]
(
	-- Add the parameters for the function here
	@Option VARCHAR(50),
	@Plant VARCHAR(10),
	@DateFrom DATETIME,
	@DateTo DATETIME
)
RETURNS BIGINT
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ReturnValue NUMERIC(18,0)

	SET @Plant=(CASE WHEN @Plant='ZhuHai' THEN '' ELSE @Plant END)
	SET @Plant='%'+(CASE @Plant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' WHEN 'VVI' THEN 'HK' ELSE @Plant END)+'%'

	-- Add the T-SQL statements to compute the return value here
	IF @Option='Lot'
			SET @ReturnValue=(
									SELECT COUNT(*)
									FROM ( 
											SELECT T$ORNO
											FROM TFSOLP109180 
											WHERE  T$PLNT LIKE @Plant
												AND T$Date BETWEEN @DateFrom AND @DateTo
											GROUP BY T$ORNO
										  ) a
							)
	IF @Option='Unit'
			SET @ReturnValue=(
									SELECT SUM(T$OQTY) 
									FROM TFSOLP109180 
									WHERE  T$PLNT LIKE @Plant
										AND T$Date BETWEEN @DateFrom AND @DateTo
							)
	IF @Option='SQFT'
			SET @ReturnValue=(
									SELECT SUM(T$AREA) 
									FROM TFSOLP109180 
									WHERE  T$PLNT LIKE @Plant
										AND T$Date BETWEEN @DateFrom AND @DateTo
							)
	
	IF @Option='COST'
			SET @ReturnValue=(
									SELECT SUM(T$AMNT) 
									FROM TFSOLP109180 
									WHERE  T$PLNT LIKE @Plant
										AND T$Date BETWEEN @DateFrom AND @DateTo
										AND ISNULL(T$AMNT,0)<>0
							)
	IF @Option='PCB'
			SET @ReturnValue=(
									SELECT SUM(ISNULL(T$OQTY,0) * ISNULL(t$cost,0)) 
									FROM TFSOLP109180 
									WHERE  T$PLNT LIKE @Plant
										AND T$Date BETWEEN @DateFrom AND @DateTo
										AND ISNULL(T$AMNT,0)<>0
							)
	-- Return the result of the function
	RETURN ABS(ISNULL(@ReturnValue,0))

END
GO
