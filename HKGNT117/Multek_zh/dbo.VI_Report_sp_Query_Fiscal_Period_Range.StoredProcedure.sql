USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[VI_Report_sp_Query_Fiscal_Period_Range]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[VI_Report_sp_Query_Fiscal_Period_Range]
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
	FROM DataWarehouse.dbo.DW_DIM_Calender
	WHERE FiscalYear=@Year 
		AND FiscalPeriod=RIGHT(@Period,LEN(@Period)-1)

END

GO
