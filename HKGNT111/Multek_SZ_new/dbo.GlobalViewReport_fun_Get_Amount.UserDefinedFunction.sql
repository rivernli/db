USE [Multek_SZ_New]
GO
/****** Object:  UserDefinedFunction [dbo].[GlobalViewReport_fun_Get_Amount]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GlobalViewReport_fun_Get_Amount]
(
	-- Add the parameters for the function here
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
	IF @Plant<>'%B4VVI%' AND @Plant<>'%SUB%'
		BEGIN
			SET @ReturnValue=(
									SELECT SUM(T$AMNT) 
									FROM TFSOLP105180 
									WHERE  T$PLNT LIKE @Plant
										AND T$HKDT BETWEEN @DateFrom AND @DateTo
							)
		END
	IF @Plant='%B4VVI%' 
		BEGIN
			SET @ReturnValue=ISNULL((
									SELECT SUM(T$AMNT) 
									FROM TFSOLP105180 
									WHERE  T$PLNT ='B4'
										AND T$HKDT BETWEEN @DateFrom AND @DateTo
							),0)+
							ISNULL((
									SELECT SUM(T$AMNT) 
									FROM TFSOLP105180 
									WHERE  T$PLNT ='HK'
										AND T$HKDT BETWEEN @DateFrom AND @DateTo
							),0)
		END
	IF @Plant='%SUB%'
			SET @ReturnValue=(
									SELECT SUM(T$AMNT) 
									FROM TFSOLP105180 
									WHERE  T$PLNT ='HK'
										AND (T$cotp='CNG' OR T$cotp='SLS')
										AND T$HKDT BETWEEN @DateFrom AND @DateTo
							)
	
	-- Return the result of the function
	RETURN ISNULL(@ReturnValue,0)

END
GO
