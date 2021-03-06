USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Get_Germany_Ledger_Quarter_3_1]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Get_Germany_Ledger_Quarter_3_1] 
	-- Add the parameters for the stored procedure here
	@Year CHAR(4),
	@Quarter INT,
	@Amount BIGINT OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @Amount_Credit  NUMERIC(19,2)
	DECLARE @Amount_Debit	NUMERIC(19,2),@SQLString VARCHAR(MAX),@PeriodFrom INT,@PeriodTo INT

	SET @Amount		   = 0
	SET @Amount_Credit = 0
	SET @Amount_Debit  = 0

	SET @PeriodFrom=(CASE WHEN @Quarter=1 THEN 1 WHEN @Quarter=2 THEN 4 WHEN @Quarter=3 THEN 7 ELSE 10 END)
	SET @PeriodTo=(CASE WHEN @Quarter=1 THEN 3 WHEN @Quarter=2 THEN 6 WHEN @Quarter=3 THEN 9 ELSE 12 END)

	-- Calcate 858 adjust amount
		IF EXISTS(SELECT * FROM SysObjects WHERE ID=Object_ID('TempCreditDebit') AND XType='U')
			BEGIN
				DROP TABLE TempCreditDebit
			END
		SET @SQLString='SELECT * INTO TempCreditDebit FROM OPENQUERY([10.10.8.226],'+''''+ 'SELECT  ISNULL(SUM(ISNULL(A.T$AMTH$2,0)),0) AS Amount FROM MultekGer.dbo.TTFGLD106189 AS A WHERE A.T$FYER='+CONVERT(VARCHAR(4),CONVERT(INT,@Year)+1)+' AND A.T$FPRD BETWEEN '+CONVERT(VARCHAR(2),@PeriodFrom)+' AND '+CONVERT(VARCHAR(2),@PeriodTo)+'  AND A.T$DBCR = 2 and t$leac >=''''300000'''' and t$leac <''''400000'''' and t$leac <> ''''340000'''''+''''+')'
		EXECUTE (@SQLString)

		SET @Amount_Credit = 
		(
			SELECT  Amount 
			FROM TempCreditDebit
		)

		IF EXISTS(SELECT * FROM SysObjects WHERE ID=Object_ID('TempCreditDebit') AND XType='U')
			BEGIN
				DROP TABLE TempCreditDebit
			END
		SET @SQLString='SELECT * INTO TempCreditDebit FROM OPENQUERY([10.10.8.226],'+''''+ 'SELECT  ISNULL(SUM(ISNULL(A.T$AMTH$2,0)),0) AS Amount FROM MultekGer.dbo.TTFGLD106189 AS A WHERE A.T$FYER='+CONVERT(VARCHAR(4),CONVERT(INT,@Year)+1)+' AND A.T$FPRD BETWEEN '+CONVERT(VARCHAR(2),@PeriodFrom)+' AND '+CONVERT(VARCHAR(2),@PeriodTo)+'  AND A.T$DBCR = 1 and t$leac >=''''300000'''' and t$leac <''''400000'''' and t$leac <> ''''340000'''''+''''+')'
		EXECUTE (@SQLString)
		SET @Amount_Debit = 
		(
			SELECT  Amount 
			FROM TempCreditDebit
		)
		IF EXISTS(SELECT * FROM SysObjects WHERE ID=Object_ID('TempCreditDebit') AND XType='U')
			BEGIN
				DROP TABLE TempCreditDebit
			END
		
		SET @Amount = ISNULL(@Amount_Credit,0)-ISNULL(@Amount_Debit,0)
END
GO
