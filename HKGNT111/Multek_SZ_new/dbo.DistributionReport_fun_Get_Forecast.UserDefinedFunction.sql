USE [Multek_SZ_New]
GO
/****** Object:  UserDefinedFunction [dbo].[DistributionReport_fun_Get_Forecast]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[DistributionReport_fun_Get_Forecast]
(
	-- Add the parameters for the function here
	@Plant VARCHAR(20),
	@Period INT,
	@Year INT
)
RETURNS NUMERIC(19,4)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ReturnValue NUMERIC(19,4)

	-- Add the T-SQL statements to compute the return value here
	IF @Period=1
		BEGIN
			SET @ReturnValue=(
								SELECT M1 
								FROM DistributionReport_Forecast 
									WHERE TYPE='Incoming' 
									AND Site='Chi'
									AND Plant=@Plant
									AND Year=@Year
							)
		END
	IF @Period=2
		BEGIN
			SET @ReturnValue=(
								SELECT M2 
								FROM DistributionReport_Forecast 
									WHERE TYPE='Incoming' 
									AND Site='Chi'
									AND Plant=@Plant
									AND Year=@Year
							)
		END
	IF @Period=3
		BEGIN
			SET @ReturnValue=(
								SELECT M3 
								FROM DistributionReport_Forecast 
									WHERE TYPE='Incoming' 
									AND Site='Chi'
									AND Plant=@Plant
									AND Year=@Year
							)
		END
	IF @Period=4
		BEGIN
			SET @ReturnValue=(
								SELECT M4 
								FROM DistributionReport_Forecast 
									WHERE TYPE='Incoming' 
									AND Site='Chi'
									AND Plant=@Plant
									AND Year=@Year
							)
		END
	IF @Period=5
		BEGIN
			SET @ReturnValue=(
								SELECT M5 
								FROM DistributionReport_Forecast 
									WHERE TYPE='Incoming' 
									AND Site='Chi'
									AND Plant=@Plant
									AND Year=@Year
							)
		END
	IF @Period=6
		BEGIN
			SET @ReturnValue=(
								SELECT M6 
								FROM DistributionReport_Forecast 
									WHERE TYPE='Incoming' 
									AND Site='Chi'
									AND Plant=@Plant
									AND Year=@Year
							)
		END
	IF @Period=7
		BEGIN
			SET @ReturnValue=(
								SELECT M7 
								FROM DistributionReport_Forecast 
									WHERE TYPE='Incoming' 
									AND Site='Chi'
									AND Plant=@Plant
									AND Year=@Year
							)
		END
	IF @Period=8
		BEGIN
			SET @ReturnValue=(
								SELECT M8 
								FROM DistributionReport_Forecast 
									WHERE TYPE='Incoming' 
									AND Site='Chi'
									AND Plant=@Plant
									AND Year=@Year
							)
		END
	IF @Period=9
		BEGIN
			SET @ReturnValue=(
								SELECT M9 
								FROM DistributionReport_Forecast 
									WHERE TYPE='Incoming' 
									AND Site='Chi'
									AND Plant=@Plant
									AND Year=@Year
							)
		END
	IF @Period=10
		BEGIN
			SET @ReturnValue=(
								SELECT M10
								FROM DistributionReport_Forecast 
									WHERE TYPE='Incoming' 
									AND Site='Chi'
									AND Plant=@Plant
									AND Year=@Year
							)
		END
	IF @Period=11
		BEGIN
			SET @ReturnValue=(
								SELECT M11
								FROM DistributionReport_Forecast 
									WHERE TYPE='Incoming' 
									AND Site='Chi'
									AND Plant=@Plant
									AND Year=@Year
							)
		END
	IF @Period=12
		BEGIN
			SET @ReturnValue=(
								SELECT M12
								FROM DistributionReport_Forecast 
									WHERE TYPE='Incoming' 
									AND Site='Chi'
									AND Plant=@Plant
									AND Year=@Year
							)
		END
		
	-- Return the result of the function
	RETURN ISNULL(@ReturnValue,0)

END
GO
