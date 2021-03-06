USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_Query_Page]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DistributionReport_sp_Query_Page]
	-- Add the parameters for the stored procedure here
	@UserID VARCHAR(50),
	@PageDescription VARCHAR(300)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    SET @PageDescription='%'+RTRIM(@PageDescription)+'%'
	SELECT a.*
	FROM DistributionReport_Menu a,DistributionReport_Authority b
	WHERE a.ID=b.MenuID
		AND b.UserID=@UserID
		AND b.CanSee=1
		AND (a.Description LIKE @PageDescription	OR a.Page LIKE @PageDescription)
		AND a.Page IS NOT NULL
	ORDER BY ID
END
GO
