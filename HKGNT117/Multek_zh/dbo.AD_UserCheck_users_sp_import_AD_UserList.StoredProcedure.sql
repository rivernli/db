USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[AD_UserCheck_users_sp_import_AD_UserList]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AD_UserCheck_users_sp_import_AD_UserList]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	TRUNCATE TABLE Multek_ZH.dbo.ActiveDirectory_User

	INSERT INTO dbo.ActiveDirectory_User
	EXEC	[Multek_ZH].[dbo].[AD_UserCheck_users_sp_Query]
			@Domain = N'asia',
			@QueryType = 0,
			@Condition = N'sAMAccountName=''''*'''''
END




GO
