USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Check_Frank_NorthField]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Check_Frank_NorthField]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF (SELECT COUNT(*) FROM [10.10.8.226].ODS_Nfd.dbo.vwr_shipments)=0
		BEGIN
			EXECUTE sp_Send_Mail @TO='peter.xu@hk.multek.com;jianguang.zhang@hk.multek.com',@Subject='North Field has no data in Frank ODS_Nfd.dbo.vwr_shipments, please check it !',@Body=''
		END
		
END
GO
