USE [Multek_SZ_New]
GO
/****** Object:  UserDefinedFunction [dbo].[ShipmentReport_fun_Get_Sum_Fiscal_Quarter_JVM_Display_3_1]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[ShipmentReport_fun_Get_Sum_Fiscal_Quarter_JVM_Display_3_1]
(
	-- Add the parameters for the function here
	@Year CHAR(4),
	@Quarter INT
)
RETURNS NUMERIC(19,2)
AS
BEGIN
	DECLARE	@Amount			DECIMAL(19,2)
	DECLARE @Amount_Credit  NUMERIC(19,2)
	DECLARE @Amount_Debit	NUMERIC(19,2)
	DECLARE	@AmountTotal	DECIMAL(19,2)
	DECLARE @PeriodFrom INT,@PeriodTo INT,@i INT

	-- Add the T-SQL statements to compute the return value here
	SET @PeriodFrom=(CASE WHEN @Quarter=1 THEN 1 WHEN @Quarter=2 THEN 4 WHEN @Quarter=3 THEN 7 ELSE 10 END)
	SET @PeriodTo=(CASE WHEN @Quarter=1 THEN 3 WHEN @Quarter=2 THEN 6 WHEN @Quarter=3 THEN 9 ELSE 12 END)

	SET @Amount		   = 0
	SET @Amount_Credit = 0
	SET @Amount_Debit  = 0

	SET @AmountTotal =0
	-- Calcate 858 adjust amount
		SET @Amount_Credit = 
		(
			SELECT  ISNULL(SUM(ISNULL(A.T$AMTH$1,0)),0) AS Amount FROM TTFGLD106858 AS A 
			WHERE A.T$FYER = CONVERT(VARCHAR(4),CONVERT(INT,@Year)+0)
			and t$fprd BETWEEN @PeriodFrom AND @PeriodTo
			AND	  A.T$LEAC BETWEEN '300000' AND '400000'
			AND	  A.T$DBCR = 2
			AND   A.t$leac <>'300199'
		)

		SET @Amount_Debit = 
		(
			SELECT  ISNULL(SUM(ISNULL(A.T$AMTH$1,0)),0) AS Amount FROM TTFGLD106858 AS A 
			WHERE A.T$FYER = CONVERT(VARCHAR(4),CONVERT(INT,@Year)+0)
			and t$fprd BETWEEN @PeriodFrom AND @PeriodTo
			AND	  A.T$LEAC BETWEEN '300000' AND '400000'
			AND	  A.T$DBCR = 1
			AND   A.t$leac <>'300199'
		)	
		
		SET @Amount =  ISNULL(@Amount_Credit,0)-ISNULL(@Amount_Debit,0)

		-- Calcate 888 adjust amount
		SET @Amount_Credit = 
		(
			SELECT  ISNULL(SUM(ISNULL(A.T$AMTH$1,0)),0) AS Amount FROM TTFGLD106888 AS A 
			WHERE A.T$FYER = CONVERT(VARCHAR(4),CONVERT(INT,@Year)+0)
			and t$fprd BETWEEN @PeriodFrom AND @PeriodTo
			AND	  A.T$LEAC BETWEEN '300000' AND '400000'
			AND	  A.T$DBCR = 2
			AND   A.t$leac <>'300199'
		)

		SET @Amount_Debit = 
		(
			SELECT  ISNULL(SUM(ISNULL(A.T$AMTH$1,0)),0) AS Amount FROM TTFGLD106888 AS A 
			WHERE A.T$FYER = CONVERT(VARCHAR(4),CONVERT(INT,@Year)+0)
			and t$fprd BETWEEN @PeriodFrom AND @PeriodTo
			AND	  A.T$LEAC BETWEEN '300000' AND '400000'
			AND	  A.T$DBCR = 1
			AND   A.t$leac <>'300199'
		)	
	SET @Amount = @Amount+ISNULL(@Amount_Credit,0)-ISNULL(@Amount_Debit,0)

	SET @AmountTotal=@AmountTotal+@Amount
	
	RETURN( ROUND(ISNULL(@AmountTotal,0),0))

END
GO
