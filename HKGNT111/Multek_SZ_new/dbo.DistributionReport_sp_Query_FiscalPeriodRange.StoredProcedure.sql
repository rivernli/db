USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_Query_FiscalPeriodRange]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DistributionReport_sp_Query_FiscalPeriodRange]
	-- Add the parameters for the stored procedure here
	@Year INT,
	@Period VARCHAR(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT  MIN(CONVERT(VARCHAR(10),CalenderDate,120)) AS DateFrom,
			MAX(CONVERT(VARCHAR(10),CalenderDate,120)) AS DateTo
	FROM dbo.Calendar 
	WHERE FiscalYear=@Year 
		AND FiscalPeriod=RIGHT(@Period,LEN(@Period)-1)

END
GO
