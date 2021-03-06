USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[VI_Report_sp_Query_Site_Shipment_Trend_Fiscal_Year]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[VI_Report_sp_Query_Site_Shipment_Trend_Fiscal_Year] 
	-- Add the parameters for the stored procedure here
	@Year CHAR(4),
	@Site VARCHAR(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
IF @Site='Global'	
	BEGIN
		IF EXISTS(SELECT * FROM VI_Report_Shipped_All_Fixed_Fiscal
					WHERE ReportCode='002' AND Year=@Year)
			BEGIN
				SELECT SUM(M1+M2+M3+M4+M5+M6+M7+M8+M9+M10+M11+M12) as SumAmount	
				FROM VI_Report_Shipped_All_Fixed_Fiscal
				WHERE ReportCode='002'AND Year=@Year 
			END
		ELSE
			BEGIN
				SELECT 0 as SumAmount	
			END
	END
ELSE
	BEGIN
		IF EXISTS(SELECT * FROM VI_Report_Shipped_All_Fixed_Fiscal
					WHERE ReportCode='002'
							AND Year=@Year
							AND Site=@Site)
			BEGIN
				SELECT M1+M2+M3+M4+M5+M6+M7+M8+M9+M10+M11+M12 as SumAmount	
				FROM VI_Report_Shipped_All_Fixed_Fiscal
				WHERE ReportCode='002'
					AND Year=@Year
					AND Site=@Site
			END
		ELSE
			BEGIN
				SELECT 0 as SumAmount	
			END
	END
END


GO
