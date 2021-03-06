USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[QualityReport_sp_Query_PartNo]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[QualityReport_sp_Query_PartNo]
	-- Add the parameters for the stored procedure here
	@PartNo VARCHAR(200)=NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SET @PartNo=LTRIM(RTRIM(ISNULL(@PartNo,'')))+'%'
	SELECT top 20 RTRIM(Part_No) AS PartNo
	FROM QualityReport_uvw_VPT_MKT_Shipment
	WHERE Part_No LIKE @PartNo
	GROUP BY Part_No
	ORDER BY Part_No
END
GO
