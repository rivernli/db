USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[AD_UserCheck_users_import_userlist_Direct]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AD_UserCheck_users_import_userlist_Direct] 
@UserID	nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Multek_ZH.dbo.AD_UserCheck_users([EmployeeID]) values(@UserID)
END

GO
