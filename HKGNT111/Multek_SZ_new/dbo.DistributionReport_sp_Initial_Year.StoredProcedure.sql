USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_Initial_Year]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DistributionReport_sp_Initial_Year]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	-- Process Year
	DECLARE @Year VARCHAR(4),@i INT
	SET @Year=CONVERT(CHAR(4),GETDATE()-1,120)
	IF NOT EXISTS(SELECT * FROM DistributionReport_Year WHERE Year=@Year)
		BEGIN 
			INSERT INTO DistributionReport_Year(Year) VALUES(@Year)
		END
	SET @i=1
	WHILE @i<=4
		BEGIN
			SET @Year=CONVERT(INT,@Year)-1
			IF NOT EXISTS(SELECT * FROM DistributionReport_Year WHERE Year=@Year)
				BEGIN 
					INSERT INTO DistributionReport_Year(Year) VALUES(@Year)
				END
			SET @i=@i+1
		END
	
	SET @Year=CONVERT(CHAR(4),GETDATE()-1,120)
	DELETE DistributionReport_Year
	WHERE Year>@Year
	DELETE DistributionReport_Year
	WHERE Year<=@Year-5
	
	TRUNCATE TABLE DistributionReport_Fiscal_Year
	INSERT INTO DistributionReport_Fiscal_Year(Year)
	SELECT TOP 5 RIGHT(FiscalYearDesc,4) AS ShipmentYears
	FROM Calendar
	WHERE LEFT(FiscalYearDesc,2)='FY'
		AND calenderDate<=CONVERT(VARCHAR(10),GETDATE(),120)
	GROUP BY FiscalYearDesc
	ORDER BY FiscalYearDesc DESC


END
GO
