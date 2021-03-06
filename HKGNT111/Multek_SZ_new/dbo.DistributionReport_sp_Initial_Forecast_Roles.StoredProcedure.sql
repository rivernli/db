USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_Initial_Forecast_Roles]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DistributionReport_sp_Initial_Forecast_Roles]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO DistributionReport_Forecast_Authority(UserID)
	SELECT b.UserID
	FROM DistributionReport_Authority a,DistributionReport_Users b
	WHERE a.UserID=b.UserID
		AND a.MenuID='0002000003'
		AND a.CanSee=1
		AND a.UserID NOT IN (SELECT UserID FROM DistributionReport_Forecast_Authority)
	
	DELETE DistributionReport_Forecast_Authority
	WHERE UserID NOT IN (
							SELECT b.UserID
							FROM DistributionReport_Authority a,DistributionReport_Users b
							WHERE a.UserID=b.UserID
								AND a.MenuID='0002000003'
								AND a.CanSee=1
						)
	UPDATE DistributionReport_Forecast_Authority
	SET Output=1,Shipment=1,Outbound=1,HubIn=1,RMA=1,Scrap=1,InComing=1,B1=1,B2F=1,B3=1,B4=1,B5=1,VVI=1,SUB=1,ZhuHai=1,ZhuHaiEXB2F=1
	FROM DistributionReport_Forecast_Authority a,DistributionReport_Users b
	WHERE a.UserID=b.UserID
		AND b.Administrator=1
END
GO
