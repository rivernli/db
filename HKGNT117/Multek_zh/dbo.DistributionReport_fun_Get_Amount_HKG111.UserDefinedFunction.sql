USE [Multek_ZH]
GO
/****** Object:  UserDefinedFunction [dbo].[DistributionReport_fun_Get_Amount_HKG111]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[DistributionReport_fun_Get_Amount_HKG111]
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
	
	SET @ReturnResult=(
		CASE
			WHEN @Type='Shipment' AND @CalendarFiscal='Calendar' THEN (SELECT SUM(T$DOLS) FROM TFSOLP105180_HKG111 WHERE T$LOCA=@Site AND T$PLNT=@Plant AND T$DATE BETWEEN @DateFrom AND @DateTo)
			WHEN @Type='Shipment' AND @CalendarFiscal='FiscalPeriod' THEN (SELECT SUM(T$DOLS) FROM TFSOLP105180_HKG111 WHERE T$LOCA=@Site AND T$PLNT=@Plant AND T$DATE BETWEEN @DateFrom AND @DateTo AND 
				T$HKDT BETWEEN 			
								  (
										SELECT FiscalPeriodFrom
										FROM Calendar_HKG111 a 
										WHERE a.CalenderDate=TFSOLP105180_HKG111.T$DATE
								  )				
							AND
								  (
										SELECT FiscalPeriodTo
										FROM Calendar_HKG111 a 
										WHERE a.CalenderDate=TFSOLP105180_HKG111.T$DATE
								  )				
				)
			WHEN @Type='Shipment' AND @CalendarFiscal='FiscalQuarter' THEN (SELECT SUM(T$DOLS) FROM TFSOLP105180_HKG111 WHERE T$LOCA=@Site AND T$PLNT=@Plant AND T$DATE BETWEEN @DateFrom AND @DateTo AND 
				T$HKDT BETWEEN 			
								  (
										SELECT FiscalQuarterFrom
										FROM Calendar_HKG111 a 
										WHERE a.CalenderDate=TFSOLP105180_HKG111.T$DATE
								  )				
							AND
								  (
										SELECT FiscalQuarterTo
										FROM Calendar_HKG111 a 
										WHERE a.CalenderDate=TFSOLP105180_HKG111.T$DATE
								  )				
				)
			ELSE 0
		END
	)

	
	
	-- Return the result of the function
	RETURN (ISNULL(@ReturnResult,0))

END


GO
