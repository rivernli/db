USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Update_Forecast]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Update_Forecast]
	-- Add the parameters for the stored procedure here
	@UserID VARCHAR(50),
	@Site VARCHAR(50),
	@Plant VARCHAR(50),
	@Year INT,
	@M1 VARCHAR(50),
	@M2 VARCHAR(50),
	@M3 VARCHAR(50),
	@M4 VARCHAR(50),
	@M5 VARCHAR(50),
	@M6 VARCHAR(50),
	@M7 VARCHAR(50),
	@M8 VARCHAR(50),
	@M9 VARCHAR(50),
	@M10 VARCHAR(50),
	@M11 VARCHAR(50),
	@M12 VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO ShipmentReport_Shipped_All_Forecast_History(UserID,Site,Plant,Year,M1,M2,M3,M4,M5,M6,M7,M8,M9,M10,M11,M12)
	SELECT @UserID AS UserID,*
	FROM ShipmentReport_Shipped_All_Forecast
	WHERE Site=@Site
		AND Plant=@Plant
		AND Year=@Year

	UPDATE ShipmentReport_Shipped_All_Forecast
	SET M1=@M1,M2=@M2,M3=@M3,M4=@M4,M5=@M5,M6=@M6,M7=@M7,M8=@M8,M9=@M9,M10=@M10,M11=@M11,M12=@M12
	WHERE Site=@Site
		AND Plant=@Plant
		AND Year=@Year

END
GO
