USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_Update_User_Customer_Role]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DistributionReport_sp_Update_User_Customer_Role]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE DistributionReport_Authority
	SET CanSee=0
	FROM DistributionReport_Authority a,DistributionReport_Users b,DistributionReport_Menu c
	WHERE a.UserID=b.UserID
		AND a.MenuID=c.ID
		AND (c.Description LIKE '%Customer%' AND c.Page LIKE '%China%' )
		AND b.Administrator=0
END
GO
