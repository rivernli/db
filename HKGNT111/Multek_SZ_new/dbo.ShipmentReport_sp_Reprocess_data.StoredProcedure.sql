USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Reprocess_data]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Reprocess_data]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE ShipmentReport_Shipped_All_Fixed_Fiscal
	SET M1=ISNULL(M1,0),
		M2=ISNULL(M2,0),
		M3=ISNULL(M3,0),
		M4=ISNULL(M4,0),
		M5=ISNULL(M5,0),
		M6=ISNULL(M6,0),
		M7=ISNULL(M7,0),
		M8=ISNULL(M8,0),
		M9=ISNULL(M9,0),
		M10=ISNULL(M10,0),
		M11=ISNULL(M11,0),
		M12=ISNULL(M12,0)
END
GO
