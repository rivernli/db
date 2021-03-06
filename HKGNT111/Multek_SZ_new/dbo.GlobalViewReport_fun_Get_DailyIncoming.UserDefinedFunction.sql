USE [Multek_SZ_New]
GO
/****** Object:  UserDefinedFunction [dbo].[GlobalViewReport_fun_Get_DailyIncoming]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[GlobalViewReport_fun_Get_DailyIncoming]
(
	-- Add the parameters for the function here
	@Plant VARCHAR(10),
	@DateFrom DATETIME,
	@DateTo DATETIME
)
RETURNS @DailyOEMCost TABLE 
(
	Date DATETIME,
	Amount NUMERIC(19,2)
)
AS
BEGIN
	-- Fill the table variable with the rows for your result set

	IF @Plant='B1'
		BEGIN
					INSERT INTO @DailyOEMCost
					SELECT T$TRDT AS Date,ISNULL(SUM(b.T$MAMT),0) AS Amount
					FROM TFSOLP121180 b
					WHERE T$DESC ='Order Intake'
						AND T$PLNT='P2'
						AND T$TRDT BETWEEN @DateFrom AND @DateTo	
					GROUP BY T$TRDT
		END
	IF @Plant='B2F'
		BEGIN
					INSERT INTO @DailyOEMCost
					SELECT T$TRDT AS Date,ISNULL(SUM(b.T$MAMT),0) AS Amount
					FROM TFSOLP121180 b
					WHERE T$DESC ='Order Intake'
						AND T$PLNT='2F'
						AND T$TRDT BETWEEN @DateFrom AND @DateTo	
					GROUP BY T$TRDT
		END
	IF @Plant='B3'
		BEGIN
					INSERT INTO @DailyOEMCost
					SELECT T$TRDT AS Date,ISNULL(SUM(b.T$MAMT),0) AS Amount
					FROM TFSOLP121180 b
					WHERE T$DESC ='Order Intake'
						AND T$PLNT='B3'
						AND T$TRDT BETWEEN @DateFrom AND @DateTo	
					GROUP BY T$TRDT
		END
	IF @Plant='B4'
		BEGIN
					INSERT INTO @DailyOEMCost
					SELECT T$TRDT AS Date,ISNULL(SUM(b.T$MAMT),0) AS Amount
					FROM TFSOLP121180 b
					WHERE T$DESC ='Order Intake'
						AND T$PLNT='B4'
						AND T$TRDT BETWEEN @DateFrom AND @DateTo	
					GROUP BY T$TRDT
		END
	IF @Plant='B5'
		BEGIN
					INSERT INTO @DailyOEMCost
					SELECT T$TRDT AS Date,ISNULL(SUM(b.T$MAMT),0) AS Amount
					FROM TFSOLP121180 b
					WHERE T$DESC ='Order Intake'
						AND T$PLNT='B5'
						AND T$TRDT BETWEEN @DateFrom AND @DateTo	
					GROUP BY T$TRDT
		END
	IF @Plant='VVI'
		BEGIN
					INSERT INTO @DailyOEMCost
					SELECT T$TRDT AS Date,ISNULL(SUM(b.T$MAMT),0) AS Amount
					FROM TFSOLP121180 b
					WHERE T$DESC ='Order Intake'
						AND T$PLNT='HK'
						AND T$COTP IN ('SLT','CLT')
						AND T$TRDT BETWEEN @DateFrom AND @DateTo	
					GROUP BY T$TRDT
		END
	IF @Plant='SUB'
		BEGIN
					INSERT INTO @DailyOEMCost
					SELECT T$TRDT AS Date,ISNULL(SUM(b.T$MAMT),0) AS Amount
					FROM TFSOLP121180 b
					WHERE T$DESC ='Order Intake'
						AND T$PLNT='HK'
						AND T$COTP IN ('SLS','CNG','BFS')
						AND T$TRDT BETWEEN @DateFrom AND @DateTo	
					GROUP BY T$TRDT
		END
	IF @Plant='Total'
		BEGIN
					INSERT INTO @DailyOEMCost
					SELECT T$TRDT AS Date,ISNULL(SUM(b.T$MAMT),0) AS Amount
					FROM TFSOLP121180 b
					WHERE T$DESC ='Order Intake'
						AND T$TRDT BETWEEN @DateFrom AND @DateTo	
					GROUP BY T$TRDT
		END

	RETURN 
END
GO
