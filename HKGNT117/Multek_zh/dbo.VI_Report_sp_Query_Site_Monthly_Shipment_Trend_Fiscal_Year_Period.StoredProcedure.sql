USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[VI_Report_sp_Query_Site_Monthly_Shipment_Trend_Fiscal_Year_Period]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[VI_Report_sp_Query_Site_Monthly_Shipment_Trend_Fiscal_Year_Period] 
	-- Add the parameters for the stored procedure here
	@Year CHAR(4),
	@Site VARCHAR(10),
	@Plant VARCHAR(50)=NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    -- Insert statements for procedure here
	SET @Plant='%'+ISNULL(@Plant,'')+'%'
	
	IF @Site='Global'	
		BEGIN
			IF EXISTS(SELECT * FROM VI_Report_Shipped_All_Fixed_Fiscal
						WHERE ReportCode='002' AND Year=@Year)
				BEGIN
					SELECT SUM(M1),SUM(M2),SUM(M3),SUM(M4),SUM(M5),SUM(M6),SUM(M7),SUM(M8),SUM(M9),SUM(M10),SUM(M11),SUM(M12) FROM VI_Report_Shipped_All_Fixed_Fiscal
					WHERE ReportCode='002' AND Year=@Year 
				END
			ELSE
				BEGIN
					SELECT 0,0,0,0,0,0,0,0,0,0,0,0
				END
		END
	ELSE
		BEGIN
			IF EXISTS(SELECT * FROM VI_Report_Shipped_All_Fixed_Fiscal
					WHERE ReportCode='002'
							AND Year=@Year
							AND Site=@Site)
			BEGIN
				SELECT M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12 FROM VI_Report_Shipped_All_Fixed_Fiscal
				WHERE ReportCode='002'
					AND Year=@Year
					AND Site=@Site
			END
			ELSE
			BEGIN
				SELECT 0,0,0,0,0,0,0,0,0,0,0,0
			END
		END
END




GO
