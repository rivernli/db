USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Query_Standard_OEM_Customer]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Query_Standard_OEM_Customer]
	-- Add the parameters for the stored procedure here
	@Baan_OEM VARCHAR(MAX),
	@Baan_Customer VARCHAR(MAX),
	@Baan_Loc VARCHAR(MAX),
	@Standard_OEM VARCHAR(MAX),
	@Standard_Customer VARCHAR(MAX)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SET @Baan_OEM='%'+RTRIM(LTRIM(ISNULL(@Baan_OEM,'')))+'%'
	SET @Baan_Customer='%'+RTRIM(LTRIM(ISNULL(@Baan_Customer,'')))+'%'
	SET @Baan_Loc='%'+RTRIM(LTRIM(ISNULL(@Baan_Loc,'')))+'%'
	SET @Standard_OEM='%'+RTRIM(LTRIM(ISNULL(@Standard_OEM,'')))+'%'
	SET @Standard_Customer='%'+RTRIM(LTRIM(ISNULL(@Standard_Customer,'')))+'%'
	
	SELECT * 
	FROM ShipmentReport_OEM_Customer
	WHERE ISNULL(Baan_OEM,'') LIKE @Baan_OEM
		AND ISNULL(Baan_Customer,'') LIKE @Baan_Customer
		AND ISNULL(Baan_Loc,'') LIKE @Baan_Loc
		AND ISNULL(Std_OEM,'') LIKE @Standard_OEM
		AND ISNULL(Std_Customer,'') LIKE @Standard_Customer
END
GO
