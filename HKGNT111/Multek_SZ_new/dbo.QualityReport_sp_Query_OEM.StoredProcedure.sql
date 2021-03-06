USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[QualityReport_sp_Query_OEM]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[QualityReport_sp_Query_OEM]
	-- Add the parameters for the stored procedure here
	@OEM VARCHAR(100)=NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SET @OEM=LTRIM(RTRIM(ISNULL(@OEM,'')))+'%'
	SELECT Oem_Name AS OEM
	FROM QualityReport_uvw_VPT_MKT_Shipment
	WHERE Oem_Name LIKE @OEM
	GROUP BY Oem_Name
	ORDER BY Oem_Name
END
GO
