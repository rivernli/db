USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[PT_sp_Query_Site_Owner]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[PT_sp_Query_Site_Owner]
	-- Add the parameters for the stored procedure here
	@Site VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT a.UserID,a.BDM, a.BDM + '(' + a.Region + '\' + a.Account + ')' AS BDMUserID
	FROM PT_Users a,PT_Department b,PT_Location c
	WHERE a.DepartmentAutoID=b.AutoID
		AND b.LocationAutoID=c.AutoID
		AND c.Name=@Site
		AND ISNULL(a.SiteOwner,0)=1
		AND ISNULL(a.Enable,0)=1
END
GO
