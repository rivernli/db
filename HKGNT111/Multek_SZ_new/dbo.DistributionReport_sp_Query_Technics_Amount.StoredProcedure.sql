USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_Query_Technics_Amount]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DistributionReport_sp_Query_Technics_Amount]
	-- Add the parameters for the stored procedure here
	@ReportCode VARCHAR(20),
	@Type VARCHAR(20),
	@Site VARCHAR(50),
	@Plant VARCHAR(50),
	@Year VARCHAR(4),
	@Technics VARCHAR(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	SET @Plant='%'+(CASE @Plant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' WHEN 'VVI' THEN 'HK' WHEN 'ZhuHai' THEN '' ELSE @Plant END)+'%'

    -- Insert statements for procedure here
	SELECT SUM(M1) AS M1,SUM(M2) AS M2,SUM(M3) AS M3,SUM(M4) AS M4,SUM(M5) AS M5,SUM(M6) AS M6,SUM(M7) AS M7,SUM(M8) AS M8,SUM(M9) AS M9,SUM(M10) AS M10,SUM(M11) AS M11,SUM(M12) AS M12
	FROM DistributionReport_Technics_Amount
	WHERE ReportCode=@ReportCode
		AND TYPE=@Type
		AND Site=@Site
		AND Plant LIKE @Plant
		AND YEAR=@Year
		AND Technics=@Technics
	IF @@ROWCOUNT=0
		BEGIN
			SELECT 0 AS M1,0 AS M2,0 AS M3,0 AS M4,0 AS M5,00 AS M6,0 AS M7,0 AS M8,0 AS M9,0 AS M10,0 AS M11,0 AS M12
		END
END
GO
