USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Query_Forecast]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Query_Forecast]
	-- Add the parameters for the stored procedure here
	@Year VARCHAR(4)=NULL,
	@Site VARCHAR(50)=NULL,
	@Plant VARCHAR(50)=NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SET @Site=ISNULL(@Site,'')
	--SET @Plant='%'+ISNULL(RTRIM(@Plant),'')+'%'
	SET @Plant=ISNULL(RTRIM(@Plant),'')
	SELECT @Year AS Year,
		   @Site AS Site,
		   @Plant AS Plant,
		   M1 AS Forecast1,
		   M2 AS Forecast2,
		   M3 AS Forecast3,
		   M4 AS Forecast4,
		   M5 AS Forecast5,
		   M6 AS Forecast6,
		   M7 AS Forecast7,
		   M8 AS Forecast8,
		   M9 AS Forecast9,
		   M10 AS Forecast10,
		   M11 AS Forecast11,
		   M12 AS Forecast12
	FROM ShipmentReport_Shipped_All_Forecast
	WHERE Year=@Year
		AND RTRIM(LTRIM(Site))=@Site
		AND RTRIM(LTRIM(Plant)) = @Plant
END
GO
