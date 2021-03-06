USE [Multek_SZ_New]
GO
/****** Object:  UserDefinedFunction [dbo].[DistributionReport_fun_Get_Amount_Technics]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[DistributionReport_fun_Get_Amount_Technics]
(
	-- Add the parameters for the function here
	@CalendarFiscal VARCHAR(20),
	@Type VARCHAR(20),
	@Site VARCHAR(10),
	@Plant VARCHAR(10),
	@Technics VARCHAR(50),
	@DateFrom DATETIME,
	@DateTo DATETIME
)
RETURNS NUMERIC(19,0)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ReturnResult NUMERIC(19,0)

	--SET @Technics='%'+LTRIM(RTRIM(@Technics))+'%'
	
	-- Add the T-SQL statements to compute the return value here
	SET @ReturnResult=(
							CASE  --WHEN @Type='HubIn' THEN (SELECT SUM(T$DOLS) FROM TFSOLP104180 WHERE T$LOCA=@Site AND T$PLNT=@Plant AND Technics=@Technics AND T$DATE BETWEEN @DateFrom AND @DateTo)
								  WHEN @Type='HubIn'AND @CalendarFiscal='Calendar' THEN (SELECT SUM(T$DOLS) FROM TFSOLP104180 WHERE T$LOCA=@Site AND T$PLNT=@Plant AND Technics=@Technics AND T$DATE BETWEEN @DateFrom AND @DateTo)
								  WHEN @Type='HubIn'AND @CalendarFiscal='FiscalPeriod' THEN (SELECT SUM(T$DOLS) FROM TFSOLP104180 WHERE T$LOCA=@Site AND T$PLNT=@Plant AND Technics=@Technics AND T$DATE BETWEEN @DateFrom AND @DateTo AND 
									T$HKDT BETWEEN 			
													  (
															SELECT FiscalPeriodFrom
															FROM Calendar a 
															WHERE a.CalenderDate=TFSOLP104180.T$DATE
													  )				
												AND
													  (
															SELECT FiscalPeriodTo
															FROM Calendar a 
															WHERE a.CalenderDate=TFSOLP104180.T$DATE
													  )				
									)
								  WHEN @Type='HubIn'AND @CalendarFiscal='FiscalQuarter' THEN (SELECT SUM(T$DOLS) FROM TFSOLP104180 WHERE T$LOCA=@Site AND T$PLNT=@Plant AND Technics=@Technics AND T$DATE BETWEEN @DateFrom AND @DateTo AND 
									T$HKDT BETWEEN 			
													  (
															SELECT FiscalQuarterFrom
															FROM Calendar a 
															WHERE a.CalenderDate=TFSOLP104180.T$DATE
													  )				
												AND
													  (
															SELECT FiscalQuarterTo
															FROM Calendar a 
															WHERE a.CalenderDate=TFSOLP104180.T$DATE
													  )				
									)
								  WHEN @Type='Outbound' THEN (SELECT SUM(T$DOLS) FROM TFSOLP106180 WHERE T$LOCA=@Site AND T$PLNT=@Plant AND Technics=@Technics AND T$DATE BETWEEN @DateFrom AND @DateTo)
								  WHEN @Type='Shipment'AND @CalendarFiscal='Calendar' THEN (SELECT SUM(T$DOLS) FROM TFSOLP105180 WHERE T$LOCA=@Site AND T$PLNT=@Plant AND Technics=@Technics AND T$DATE BETWEEN @DateFrom AND @DateTo)
								  WHEN @Type='Shipment'AND @CalendarFiscal='FiscalPeriod' THEN (SELECT SUM(T$DOLS) FROM TFSOLP105180 WHERE T$LOCA=@Site AND T$PLNT=@Plant AND Technics=@Technics AND T$DATE BETWEEN @DateFrom AND @DateTo AND 
									T$HKDT BETWEEN 			
													  (
															SELECT FiscalPeriodFrom
															FROM Calendar a 
															WHERE a.CalenderDate=TFSOLP105180.T$DATE
													  )				
												AND
													  (
															SELECT FiscalPeriodTo
															FROM Calendar a 
															WHERE a.CalenderDate=TFSOLP105180.T$DATE
													  )				
									)
								  WHEN @Type='Shipment'AND @CalendarFiscal='FiscalQuarter' THEN (SELECT SUM(T$DOLS) FROM TFSOLP105180 WHERE T$LOCA=@Site AND T$PLNT=@Plant AND Technics=@Technics AND T$DATE BETWEEN @DateFrom AND @DateTo AND 
									T$HKDT BETWEEN 			
													  (
															SELECT FiscalQuarterFrom
															FROM Calendar a 
															WHERE a.CalenderDate=TFSOLP105180.T$DATE
													  )				
												AND
													  (
															SELECT FiscalQuarterTo
															FROM Calendar a 
															WHERE a.CalenderDate=TFSOLP105180.T$DATE
													  )				
									)
								  WHEN @Type='Output' THEN (SELECT SUM(T$DOLS) FROM TFSOLP107180 WHERE T$LOCA=@Site AND T$PLNT=@Plant AND Technics=@Technics AND T$DATE BETWEEN @DateFrom AND @DateTo)
								  WHEN @Type='RMA' THEN (SELECT SUM(T$AMNT) FROM TFSOLP109180 WHERE T$PLNT=@Plant AND T$PRDT=@Technics AND T$DATE BETWEEN @DateFrom AND @DateTo)
								  WHEN @Type='RMACustomer' THEN (SELECT SUM(T$AMNT) FROM TFSOLP109180 WHERE T$PLNT=@Plant AND T$CUNO=@Technics AND T$DATE BETWEEN @DateFrom AND @DateTo)
								  WHEN @Type='RMAOEM' THEN (SELECT SUM(T$AMNT) FROM TFSOLP109180 WHERE T$PLNT=@Plant AND T$CSGS=@Technics AND T$DATE BETWEEN @DateFrom AND @DateTo)
							 ELSE 0
							 END
					  )
	
	-- Return the result of the function
	RETURN (ISNULL(@ReturnResult,0))

END
GO
