USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[PT_sp_Query_User_Site_Department]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[PT_sp_Query_User_Site_Department]
	-- Add the parameters for the stored procedure here
	@UserID VARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT a.*
	FROM PT_Department a
	WHERE a.LocationAutoID =(
								SELECT c.LocationAutoID
								FROM PT_Users b,PT_Department c
								WHERE b.DepartmentAutoID=c.AutoID
									AND b.UserID=@UserID
								
							)
		AND ISNULL(a.Enable,0)=1
END
GO
