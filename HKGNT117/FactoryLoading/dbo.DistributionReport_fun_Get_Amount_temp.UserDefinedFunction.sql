USE [FactoryLoading]
GO
/****** Object:  UserDefinedFunction [dbo].[DistributionReport_fun_Get_Amount_temp]    Script Date: 2014/11/12 17:06:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[DistributionReport_fun_Get_Amount_temp]
(
	-- Add the parameters for the function here
	@CalenderFiscal VARCHAR(20),
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
											CASE  --WHEN @Type='HubIn' THEN (SELECT SUM(T$DOLS) FROM TFSOLP104180 WHERE T$LOCA=@Site AND T$PLNT=@Plant AND T$DATE BETWEEN @DateFrom AND @DateTo)
							
												
												  WHEN @Type='Shipment' AND @CalenderFiscal='DataWarehouse.dbo.DW_DIM_Calender' THEN (SELECT SUM(T$DOLS) FROM TFSOLP105180 WHERE T$LOCA=@Site AND T$PLNT=@Plant AND T$DATE BETWEEN @DateFrom AND @DateTo)
												  WHEN @Type='Shipment' AND @CalenderFiscal='FiscalPeriod' THEN (SELECT SUM(T$DOLS) FROM TFSOLP105180 WHERE T$LOCA=@Site AND T$PLNT=@Plant AND T$DATE BETWEEN @DateFrom AND @DateTo AND 
														T$HKDT BETWEEN 			
																		  (
																				SELECT FiscalPeriodFrom
																				FROM DataWarehouse.dbo.DW_DIM_Calender a 
																				WHERE a.CalenderDate=TFSOLP105180.T$DATE
																		  )				
																	AND
																		  (
																				SELECT FiscalPeriodTo
																				FROM DataWarehouse.dbo.DW_DIM_Calender a 
																				WHERE a.CalenderDate=TFSOLP105180.T$DATE
																		  )				
														)
												  WHEN @Type='Shipment' AND @CalenderFiscal='FiscalQuarter' THEN (SELECT SUM(T$DOLS) FROM TFSOLP105180 WHERE T$LOCA=@Site AND T$PLNT=@Plant AND T$DATE BETWEEN @DateFrom AND @DateTo AND 
														T$HKDT BETWEEN 			
																		  (
																				SELECT FiscalQuarterFrom
																				FROM DataWarehouse.dbo.DW_DIM_Calender a 
																				WHERE a.CalenderDate=TFSOLP105180.T$DATE
																		  )				
																	AND
																		  (
																				SELECT FiscalQuarterTo
																				FROM DataWarehouse.dbo.DW_DIM_Calender a 
																				WHERE a.CalenderDate=TFSOLP105180.T$DATE
																		  )				
														)
												
											 ELSE 0
											 END
									  )
				END
			ELSE
				BEGIN
					SET @ReturnResult=(
											CASE  
												  WHEN @Type='Shipment'AND @CalenderFiscal='DataWarehouse.dbo.DW_DIM_Calender' THEN (SELECT SUM(T$DOLS) FROM TFSOLP105180 WHERE T$LOCA=@Site  AND T$DATE BETWEEN @DateFrom AND @DateTo)
												  WHEN @Type='Shipment'AND @CalenderFiscal='FiscalPeriod' THEN (SELECT SUM(T$DOLS) FROM TFSOLP105180 WHERE T$LOCA=@Site  AND T$DATE BETWEEN @DateFrom AND @DateTo AND 
														T$HKDT BETWEEN 			
																		  (
																				SELECT FiscalPeriodFrom
																				FROM DataWarehouse.dbo.DW_DIM_Calender a 
																				WHERE a.CalenderDate=TFSOLP105180.T$DATE
																		  )				
																	AND
																		  (
																				SELECT FiscalPeriodTo
																				FROM DataWarehouse.dbo.DW_DIM_Calender a 
																				WHERE a.CalenderDate=TFSOLP105180.T$DATE
																		  )				
														)
												  WHEN @Type='Shipment'AND @CalenderFiscal='FiscalQuarter' THEN (SELECT SUM(T$DOLS) FROM TFSOLP105180 WHERE T$LOCA=@Site  AND T$DATE BETWEEN @DateFrom AND @DateTo AND 
														T$HKDT BETWEEN 			
																		  (
																				SELECT FiscalQuarterFrom
																				FROM DataWarehouse.dbo.DW_DIM_Calender a 
																				WHERE a.CalenderDate=TFSOLP105180.T$DATE
																		  )				
																	AND
																		  (
																				SELECT FiscalQuarterTo
																				FROM DataWarehouse.dbo.DW_DIM_Calender a 
																				WHERE a.CalenderDate=TFSOLP105180.T$DATE
																		  )				
														)

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
												CASE  
													  WHEN @Type='Shipment'AND @CalenderFiscal='DataWarehouse.dbo.DW_DIM_Calender' THEN (SELECT SUM(T$DOLS) FROM TFSOLP105180 WHERE T$LOCA=@Site AND T$PLNT=@Plant AND T$LAYS=@Lay AND T$DATE BETWEEN @DateFrom AND @DateTo)
													  WHEN @Type='Shipment'AND @CalenderFiscal='FiscalPeriod' THEN (SELECT SUM(T$DOLS) FROM TFSOLP105180 WHERE T$LOCA=@Site AND T$PLNT=@Plant AND T$LAYS=@Lay AND T$DATE BETWEEN @DateFrom AND @DateTo AND 
														T$HKDT BETWEEN 			
																		  (
																				SELECT FiscalPeriodFrom
																				FROM DataWarehouse.dbo.DW_DIM_Calender a 
																				WHERE a.CalenderDate=TFSOLP105180.T$DATE
																		  )				
																	AND
																		  (
																				SELECT FiscalPeriodTo
																				FROM DataWarehouse.dbo.DW_DIM_Calender a 
																				WHERE a.CalenderDate=TFSOLP105180.T$DATE
																		  )				
														)
													  WHEN @Type='Shipment'AND @CalenderFiscal='FiscalQuarter' THEN (SELECT SUM(T$DOLS) FROM TFSOLP105180 WHERE T$LOCA=@Site AND T$PLNT=@Plant AND T$LAYS=@Lay AND T$DATE BETWEEN @DateFrom AND @DateTo AND 
														T$HKDT BETWEEN 			
																		  (
																				SELECT FiscalQuarterFrom
																				FROM DataWarehouse.dbo.DW_DIM_Calender a 
																				WHERE a.CalenderDate=TFSOLP105180.T$DATE
																		  )				
																	AND
																		  (
																				SELECT FiscalQuarterTo
																				FROM DataWarehouse.dbo.DW_DIM_Calender a 
																				WHERE a.CalenderDate=TFSOLP105180.T$DATE
																		  )				
														)

												 ELSE 0
												 END
										  )
				END
			ELSE
				BEGIN
						SET @ReturnResult=(
												CASE  
													  WHEN @Type='Shipment'AND @CalenderFiscal='FiscalQuarter' THEN (SELECT SUM(T$DOLS) FROM TFSOLP104180 WHERE T$LOCA=@Site  AND T$LAYS=@Lay AND T$DATE BETWEEN @DateFrom AND @DateTo AND 
														T$HKDT BETWEEN 			
																		  (
																				SELECT FiscalQuarterFrom
																				FROM DataWarehouse.dbo.DW_DIM_Calender a 
																				WHERE a.CalenderDate=TFSOLP104180.T$DATE
																		  )				
																	AND
																		  (
																				SELECT FiscalQuarterTo
																				FROM DataWarehouse.dbo.DW_DIM_Calender a 
																				WHERE a.CalenderDate=TFSOLP104180.T$DATE
																		  )				
														)

													  WHEN @Type='Shipment'AND @CalenderFiscal='DataWarehouse.dbo.DW_DIM_Calender' THEN (SELECT SUM(T$DOLS) FROM TFSOLP105180 WHERE T$LOCA=@Site  AND T$LAYS=@Lay AND T$DATE BETWEEN @DateFrom AND @DateTo)
													  WHEN @Type='Shipment'AND @CalenderFiscal='FiscalPeriod' THEN (SELECT SUM(T$DOLS) FROM TFSOLP105180 WHERE T$LOCA=@Site  AND T$LAYS=@Lay AND T$DATE BETWEEN @DateFrom AND @DateTo AND 
														T$HKDT BETWEEN 			
																		  (
																				SELECT FiscalPeriodFrom
																				FROM DataWarehouse.dbo.DW_DIM_Calender a 
																				WHERE a.CalenderDate=TFSOLP105180.T$DATE
																		  )				
																	AND
																		  (
																				SELECT FiscalPeriodTo
																				FROM DataWarehouse.dbo.DW_DIM_Calender a 
																				WHERE a.CalenderDate=TFSOLP105180.T$DATE
																		  )				
														)
													  WHEN @Type='Shipment'AND @CalenderFiscal='FiscalQuarter' THEN (SELECT SUM(T$DOLS) FROM TFSOLP105180 WHERE T$LOCA=@Site  AND T$LAYS=@Lay AND T$DATE BETWEEN @DateFrom AND @DateTo AND 
														T$HKDT BETWEEN 			
																		  (
																				SELECT FiscalQuarterFrom
																				FROM DataWarehouse.dbo.DW_DIM_Calender a 
																				WHERE a.CalenderDate=TFSOLP105180.T$DATE
																		  )				
																	AND
																		  (
																				SELECT FiscalQuarterTo
																				FROM DataWarehouse.dbo.DW_DIM_Calender a 
																				WHERE a.CalenderDate=TFSOLP105180.T$DATE
																		  )				
														)
								
												 ELSE 0
												 END
										  )
				END				
		END
	
	-- Return the result of the function
	RETURN (ISNULL(@ReturnResult,0))

END



GO
