USE [Multek_SZ_New]
GO
/****** Object:  UserDefinedFunction [dbo].[GlobalViewReport_fun_Get_Amount_Booked]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GlobalViewReport_fun_Get_Amount_Booked]
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

	-- Add the T-SQL statements to compute the return value here
	IF @Plant='B1'
		BEGIN
			SET @ReturnValue=(
								SELECT SUM(T$PB12)
								FROM TFSOLP119180 
								WHERE T$ODAT BETWEEN @DateFrom AND @DateTo							)
		END
	IF @Plant='B2F'
		BEGIN
			SET @ReturnValue=(
								SELECT SUM(T$B2F)
								FROM TFSOLP119180 
								WHERE T$ODAT BETWEEN @DateFrom AND @DateTo							)
		END
	IF @Plant='B3'
		BEGIN
			SET @ReturnValue=(
								SELECT SUM(T$PB3)
								FROM TFSOLP119180 
								WHERE T$ODAT BETWEEN @DateFrom AND @DateTo							)
		END
	IF @Plant='B4'
		BEGIN
			SET @ReturnValue=(
								SELECT SUM(T$PB4)
								FROM TFSOLP119180 
								WHERE T$ODAT BETWEEN @DateFrom AND @DateTo							)
		END
	IF @Plant='B5'
		BEGIN
			SET @ReturnValue=(
								SELECT SUM(T$PB5) 
								FROM TFSOLP119180 
								WHERE T$ODAT BETWEEN @DateFrom AND @DateTo							)
		END
	IF @Plant='VVI'
		BEGIN
			SET @ReturnValue=(
								SELECT SUM(T$SUB1)
								FROM TFSOLP119180 
								WHERE T$ODAT BETWEEN @DateFrom AND @DateTo							)
		END
	IF @Plant='B4VVI'
		BEGIN
			SET @ReturnValue=(
								SELECT ISNULL(SUM(T$SUB1),0)+ISNULL(SUM(T$PB4),0)
								FROM TFSOLP119180 
								WHERE T$ODAT BETWEEN @DateFrom AND @DateTo							)
		END
	IF @Plant='SUB'
		BEGIN
			SET @ReturnValue=(
								SELECT SUM(T$SUB2)
								FROM TFSOLP119180 
								WHERE T$ODAT BETWEEN @DateFrom AND @DateTo							)
		END
	-- Return the result of the function
	RETURN ISNULL(@ReturnValue,0)

END
GO
