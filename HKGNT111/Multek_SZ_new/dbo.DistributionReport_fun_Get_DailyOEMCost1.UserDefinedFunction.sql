USE [Multek_SZ_New]
GO
/****** Object:  UserDefinedFunction [dbo].[DistributionReport_fun_Get_DailyOEMCost1]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[DistributionReport_fun_Get_DailyOEMCost1]
(
	-- Add the parameters for the function here
	@Type VARCHAR(10),
	@Site VARCHAR(10),
	@Plant VARCHAR(10),
	@Date DATETIME
)
RETURNS @DailyOEMCost TABLE 
(
	AutoID INT IDENTITY(1,1),
	OEM VARCHAR(200),
	RevenueAmount BIGINT,
	MaterialAmount BIGINT,
	MaterialPercent NUMERIC(18,2)
)
AS
BEGIN
	-- Fill the table variable with the rows for your result set

	IF @Type='HubIn'
		BEGIN
			IF @Plant<>''
				BEGIN
					INSERT INTO @DailyOEMCost
					SELECT d.*
					FROM (
							SELECT c.*,(CASE WHEN ABS(c.RevenueAmount)<1 THEN 0 ELSE 100*c.MaterialAmount/(c.RevenueAmount*1.0000) END) AS MaterialPercent
							FROM (
									SELECT T$CSGS AS OEM ,ISNULL(SUM(T$DOLS),0) AS RevenueAmount ,SUM(T$DQUA*T$COST) AS MaterialAmount
									FROM TFSOLP104180
									WHERE T$LOCA=@Site
										AND T$PLNT=@Plant
										AND T$DATE=@Date
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
									GROUP BY T$CSGS
								) c
						 ) d
					ORDER BY d.MaterialPercent DESC,d.OEM
				END
			ELSE
				BEGIN
					INSERT INTO @DailyOEMCost
					SELECT d.*
					FROM (
							SELECT c.*,(CASE WHEN ABS(c.RevenueAmount)<1 THEN 0 ELSE 100*c.MaterialAmount/(c.RevenueAmount*1.0000) END) AS MaterialPercent
							FROM (
									SELECT T$CSGS AS OEM ,ISNULL(SUM(T$DOLS),0) AS RevenueAmount ,SUM(T$DQUA*T$COST) AS MaterialAmount
									FROM TFSOLP104180
									WHERE T$LOCA=@Site
										AND T$DATE=@Date
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
									GROUP BY T$CSGS
								) c
						 ) d
					ORDER BY d.MaterialPercent DESC,d.OEM
				END
			
		END
	IF @Type='Outbound'
		BEGIN
			IF @Plant<>''
				BEGIN
					INSERT INTO @DailyOEMCost
					SELECT d.*
					FROM (
							SELECT c.*,(CASE WHEN ABS(c.RevenueAmount)<1 THEN 0 ELSE 100*c.MaterialAmount/(c.RevenueAmount*1.0000) END) AS MaterialPercent
							FROM (
									SELECT T$CSGS AS OEM ,ISNULL(SUM(T$DOLS),0) AS RevenueAmount ,SUM(T$DQUA*T$COST) AS MaterialAmount
									FROM TFSOLP106180
									WHERE T$LOCA=@Site
										AND T$PLNT=@Plant
										AND T$DATE=@Date
									GROUP BY T$CSGS
								) c
						 ) d
					ORDER BY d.MaterialPercent DESC,d.OEM
				END
			ELSE
				BEGIN
					INSERT INTO @DailyOEMCost
					SELECT d.*
					FROM (
							SELECT c.*,(CASE WHEN ABS(c.RevenueAmount)<1 THEN 0 ELSE 100*c.MaterialAmount/(c.RevenueAmount*1.0000) END) AS MaterialPercent
							FROM (
									SELECT T$CSGS AS OEM ,ISNULL(SUM(T$DOLS),0) AS RevenueAmount ,SUM(T$DQUA*T$COST) AS MaterialAmount
									FROM TFSOLP106180
									WHERE T$LOCA=@Site
										AND T$DATE=@Date
									GROUP BY T$CSGS
								) c
						 ) d
					ORDER BY d.MaterialPercent DESC,d.OEM
				END
				
		END
	IF @Type='Shipment'
		BEGIN
			IF @Plant<>''
				BEGIN
					INSERT INTO @DailyOEMCost
					SELECT d.*
					FROM (
							SELECT c.*,(CASE WHEN ABS(c.RevenueAmount)<1 THEN 0 ELSE 100*c.MaterialAmount/(c.RevenueAmount*1.0000) END) AS MaterialPercent
							FROM (
									SELECT T$CSGS AS OEM ,ISNULL(SUM(T$DOLS),0) AS RevenueAmount ,SUM(T$DQUA*T$COST) AS MaterialAmount
									FROM TFSOLP105180
									WHERE T$LOCA=@Site
										AND T$PLNT=@Plant
										AND T$DATE=@Date
									GROUP BY T$CSGS
								) c
						 ) d
					ORDER BY d.MaterialPercent DESC,d.OEM
				END
			ELSE
				BEGIN
					INSERT INTO @DailyOEMCost
					SELECT d.*
					FROM (
							SELECT c.*,(CASE WHEN ABS(c.RevenueAmount)<1 THEN 0 ELSE 100*c.MaterialAmount/(c.RevenueAmount*1.0000) END) AS MaterialPercent
							FROM (
									SELECT T$CSGS AS OEM ,ISNULL(SUM(T$DOLS),0) AS RevenueAmount ,SUM(T$DQUA*T$COST) AS MaterialAmount
									FROM TFSOLP105180
									WHERE T$LOCA=@Site
										AND T$DATE=@Date
									GROUP BY T$CSGS
								) c
						 ) d
					ORDER BY d.MaterialPercent DESC,d.OEM
				END
		END

	IF @Type='Output'
		BEGIN
			IF @Plant<>''
				BEGIN
					INSERT INTO @DailyOEMCost
					SELECT d.*
					FROM (
							SELECT c.*,(CASE WHEN ABS(c.RevenueAmount)<1 THEN 0 ELSE 100*c.MaterialAmount/(c.RevenueAmount*1.0000) END) AS MaterialPercent
							FROM (
									SELECT T$CSGS AS OEM ,ISNULL(SUM(T$DOLS),0) AS RevenueAmount ,SUM(T$DQUA*T$COST) AS MaterialAmount
									FROM TFSOLP107180
									WHERE T$LOCA=@Site
										AND T$PLNT=@Plant
										AND T$DATE=@Date
									GROUP BY T$CSGS
								) c
						 ) d
					ORDER BY d.MaterialPercent DESC,d.OEM
				END
			ELSE
				BEGIN
					INSERT INTO @DailyOEMCost
					SELECT d.*
					FROM (
							SELECT c.*,(CASE WHEN ABS(c.RevenueAmount)<1 THEN 0 ELSE 100*c.MaterialAmount/(c.RevenueAmount*1.0000) END) AS MaterialPercent
							FROM (
									SELECT T$CSGS AS OEM ,ISNULL(SUM(T$DOLS),0) AS RevenueAmount ,SUM(T$DQUA*T$COST) AS MaterialAmount
									FROM TFSOLP107180
									WHERE T$LOCA=@Site
										AND T$DATE=@Date
									GROUP BY T$CSGS
								) c
						 ) d
					ORDER BY d.MaterialPercent DESC,d.OEM
				END
		END
			
	RETURN 
END
GO
