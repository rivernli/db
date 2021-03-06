USE [Multek_SZ_New]
GO
/****** Object:  UserDefinedFunction [dbo].[DistributionReport_fun_Get_Daily]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[DistributionReport_fun_Get_Daily]
(
	-- Add the parameters for the function here
	@Type VARCHAR(20),
	@Site VARCHAR(10),
	@Plant VARCHAR(10),
	@DateFrom DATETIME,
	@DateTo DATETIME
)
RETURNS @DailyOEMCost TABLE 
(
	Date DATETIME,
	Amount NUMERIC(19,2)
)
AS
BEGIN
	-- Fill the table variable with the rows for your result set

	IF @Type='HubIn'
		BEGIN
			IF @Plant<>''
				BEGIN
					INSERT INTO @DailyOEMCost
					SELECT T$DATE AS Date,ISNULL(SUM(T$DOLS),0) AS Amount
					FROM TFSOLP104180
					WHERE T$LOCA=@Site
						AND T$PLNT=@Plant
						AND T$DATE BETWEEN @DateFrom AND @DateTo
						AND T$HKDT BETWEEN 			
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
					GROUP BY T$DATE
				END
			ELSE
				BEGIN
					INSERT INTO @DailyOEMCost
					SELECT T$DATE AS Date,ISNULL(SUM(T$DOLS),0) AS Amount
					FROM TFSOLP104180
					WHERE T$LOCA=@Site
						AND T$DATE BETWEEN @DateFrom AND @DateTo
						AND T$HKDT BETWEEN 			
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
					GROUP BY T$DATE
				END
			
		END
	IF @Type='Outbound'
		BEGIN
			IF @Plant<>''
				BEGIN
					INSERT INTO @DailyOEMCost
					SELECT T$DATE AS Date,ISNULL(SUM(T$DOLS),0) AS Amount
					FROM TFSOLP106180
					WHERE T$LOCA=@Site
						AND T$PLNT=@Plant
						AND T$DATE BETWEEN @DateFrom AND @DateTo
					GROUP BY T$DATE
				END
			ELSE
				BEGIN
					INSERT INTO @DailyOEMCost
					SELECT T$DATE AS Date,ISNULL(SUM(T$DOLS),0) AS Amount
					FROM TFSOLP106180
					WHERE T$LOCA=@Site
						AND T$DATE BETWEEN @DateFrom AND @DateTo
					GROUP BY T$DATE
				END
				
		END
	IF @Type='Shipment'
		BEGIN
			IF @Plant<>''
				BEGIN
					INSERT INTO @DailyOEMCost
					SELECT T$DATE AS Date,ISNULL(SUM(T$DOLS),0) AS Amount
					FROM TFSOLP105180
					WHERE T$LOCA=@Site
						AND T$PLNT=@Plant
						AND T$DATE BETWEEN @DateFrom AND @DateTo
						AND T$HKDT BETWEEN 			
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
					GROUP BY T$DATE
				END
			ELSE
				BEGIN
					INSERT INTO @DailyOEMCost
					SELECT T$DATE AS Date,ISNULL(SUM(T$DOLS),0) AS Amount
					FROM TFSOLP105180
					WHERE T$LOCA=@Site
						AND T$DATE BETWEEN @DateFrom AND @DateTo
						AND T$HKDT BETWEEN 			
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
					GROUP BY T$DATE
				END
		END

	IF @Type='Output'
		BEGIN
			IF @Plant<>''
				BEGIN
					INSERT INTO @DailyOEMCost
					SELECT T$DATE AS Date,ISNULL(SUM(T$DOLS),0) AS Amount
					FROM TFSOLP107180
					WHERE T$LOCA=@Site
						AND T$PLNT=@Plant
						AND T$DATE BETWEEN @DateFrom AND @DateTo
					GROUP BY T$DATE
				END
			ELSE
				BEGIN
					INSERT INTO @DailyOEMCost
					SELECT T$DATE AS Date,ISNULL(SUM(T$DOLS),0) AS Amount
					FROM TFSOLP107180
					WHERE T$LOCA=@Site
						AND T$DATE BETWEEN @DateFrom AND @DateTo
					GROUP BY T$DATE
				END
		END
			
	IF @Type='RMA'
		BEGIN
			IF @Plant<>''
				BEGIN
					INSERT INTO @DailyOEMCost
					SELECT T$DATE AS Date,ISNULL(SUM(T$AMNT),0) AS Amount
					FROM TFSOLP109180
					WHERE T$PLNT=@Plant
						AND T$DATE BETWEEN @DateFrom AND @DateTo
					GROUP BY T$DATE
				END
			ELSE
				BEGIN
					INSERT INTO @DailyOEMCost
					SELECT T$DATE AS Date,ISNULL(SUM(T$AMNT),0) AS Amount
					FROM TFSOLP109180
					WHERE T$DATE BETWEEN @DateFrom AND @DateTo
					GROUP BY T$DATE
				END
		END

	RETURN 
END
GO
