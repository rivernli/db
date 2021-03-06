USE [Multek_SZ_New]
GO
/****** Object:  UserDefinedFunction [dbo].[DistributionReport_sp_Get_Period_Amount]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[DistributionReport_sp_Get_Period_Amount]
(
	-- Add the parameters for the function here
	@Year INT,
	@Period INT,
	@ReportCode VARCHAR(3),
	@Type VARCHAR(50),
	@Plant VARCHAR(50)
)
RETURNS NUMERIC(19,0)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ReturnResult NUMERIC(19,0)

	-- Add the T-SQL statements to compute the return value here
	SET @ReturnResult=(
						CASE @Period WHEN 1 THEN (SELECT M1 FROM DistribitionReport_Amount_Fiscal WHERE ReportCode=@ReportCode AND Year=@Year AND Type=@Type AND Plant=@Plant)
									 WHEN 2 THEN (SELECT M2 FROM DistribitionReport_Amount_Fiscal WHERE ReportCode=@ReportCode AND Year=@Year AND Type=@Type AND Plant=@Plant)
									 WHEN 3 THEN (SELECT M3 FROM DistribitionReport_Amount_Fiscal WHERE ReportCode=@ReportCode AND Year=@Year AND Type=@Type AND Plant=@Plant)
									 WHEN 4 THEN (SELECT M4 FROM DistribitionReport_Amount_Fiscal WHERE ReportCode=@ReportCode AND Year=@Year AND Type=@Type AND Plant=@Plant)
									 WHEN 5 THEN (SELECT M5 FROM DistribitionReport_Amount_Fiscal WHERE ReportCode=@ReportCode AND Year=@Year AND Type=@Type AND Plant=@Plant)
									 WHEN 6 THEN (SELECT M6 FROM DistribitionReport_Amount_Fiscal WHERE ReportCode=@ReportCode AND Year=@Year AND Type=@Type AND Plant=@Plant)
									 WHEN 7 THEN (SELECT M7 FROM DistribitionReport_Amount_Fiscal WHERE ReportCode=@ReportCode AND Year=@Year AND Type=@Type AND Plant=@Plant)
									 WHEN 8 THEN (SELECT M8 FROM DistribitionReport_Amount_Fiscal WHERE ReportCode=@ReportCode AND Year=@Year AND Type=@Type AND Plant=@Plant)
									 WHEN 9 THEN (SELECT M9 FROM DistribitionReport_Amount_Fiscal WHERE ReportCode=@ReportCode AND Year=@Year AND Type=@Type AND Plant=@Plant)
									 WHEN 10 THEN (SELECT M10 FROM DistribitionReport_Amount_Fiscal WHERE ReportCode=@ReportCode AND Year=@Year AND Type=@Type AND Plant=@Plant)
									 WHEN 11 THEN (SELECT M11 FROM DistribitionReport_Amount_Fiscal WHERE ReportCode=@ReportCode AND Year=@Year AND Type=@Type AND Plant=@Plant)
									 WHEN 12 THEN (SELECT M12 FROM DistribitionReport_Amount_Fiscal WHERE ReportCode=@ReportCode AND Year=@Year AND Type=@Type AND Plant=@Plant)
						ELSE 0
						END
					  )
	

	-- Return the result of the function
	RETURN (ISNULL(@ReturnResult,0))

END
GO
