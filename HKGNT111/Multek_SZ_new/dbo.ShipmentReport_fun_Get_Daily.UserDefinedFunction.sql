USE [Multek_SZ_New]
GO
/****** Object:  UserDefinedFunction [dbo].[ShipmentReport_fun_Get_Daily]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[ShipmentReport_fun_Get_Daily]
(
	-- Add the parameters for the function here
	@Site VARCHAR(10),
	@Plant VARCHAR(10),
	@DateFrom DATETIME,
	@DateTo DATETIME
)
RETURNS @DailyOEMCost TABLE 
(
	Loc VARCHAR(10),
	Plant VARCHAR(10),
	Date DATETIME,
	Amount NUMERIC(19,2)
)
AS
BEGIN
	-- Fill the table variable with the rows for your result set
	IF @Site<>'Chi'
		BEGIN
			INSERT INTO @DailyOEMCost
			SELECT Loc,'' AS Plant,SHDATE AS Date,ISNULL(SUM(SHDOLS),0) AS Amount
			FROM ShipmentReport_Shipped_All
			WHERE LOC = @Site
				AND SHDATE BETWEEN @DateFrom AND @DateTo
			GROUP BY Loc,SHDate
		END
	ELSE
		BEGIN
			INSERT INTO @DailyOEMCost
			SELECT Loc,Plant,SHDATE AS Date,ISNULL(SUM(SHDOLS),0) AS Amount
			FROM ShipmentReport_Shipped_All
			WHERE LOC = @Site
				AND Plant<>'NA'
				AND Plant<>''
				AND SHDATE BETWEEN @DateFrom AND @DateTo
			GROUP BY Loc,Plant,SHDate
			UNION
			SELECT Loc,'' AS Plant,SHDATE AS Date,ISNULL(SUM(SHDOLS),0) AS Amount
			FROM ShipmentReport_Shipped_All
			WHERE LOC = @Site
				AND Plant<>'NA'
				AND SHDATE BETWEEN @DateFrom AND @DateTo
			GROUP BY Loc,SHDate
		END			
	RETURN 
END
GO
