USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[QualityReport_sp_Query_Quality_Years]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[QualityReport_sp_Query_Quality_Years] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT CONVERT(CHAR(4),Invoice_Date,120) AS QualityYears
	FROM QualityReport_uvw_VPT_MKT_Shipment
	GROUP BY CONVERT(CHAR(4),Invoice_Date,120)
	ORDER BY CONVERT(CHAR(4),Invoice_Date,120) DESC
END
GO
