USE [Multek_SZ_New]
GO
/****** Object:  UserDefinedFunction [dbo].[GlobalViewReport_fun_Get_B2B_By_Type]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GlobalViewReport_fun_Get_B2B_By_Type]
(
	-- Add the parameters for the function here
	@Type VARCHAR(50),
	@Plant VARCHAR(20),
	@DateFrom DATETIME,
	@DateTo DATETIME
)
RETURNS NUMERIC(19,4)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ReturnValue NUMERIC(19,4),@FGOutAccount NUMERIC(19,4),@OrderBookAccount NUMERIC(19,4)

	SET @Plant=(CASE WHEN @Plant='Total' THEN '' ELSE @Plant END)
	SET @Plant='%'+(CASE @Plant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' WHEN 'VVI' THEN 'HK' ELSE @Plant END)+'%'

	-- Add the T-SQL statements to compute the return value here
	IF @Type='FG OUT'
		BEGIN
			SET @ReturnValue=ISNULL((
								SELECT SUM(T$AMNT) 
								FROM TFSOLP106180
								WHERE  T$PLNT LIKE @Plant
									--AND LEFT(T$ITEM,3) NOT IN ('TTC','TCC')
									--AND LEFT(T$ITEM,1) NOT IN ('H','F','Q','7','9')
									AND T$ITEM NOT LIKE 'TTC%'
									AND T$ITEM NOT LIKE 'TCC%'
									AND T$ITEM NOT LIKE 'H%'
									AND T$ITEM NOT LIKE 'F%'
									AND T$ITEM NOT LIKE 'Q%'
									AND T$ITEM NOT LIKE '7%'
									AND T$ITEM NOT LIKE '9%'
									AND T$ITEM NOT LIKE 'S%'
									AND T$ITEM NOT LIKE 'P%'
									AND LEN(RTRIM(LTRIM(T$ITEM)))=8
									AND T$DATE BETWEEN @DateFrom AND @DateTo
							  ),0)+
							  ISNULL((
								SELECT SUM(T$AMNT) 
								FROM TFSOLP106180
								WHERE  T$PLNT LIKE @Plant
									--AND LEFT(T$ITEM,3) NOT IN ('TTC','TCC')
									--AND LEFT(T$ITEM,1) NOT IN ('H','F','Q','7','9')
									AND T$ITEM NOT LIKE 'TTC%'
									AND T$ITEM NOT LIKE 'TCC%'
									AND LEN(RTRIM(LTRIM(T$ITEM)))>8
									AND SUBSTRING(T$ITEM,CHARINDEX('-',T$ITEM)+1,1) NOT IN ('H','F','Q','S','P','7','9')
									AND T$DATE BETWEEN @DateFrom AND @DateTo
							  ),0)
		END
	ELSE
		BEGIN
			IF @Type<>'Price Change'
				BEGIN
					SET @ReturnValue=ISNULL((
													SELECT SUM(T$MAMT) 
													FROM TFSOLP121180
													WHERE  T$PLNT LIKE @Plant
														AND T$DESC=@Type
														AND T$TRDT BETWEEN @DateFrom AND @DateTo
												 ),0)
				END
			ELSE
				BEGIN										 
					SET @ReturnValue=ISNULL((
													SELECT SUM(T$MAMN)-SUM(T$MAMT) 
													FROM TFSOLP121180
													WHERE  T$PLNT LIKE @Plant
														AND T$DESC=@Type
														AND T$TRDT BETWEEN @DateFrom AND @DateTo
												 ),0)
				END
		END

	-- Return the result of the function
	RETURN ISNULL(@ReturnValue,0)

END
GO
