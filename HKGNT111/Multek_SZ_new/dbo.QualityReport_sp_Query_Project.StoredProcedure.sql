USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[QualityReport_sp_Query_Project]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[QualityReport_sp_Query_Project]
	-- Add the parameters for the stored procedure here
	@Project VARCHAR(200)=NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SET @Project=LTRIM(RTRIM(ISNULL(@Project,'')))+'%'
	SELECT Prj_No AS Project
	FROM QualityReport_uvw_VPT_MKT_Shipment
	WHERE Prj_No LIKE @Project
	GROUP BY Prj_No
	ORDER BY Prj_No
END
GO
