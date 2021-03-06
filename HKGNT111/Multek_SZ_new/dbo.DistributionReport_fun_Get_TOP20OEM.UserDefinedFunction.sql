USE [Multek_SZ_New]
GO
/****** Object:  UserDefinedFunction [dbo].[DistributionReport_fun_Get_TOP20OEM]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[DistributionReport_fun_Get_TOP20OEM]
(	
	-- Add the parameters for the function here
	@CalebdarFiscal VARCHAR(20),
	@Type VARCHAR(10),
	@Site VARCHAR(10),
	@Plant VARCHAR(10),
	@DateFrom DATETIME,
	@DateTo DATETIME
)
RETURNS @ReturnTable TABLE 
(
	OEM VARCHAR(500),
	Amount BIGINT
)
AS
BEGIN
	-- Fill the table variable with the rows for your result set
	--SET @Plant=@Plant+'%'

	IF @Type='HubIn'
		BEGIN
			IF @Plant<>''
				BEGIN
					IF @CalebdarFiscal='Calendar'
						BEGIN
							INSERT INTO @ReturnTable
							SELECT TOP 20  T$CSGS AS OEM,SUM(T$DOLS) AS Amount
							FROM TFSOLP104180
							WHERE T$LOCA=@Site
								AND T$PLNT= @Plant
								AND T$DATE BETWEEN @DateFrom AND @DateTo
							GROUP BY T$CSGS
							ORDER BY SUM(T$DOLS) DESC
						END
					IF @CalebdarFiscal='FiscalYear'
						BEGIN
							INSERT INTO @ReturnTable
							SELECT TOP 20  T$CSGS AS OEM,SUM(T$DOLS) AS Amount
							FROM TFSOLP104180
							WHERE T$LOCA=@Site
								AND T$PLNT= @Plant
								AND T$DATE BETWEEN @DateFrom AND @DateTo
								AND T$HKDT BETWEEN 			
												  (
														SELECT FiscalYearFrom
														FROM Calendar a 
														WHERE a.CalenderDate=TFSOLP104180.T$DATE
												  )				
											AND
												  (
														SELECT FiscalYearTo
														FROM Calendar a 
														WHERE a.CalenderDate=TFSOLP104180.T$DATE
												  )				
							GROUP BY T$CSGS
							ORDER BY SUM(T$DOLS) DESC
						END
						
				END
			ELSE
				BEGIN
					IF @CalebdarFiscal='Calendar'
						BEGIN
							INSERT INTO @ReturnTable
							SELECT TOP 20  T$CSGS AS OEM,SUM(T$DOLS) AS Amount
							FROM TFSOLP104180
							WHERE T$LOCA=@Site
								AND T$DATE BETWEEN @DateFrom AND @DateTo
							GROUP BY T$CSGS
							ORDER BY SUM(T$DOLS) DESC
						END
					IF @CalebdarFiscal='FiscalYear'
						BEGIN
							INSERT INTO @ReturnTable
							SELECT TOP 20  T$CSGS AS OEM,SUM(T$DOLS) AS Amount
							FROM TFSOLP104180
							WHERE T$LOCA=@Site
								AND T$DATE BETWEEN @DateFrom AND @DateTo
								AND T$HKDT BETWEEN 			
												  (
														SELECT FiscalYearFrom
														FROM Calendar a 
														WHERE a.CalenderDate=TFSOLP104180.T$DATE
												  )				
											AND
												  (
														SELECT FiscalYearTo
														FROM Calendar a 
														WHERE a.CalenderDate=TFSOLP104180.T$DATE
												  )				
							GROUP BY T$CSGS
							ORDER BY SUM(T$DOLS) DESC
						END
						
				END
			
		END
	IF @Type='Shipment'
		BEGIN
			IF @Plant<>''
				BEGIN
					IF @CalebdarFiscal='Calendar'
						BEGIN
							INSERT INTO @ReturnTable
							SELECT TOP 20  T$CSGS AS OEM,SUM(T$DOLS) AS Amount
							FROM TFSOLP105180
							WHERE T$LOCA=@Site
								AND T$PLNT= @Plant
								AND T$DATE BETWEEN @DateFrom AND @DateTo
							GROUP BY T$CSGS
							ORDER BY SUM(T$DOLS) DESC
						END
					IF @CalebdarFiscal='FiscalYear'
						BEGIN
							INSERT INTO @ReturnTable
							SELECT TOP 20  T$CSGS AS OEM,SUM(T$DOLS) AS Amount
							FROM TFSOLP105180
							WHERE T$LOCA=@Site
								AND T$PLNT= @Plant
								AND T$DATE BETWEEN @DateFrom AND @DateTo
								AND T$HKDT BETWEEN 			
												  (
														SELECT FiscalYearFrom
														FROM Calendar a 
														WHERE a.CalenderDate=TFSOLP105180.T$DATE
												  )				
											AND
												  (
														SELECT FiscalYearTo
														FROM Calendar a 
														WHERE a.CalenderDate=TFSOLP105180.T$DATE
												  )				
							GROUP BY T$CSGS
							ORDER BY SUM(T$DOLS) DESC
						END
						
				END
			ELSE
				BEGIN
					IF @CalebdarFiscal='Calendar'
						BEGIN
							INSERT INTO @ReturnTable
							SELECT TOP 20  T$CSGS AS OEM,SUM(T$DOLS) AS Amount
							FROM TFSOLP105180
							WHERE T$LOCA=@Site
								AND T$DATE BETWEEN @DateFrom AND @DateTo
							GROUP BY T$CSGS
							ORDER BY SUM(T$DOLS) DESC
						END
					IF @CalebdarFiscal='FiscalYear'
						BEGIN
							INSERT INTO @ReturnTable
							SELECT TOP 20  T$CSGS AS OEM,SUM(T$DOLS) AS Amount
							FROM TFSOLP105180
							WHERE T$LOCA=@Site
								AND T$DATE BETWEEN @DateFrom AND @DateTo
								AND T$HKDT BETWEEN 			
												  (
														SELECT FiscalYearFrom
														FROM Calendar a 
														WHERE a.CalenderDate=TFSOLP105180.T$DATE
												  )				
											AND
												  (
														SELECT FiscalYearTo
														FROM Calendar a 
														WHERE a.CalenderDate=TFSOLP105180.T$DATE
												  )				
							GROUP BY T$CSGS
							ORDER BY SUM(T$DOLS) DESC
						END
						
				END
			
		END
	IF @Type='Outbound'
		BEGIN
			IF @Plant<>''
				BEGIN
					INSERT INTO @ReturnTable
					SELECT TOP 20  T$CSGS AS OEM,SUM(T$DOLS) AS Amount
					FROM TFSOLP106180
					WHERE T$LOCA=@Site
						AND T$PLNT= @Plant
						AND T$DATE BETWEEN @DateFrom AND @DateTo
					GROUP BY T$CSGS
					ORDER BY SUM(T$DOLS) DESC
				END
			ELSE
				BEGIN
					INSERT INTO @ReturnTable
					SELECT TOP 20  T$CSGS AS OEM,SUM(T$DOLS) AS Amount
					FROM TFSOLP106180
					WHERE T$LOCA=@Site
						AND T$DATE BETWEEN @DateFrom AND @DateTo
					GROUP BY T$CSGS
					ORDER BY SUM(T$DOLS) DESC
				END
			
		END
	IF @Type='Output'
		BEGIN
			IF @Plant<>''
				BEGIN
					INSERT INTO @ReturnTable
					SELECT TOP 20  T$CSGS AS OEM,SUM(T$DOLS) AS Amount
					FROM TFSOLP107180
					WHERE T$LOCA=@Site
						AND T$PLNT= @Plant
						AND T$DATE BETWEEN @DateFrom AND @DateTo
					GROUP BY T$CSGS
					ORDER BY SUM(T$DOLS) DESC
				END
			ELSE
				BEGIN
					INSERT INTO @ReturnTable
					SELECT TOP 20  T$CSGS AS OEM,SUM(T$DOLS) AS Amount
					FROM TFSOLP107180
					WHERE T$LOCA=@Site
						AND T$DATE BETWEEN @DateFrom AND @DateTo
					GROUP BY T$CSGS
					ORDER BY SUM(T$DOLS) DESC
				END
			
		END
		
	UPDATE @ReturnTable
	SET OEM=dbo.DistributionReport_fun_Valid_SQL_String(OEM)

	RETURN 
END
GO
