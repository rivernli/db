USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_Query_RoleUser]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DistributionReport_sp_Query_RoleUser]
	-- Add the parameters for the stored procedure here
	@MenuID VARCHAR(50),
	@UserID VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT a.UserID,b.BDM +'('+b.UserID+')' AS UserName,a.CanSee
	FROM DistributionReport_Authority a,DistributionReport_Users b
	WHERE a.UserID=b.UserID
		AND a.MenuID=@MenuID
		AND a.UserID<>@UserID
	--ORDER BY a.UserID,b.BDM
	ORDER BY a.CanSee DESC,b.BDM,b.Region,b.Account

END
GO
