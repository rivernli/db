USE [Multek_SZ_New]
GO
/****** Object:  UserDefinedFunction [dbo].[DistributionReport_fun_Get_SQFT]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[DistributionReport_fun_Get_SQFT]
(
	-- Add the parameters for the function here
	@CalendarFiscal VARCHAR(20),
	@Type VARCHAR(10),
	@Site VARCHAR(10),
	@Plant VARCHAR(10),
	@DateFrom DATETIME,
	@DateTo DATETIME,
	@Lay INT=NULL
)
RETURNS NUMERIC(19,0)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ReturnResult NUMERIC(19,0)

	-- Add the T-SQL statements to compute the return value here
	IF @Lay IS NULL
		BEGIN
			IF @Plant<>''
				BEGIN
					SET @ReturnResult=(
											CASE  --WHEN @Type='HubIn' THEN (SELECT SUM(T$SQFT) FROM TFSOLP104180 WHERE T$LOCA=@Site AND T$PLNT=@Plant AND T$DATE BETWEEN @DateFrom AND @DateTo)
												  WHEN @Type='Outbound' THEN (SELECT SUM(T$SQFT) FROM TFSOLP106180 WHERE T$LOCA=@Site AND T$PLNT=@Plant AND T$DATE BETWEEN @DateFrom AND @DateTo)
												  WHEN @Type='Shipment' AND @CalendarFiscal='Calendar' THEN (SELECT SUM(T$SQFT) FROM TFSOLP105180 WHERE T$LOCA=@Site AND T$PLNT=@Plant AND T$DATE BETWEEN @DateFrom AND @DateTo)
												  WHEN @Type='Shipment' AND @CalendarFiscal='FiscalPeriod' THEN (SELECT SUM(T$SQFT) FROM TFSOLP105180 WHERE T$LOCA=@Site AND T$PLNT=@Plant AND T$DATE BETWEEN @DateFrom AND @DateTo AND 
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
												  WHEN @Type='Shipment' AND @CalendarFiscal='FiscalQuarter' THEN (SELECT SUM(T$SQFT) FROM TFSOLP105180 WHERE T$LOCA=@Site AND T$PLNT=@Plant AND T$DATE BETWEEN @DateFrom AND @DateTo AND 
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
												  WHEN @Type='Output' THEN (SELECT SUM(T$SQFT) FROM TFSOLP107180 WHERE T$LOCA=@Site AND T$PLNT=@Plant AND T$DATE BETWEEN @DateFrom AND @DateTo)
											 ELSE 0
											 END
									  )
				END
			ELSE
				BEGIN
					SET @ReturnResult=(
											CASE  --WHEN @Type='HubIn' THEN (SELECT SUM(T$SQFT) FROM TFSOLP104180 WHERE T$LOCA=@Site  AND T$DATE BETWEEN @DateFrom AND @DateTo)
												  WHEN @Type='Outbound' THEN (SELECT SUM(T$SQFT) FROM TFSOLP106180 WHERE T$LOCA=@Site  AND T$DATE BETWEEN @DateFrom AND @DateTo)
												  WHEN @Type='Shipment'AND @CalendarFiscal='Calendar' THEN (SELECT SUM(T$SQFT) FROM TFSOLP105180 WHERE T$LOCA=@Site  AND T$DATE BETWEEN @DateFrom AND @DateTo)
												  WHEN @Type='Shipment'AND @CalendarFiscal='FiscalPeriod' THEN (SELECT SUM(T$SQFT) FROM TFSOLP105180 WHERE T$LOCA=@Site  AND T$DATE BETWEEN @DateFrom AND @DateTo AND 
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
												  WHEN @Type='Shipment'AND @CalendarFiscal='FiscalQuarter' THEN (SELECT SUM(T$SQFT) FROM TFSOLP105180 WHERE T$LOCA=@Site  AND T$DATE BETWEEN @DateFrom AND @DateTo AND 
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
												  WHEN @Type='Output' THEN (SELECT SUM(T$SQFT) FROM TFSOLP107180 WHERE T$LOCA=@Site  AND T$DATE BETWEEN @DateFrom AND @DateTo)
											 ELSE 0
											 END
									)
				END
		END
	ELSE
		BEGIN
			IF @Plant<>''
				BEGIN
						SET @ReturnResult=(
												CASE  --WHEN @Type='HubIn' THEN (SELECT SUM(T$SQFT) FROM TFSOLP104180 WHERE T$LOCA=@Site AND T$PLNT=@Plant AND T$LAYS=@Lay AND T$DATE BETWEEN @DateFrom AND @DateTo)
													  WHEN @Type='Outbound' THEN (SELECT SUM(T$SQFT) FROM TFSOLP106180 WHERE T$LOCA=@Site AND T$PLNT=@Plant AND T$LAYS=@Lay AND T$Cotp NOT IN ('SMP','RMA') AND T$DATE BETWEEN @DateFrom AND @DateTo)
													  WHEN @Type='Shipment'AND @CalendarFiscal='Calendar' THEN (SELECT SUM(T$SQFT) FROM TFSOLP105180 WHERE T$LOCA=@Site AND T$PLNT=@Plant AND T$LAYS=@Lay AND T$DATE BETWEEN @DateFrom AND @DateTo)
													  WHEN @Type='Shipment'AND @CalendarFiscal='FiscalPeriod' THEN (SELECT SUM(T$SQFT) FROM TFSOLP105180 WHERE T$LOCA=@Site AND T$PLNT=@Plant AND T$LAYS=@Lay AND T$DATE BETWEEN @DateFrom AND @DateTo AND 
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
													  WHEN @Type='Shipment'AND @CalendarFiscal='FiscalQuarter' THEN (SELECT SUM(T$SQFT) FROM TFSOLP105180 WHERE T$LOCA=@Site AND T$PLNT=@Plant AND T$LAYS=@Lay AND T$DATE BETWEEN @DateFrom AND @DateTo AND 
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
													  WHEN @Type='Output' THEN (SELECT SUM(T$SQFT) FROM TFSOLP107180 WHERE T$LOCA=@Site AND T$PLNT=@Plant AND T$LAYS=@Lay AND T$DATE BETWEEN @DateFrom AND @DateTo)
												 ELSE 0
												 END
										  )
				END
			ELSE
				BEGIN
						SET @ReturnResult=(
												CASE  --WHEN @Type='HubIn' THEN (SELECT SUM(T$SQFT) FROM TFSOLP104180 WHERE T$LOCA=@Site  AND T$LAYS=@Lay AND T$DATE BETWEEN @DateFrom AND @DateTo)
													  WHEN @Type='Outbound' THEN (SELECT SUM(T$SQFT) FROM TFSOLP106180 WHERE T$LOCA=@Site  AND T$LAYS=@Lay AND T$Cotp NOT IN ('SMP','RMA') AND T$DATE BETWEEN @DateFrom AND @DateTo)
													  WHEN @Type='Shipment'AND @CalendarFiscal='Calendar' THEN (SELECT SUM(T$SQFT) FROM TFSOLP105180 WHERE T$LOCA=@Site  AND T$LAYS=@Lay AND T$DATE BETWEEN @DateFrom AND @DateTo)
													  WHEN @Type='Shipment'AND @CalendarFiscal='FiscalPeriod' THEN (SELECT SUM(T$SQFT) FROM TFSOLP105180 WHERE T$LOCA=@Site  AND T$LAYS=@Lay AND T$DATE BETWEEN @DateFrom AND @DateTo AND 
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
													  WHEN @Type='Shipment'AND @CalendarFiscal='FiscalQuarter' THEN (SELECT SUM(T$SQFT) FROM TFSOLP105180 WHERE T$LOCA=@Site  AND T$LAYS=@Lay AND T$DATE BETWEEN @DateFrom AND @DateTo AND 
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
													  WHEN @Type='Output' THEN (SELECT SUM(T$SQFT) FROM TFSOLP107180 WHERE T$LOCA=@Site  AND T$LAYS=@Lay AND T$DATE BETWEEN @DateFrom AND @DateTo)
												 ELSE 0
												 END
										  )
				END				
		END
	
	-- Return the result of the function
	RETURN (ISNULL(@ReturnResult,0))

END
GO
