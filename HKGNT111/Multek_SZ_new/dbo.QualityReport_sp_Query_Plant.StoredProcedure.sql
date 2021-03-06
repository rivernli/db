USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[QualityReport_sp_Query_Plant]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[QualityReport_sp_Query_Plant] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT a.* 
	FROM (
			SELECT Plant,(CASE Plant WHEN '2F' THEN 'B2F' WHEN 'HK' THEN 'VVI' ELSE Plant END) AS PlantDesc
			FROM QualityReport_uvw_VPT_MKT_Shipment
			WHERE Plant<>'12'
			GROUP BY Plant
		 ) a
	ORDER BY a.PlantDesc
END
GO
