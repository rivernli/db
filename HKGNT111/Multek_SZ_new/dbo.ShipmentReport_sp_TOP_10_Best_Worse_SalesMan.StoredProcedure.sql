USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_TOP_10_Best_Worse_SalesMan]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_TOP_10_Best_Worse_SalesMan]
	-- Add the parameters for the stored procedure here
	@Year INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    DECLARE @DateFrom DATE,@DateTo DATE
    SET @DateFrom=(SELECT MIN(calenderDate) FROM Calendar WHERE FiscalYear=@Year)
    SET @DateTo=(SELECT MAX(calenderDate) FROM Calendar WHERE FiscalYear=@Year)
	SELECT TOP 10 SalesMan,SUM(SHDols) AS Amount
	FROM ShipmentReport_Shipped_All
	WHERE SHDate BETWEEN @DateFrom AND @DateTo
		AND SalesMan<>''
	GROUP BY SalesMan
	HAVING SUM(SHDols)>=0
	ORDER BY SUM(SHDols) DESC

	SELECT TOP 10 SalesMan,SUM(SHDols) AS Amount
	FROM ShipmentReport_Shipped_All
	WHERE SHDate BETWEEN @DateFrom AND @DateTo
		AND SalesMan<>''
	GROUP BY SalesMan
	HAVING SUM(SHDols)>=0
	ORDER BY SUM(SHDols) ASC

END
GO
