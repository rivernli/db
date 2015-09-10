USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Query_FiscalYear_DateRange]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Query_FiscalYear_DateRange] 
	-- Add the parameters for the stored procedure here
	@Year INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT FiscalYearFrom,FiscalYearTo
	FROM Calendar
	WHERE FiscalYear=@Year
END
GO
