USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[SalesAnalysis_sp_Query_Monthly_Sales_ByPlant]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SalesAnalysis_sp_Query_Monthly_Sales_ByPlant] 
	-- Add the parameters for the stored procedure here
	@ReportCode VARCHAR(3),
	@Year CHAR(4),
	@Site VARCHAR(3)='Chi',
	@Plant VARCHAR(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    -- Insert statements for procedure here

	DECLARE @YearMonth VARCHAR(7)
	IF EXISTS(	SELECT M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12
				FROM SalesAnalysis_Amount_Fiscal
				WHERE ReportCode=@ReportCode
					AND Year=@Year
					AND Site=@Site
					AND Plant=@Plant
			)
		BEGIN
			SELECT M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12
			FROM SalesAnalysis_Amount_Fiscal
			WHERE ReportCode=@ReportCode
				AND Year=@Year
				AND Site=@Site
				AND Plant=@Plant
		END
	ELSE
		BEGIN
			SELECT 0,0,0,0,0,0,0,0,0,0,0,0
		END
END
GO
