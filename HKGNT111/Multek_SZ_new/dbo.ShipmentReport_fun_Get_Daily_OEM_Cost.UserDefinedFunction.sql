USE [Multek_SZ_New]
GO
/****** Object:  UserDefinedFunction [dbo].[ShipmentReport_fun_Get_Daily_OEM_Cost]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[ShipmentReport_fun_Get_Daily_OEM_Cost]
(
	-- Add the parameters for the function here
	@Site VARCHAR(10),
	@Plant VARCHAR(10),
	@DateFrom DATETIME,
	@DateTo DATETIME
)
RETURNS @DailyOEMCost TABLE 
(
	Site VARCHAR(10),
	Plant VARCHAR(10),
	Date DATETIME,
	OEM VARCHAR(200),
	RevenueAmount NUMERIC(19,2),
	MaterialAmount NUMERIC(19,2),
	MaterialPercent NUMERIC(18,2)
)
AS
BEGIN
	-- Fill the table variable with the rows for your result set

	IF @Site<>'Chi'
		BEGIN
			INSERT INTO @DailyOEMCost
			SELECT d.*
			FROM (
					SELECT c.*,(CASE WHEN ABS(c.RevenueAmount)<1 THEN 0 ELSE 100*c.MaterialAmount/(c.RevenueAmount*1.0000) END) AS MaterialPercent
					FROM (
							SELECT   Loc,'' AS Plant,SHDate AS Date,Real_OEM AS OEM ,ISNULL(SUM(SHDOLS),0) AS RevenueAmount ,SUM(SHBrds*CostB_Loc) AS MaterialAmount
							FROM ShipmentReport_Shipped_All
							WHERE Loc=@Site
								--AND Plant=@Plant
								AND SHDate BETWEEN @DateFrom AND @DateTo
								AND Real_OEM >''
							GROUP BY Loc,SHDate,Real_OEM
						) c
				 ) d
			ORDER BY  d.Loc,d.Plant,d.Date,d.MaterialPercent DESC,d.OEM
		END
	ELSE
		BEGIN
			INSERT INTO @DailyOEMCost
			SELECT d.*
			FROM (
					SELECT c.*,(CASE WHEN ABS(c.RevenueAmount)<1 THEN 0 ELSE 100*c.MaterialAmount/(c.RevenueAmount*1.0000) END) AS MaterialPercent
					FROM (
							SELECT   Loc,Plant,SHDate AS Date,Real_OEM AS OEM ,ISNULL(SUM(SHDOLS),0) AS RevenueAmount ,SUM(SHBrds*CostB_Loc) AS MaterialAmount
							FROM ShipmentReport_Shipped_All
							WHERE Loc=@Site
								AND Plant<>'NA'
								AND Plant<>''
								AND SHDate BETWEEN @DateFrom AND @DateTo
								AND Real_OEM >''
							GROUP BY  Loc,Plant,SHDate,Real_OEM
						) c
				 ) d
			--ORDER BY  d.Loc,d.Plant,d.Date,d.MaterialPercent DESC,d.OEM
			UNION
			SELECT d.*
			FROM (
					SELECT c.*,(CASE WHEN ABS(c.RevenueAmount)<1 THEN 0 ELSE 100*c.MaterialAmount/(c.RevenueAmount*1.0000) END) AS MaterialPercent
					FROM (
							SELECT   Loc,'' AS Plant,SHDate AS Date,Real_OEM AS OEM ,ISNULL(SUM(SHDOLS),0) AS RevenueAmount ,SUM(SHBrds*CostB_Loc) AS MaterialAmount
							FROM ShipmentReport_Shipped_All
							WHERE Loc=@Site
								AND Plant<>'NA'
								AND SHDate BETWEEN @DateFrom AND @DateTo
								AND Real_OEM >''
							GROUP BY  Loc,SHDate,Real_OEM
						) c
				 ) d
			ORDER BY  d.Loc,d.Plant,d.Date,d.MaterialPercent DESC,d.OEM
		END
			
	RETURN 
END
GO
