USE [Multek_SZ_New]
GO
/****** Object:  UserDefinedFunction [dbo].[DistributionReport_fun_Get_Technics]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[DistributionReport_fun_Get_Technics]
(	
	-- Add the parameters for the function here
	@CalendarFiscal VARCHAR(20),
	@Type VARCHAR(20),
	@Site VARCHAR(10),
	@Plant VARCHAR(10),
	@DateFrom DATETIME,
	@DateTo DATETIME
)
RETURNS @ReturnTable TABLE 
(
	Technics VARCHAR(100)
)
AS
BEGIN
	-- Fill the table variable with the rows for your result set
	--SET @Plant=@Plant+'%'
	
	IF @Type='HubIn'AND @CalendarFiscal='Calendar'
		BEGIN
			INSERT INTO @ReturnTable
			SELECT Technics
			FROM TFSOLP104180 
			WHERE T$LOCA=@Site
				AND T$PLNT= @Plant
					AND Technics>''
				AND T$DATE BETWEEN @DateFrom AND @DateTo
			GROUP BY Technics
		END
	IF @Type='HubIn'AND @CalendarFiscal='FiscalPeriod'
		BEGIN
			INSERT INTO @ReturnTable
			SELECT Technics
			FROM TFSOLP104180 
			WHERE T$LOCA=@Site
				AND T$PLNT= @Plant
					AND Technics>''
				AND T$DATE BETWEEN @DateFrom AND @DateTo
				AND T$HKDT BETWEEN 			
								  (
										SELECT FiscalPeriodFrom
										FROM Calendar a 
										WHERE CalenderDate=TFSOLP104180.T$DATE
								  )				
								AND
								  (
										SELECT FiscalPeriodTo
										FROM Calendar a 
										WHERE CalenderDate=TFSOLP104180.T$DATE
								  )								
			GROUP BY Technics
		END
	IF @Type='HubIn'AND @CalendarFiscal='FiscalQuarter'
		BEGIN
			INSERT INTO @ReturnTable
			SELECT Technics
			FROM TFSOLP104180 
			WHERE T$LOCA=@Site
				AND T$PLNT= @Plant
					AND Technics>''
				AND T$DATE BETWEEN @DateFrom AND @DateTo
				AND T$HKDT BETWEEN 			
								  (
										SELECT FiscalQuarterFrom
										FROM Calendar a 
										WHERE CalenderDate=TFSOLP104180.T$DATE
								  )				
								AND
								  (
										SELECT FiscalQuarterTo
										FROM Calendar a 
										WHERE CalenderDate=TFSOLP104180.T$DATE
								  )								
			GROUP BY Technics
		END
	IF @Type='Shipment'AND @CalendarFiscal='Calendar'
		BEGIN
			INSERT INTO @ReturnTable
			SELECT Technics
			FROM TFSOLP105180 
			WHERE T$LOCA=@Site
				AND T$PLNT= @Plant
					AND Technics>''
				AND T$DATE BETWEEN @DateFrom AND @DateTo
			GROUP BY Technics
		END
	IF @Type='Shipment'AND @CalendarFiscal='FiscalPeriod'
		BEGIN
			INSERT INTO @ReturnTable
			SELECT Technics
			FROM TFSOLP105180 
			WHERE T$LOCA=@Site
				AND T$PLNT= @Plant
					AND Technics>''
				AND T$DATE BETWEEN @DateFrom AND @DateTo
				AND T$HKDT BETWEEN 			
								  (
										SELECT FiscalPeriodFrom
										FROM Calendar a 
										WHERE CalenderDate=TFSOLP105180.T$DATE
								  )				
								AND
								  (
										SELECT FiscalPeriodTo
										FROM Calendar a 
										WHERE CalenderDate=TFSOLP105180.T$DATE
								  )								
			GROUP BY Technics
		END
	IF @Type='Shipment'AND @CalendarFiscal='FiscalQuarter'
		BEGIN
			INSERT INTO @ReturnTable
			SELECT Technics
			FROM TFSOLP105180 
			WHERE T$LOCA=@Site
				AND T$PLNT= @Plant
					AND Technics>''
				AND T$DATE BETWEEN @DateFrom AND @DateTo
				AND T$HKDT BETWEEN 			
								  (
										SELECT FiscalQuarterFrom
										FROM Calendar a 
										WHERE CalenderDate=TFSOLP105180.T$DATE
								  )				
								AND
								  (
										SELECT FiscalQuarterTo
										FROM Calendar a 
										WHERE CalenderDate=TFSOLP105180.T$DATE
								  )								
			GROUP BY Technics
		END
	IF @Type='Outbound'
		BEGIN
				INSERT INTO @ReturnTable
				SELECT Technics
				FROM TFSOLP106180 
				WHERE T$LOCA=@Site
					AND T$PLNT= @Plant
					AND Technics>''
					AND T$DATE BETWEEN @DateFrom AND @DateTo
					
				GROUP BY Technics
		END
	IF @Type='Output'
		BEGIN
				INSERT INTO @ReturnTable
				SELECT Technics
				FROM TFSOLP107180 
				WHERE T$LOCA=@Site
					AND T$PLNT= @Plant
					AND Technics>''
					AND T$DATE BETWEEN @DateFrom AND @DateTo
					
				GROUP BY Technics
		END
	IF @Type='RMA'
		BEGIN
				INSERT INTO @ReturnTable
				SELECT T$PRDT
				FROM TFSOLP109180
				WHERE T$PLNT= @Plant
					AND T$PRDT>''
					AND T$DATE BETWEEN @DateFrom AND @DateTo
				GROUP BY T$PRDT
		END
	IF @Type='RMACustomer'
		BEGIN
				INSERT INTO @ReturnTable
				SELECT T$CUNO
				FROM TFSOLP109180
				WHERE T$PLNT= @Plant
					AND T$CUNO>''
					AND T$DATE BETWEEN @DateFrom AND @DateTo
				GROUP BY T$CUNO
		END
	IF @Type='RMAOEM'
		BEGIN
				INSERT INTO @ReturnTable
				SELECT T$CSGS
				FROM TFSOLP109180
				WHERE T$PLNT= @Plant
					AND T$CSGS>''
					AND T$DATE BETWEEN @DateFrom AND @DateTo
				GROUP BY T$CSGS
		END
	
	RETURN 
END
GO
