USE [Multek_SZ_New]
GO
/****** Object:  UserDefinedFunction [dbo].[ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM_Display]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[ShipmentReport_fun_Get_Sum_Fiscal_Period_JVM_Display]
(
	-- Add the parameters for the function here
	@Year CHAR(4),
	@Period INT
)
RETURNS NUMERIC(19,2)
AS
BEGIN
	DECLARE	@Amount			DECIMAL(19,2)
	DECLARE @Amount_Credit  NUMERIC(19,2)
	DECLARE @Amount_Debit	NUMERIC(19,2)

	SET @Amount		   = 0
	SET @Amount_Credit = 0
	SET @Amount_Debit  = 0

	-- Calcate 858 adjust amount
		SET @Amount_Credit = 
		(
			SELECT  SUM(ISNULL(A.T$AMTH$1,0)) AS Amount FROM ce3p1179.dbo.TTFGLD106858 AS A 
			WHERE A.T$FYER = @Year
			AND   A.T$FPRD = @Period
			AND	  A.T$LEAC BETWEEN '300000' AND '400000'
			AND	  A.T$DBCR = 2
			AND   A.T$OTYP <> 'U23'
			AND   A.T$OTYP <> 'JVM'
			--AND	  A.T$LEAC IN(SELECT M.T$LEAC FROM dbo.TTFGLD401858 AS M WHERE M.T$LCMP=179 AND M.T$TROR = 19 AND M.T$FITR=82 AND M.T$DBCR = 2 )
			AND	  NOT EXISTS(SELECT X.* FROM ce3p1179.dbo.TTDSLS401179 AS X WHERE X.T$TTYP = A.T$OTYP AND X.T$INVN = A.T$ODOC)
		)

		SET @Amount_Debit = 
		(
			SELECT  SUM(ISNULL(A.T$AMTH$1,0)) AS Amount FROM ce3p1179.dbo.TTFGLD106858 AS A 
			WHERE A.T$FYER = @Year
			AND   A.T$FPRD = @Period
			AND	  A.T$LEAC BETWEEN '300000' AND '400000'
			AND	  A.T$DBCR = 1
			AND   A.T$OTYP <> 'U23'
			AND   A.T$OTYP <> 'JVM'
			--AND	  A.T$LEAC IN(SELECT M.T$LEAC FROM dbo.TTFGLD401858 AS M WHERE M.T$LCMP=179 AND M.T$TROR = 19 AND M.T$FITR=82 AND M.T$DBCR = 2 )
			AND	  NOT EXISTS(SELECT X.* FROM ce3p1179.dbo.TTDSLS401179 AS X WHERE X.T$TTYP = A.T$OTYP AND X.T$INVN = A.T$ODOC)
		)	
		
		SET @Amount = ISNULL(@Amount_Credit,0)-ISNULL(@Amount_Debit,0)

		-- Calcate 888 adjust amount
		SET @Amount_Credit = 
		(
			SELECT  SUM(ISNULL(A.T$AMTH$1,0)) AS Amount FROM ce3p1179.dbo.TTFGLD106888 AS A 
			WHERE A.T$FYER = @Year
			AND   A.T$FPRD = @Period
			AND	  A.T$LEAC BETWEEN '300000' AND '400000'
			AND	  A.T$DBCR = 2
			AND   A.T$OTYP <> 'U23'
			AND   A.T$OTYP <> 'JVM'
			--AND	  A.T$LEAC IN(SELECT M.T$LEAC FROM dbo.TTFGLD401888 AS M WHERE M.T$LCMP=179 AND M.T$TROR = 19 AND M.T$FITR=82 AND M.T$DBCR = 2 )
			AND	  NOT EXISTS(SELECT X.* FROM ce3p1179.dbo.TTDSLS401179 AS X WHERE X.T$TTYP = A.T$OTYP AND X.T$INVN = A.T$ODOC)
		)

		SET @Amount_Debit = 
		(
			SELECT  SUM(ISNULL(A.T$AMTH$1,0)) AS Amount FROM ce3p1179.dbo.TTFGLD106888 AS A 
			WHERE A.T$FYER = @Year
			AND   A.T$FPRD = @Period
			AND	  A.T$LEAC BETWEEN '300000' AND '400000'
			AND	  A.T$DBCR = 1
			AND   A.T$OTYP <> 'U23'
			AND   A.T$OTYP <> 'JVM'
			--AND	  A.T$LEAC IN(SELECT M.T$LEAC FROM dbo.TTFGLD401888 AS M WHERE M.T$LCMP=179 AND M.T$TROR = 19 AND M.T$FITR=82 AND M.T$DBCR = 2 )
			AND	  NOT EXISTS(SELECT X.* FROM ce3p1179.dbo.TTDSLS401179 AS X WHERE X.T$TTYP = A.T$OTYP AND X.T$INVN = A.T$ODOC)
		)	

		RETURN( ISNULL(@Amount,0) + (ISNULL(@Amount_Credit,0)-ISNULL(@Amount_Debit,0)))

RETURN @Amount_Credit

END
GO
