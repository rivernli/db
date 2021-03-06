USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[QualityReport_sp_Query_Product]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[QualityReport_sp_Query_Product]
	-- Add the parameters for the stored procedure here
	@Product VARCHAR(100)=NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SET @Product=LTRIM(RTRIM(ISNULL(@Product,'')))+'%'
	SELECT Product_Name AS Product
	FROM QualityReport_uvw_VPT_MKT_Shipment
	WHERE Product_Name LIKE @Product
	GROUP BY Product_Name
	ORDER BY Product_Name
END
GO
