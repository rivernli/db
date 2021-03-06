USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_Query_Forecast_User]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DistributionReport_sp_Query_Forecast_User]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT b.UserID,b.BDM+' ('+b.UserID+')' AS UserName
	FROM DistributionReport_Authority a,DistributionReport_Users b
	WHERE a.UserID=b.UserID
		AND a.MenuID='0002000003'
		AND a.CanSee=1
	ORDER BY b.BDM
END
GO
