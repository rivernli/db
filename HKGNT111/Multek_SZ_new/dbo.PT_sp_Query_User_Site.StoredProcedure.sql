USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[PT_sp_Query_User_Site]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[PT_sp_Query_User_Site]
	-- Add the parameters for the stored procedure here
	@UserID VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT c.Name AS SiteName,a.SiteOwner,a.Administrator
	FROM PT_Users a,PT_Department b,PT_Location c
	WHERE a.DepartmentAutoID=b.AutoID
		AND b.LocationAutoID=c.AutoID
		AND a.UserID=@UserID
END
GO
