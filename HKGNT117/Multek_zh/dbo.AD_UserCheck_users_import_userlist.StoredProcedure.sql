USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[AD_UserCheck_users_import_userlist]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[AD_UserCheck_users_import_userlist]
@File	nvarchar(500)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @SQL				NVARCHAR(MAX)
	DECLARE	@Provider			NVARCHAR(100)
	--DECLARE	@FILE				NVARCHAR(256)
	DECLARE	@ConnectionString	NVARCHAR(1000)
	DECLARE	@Query				NVARCHAR(1000)

	SET @Provider          = N'Microsoft.Jet.OLEDB.4.0'
	SET @FILE              = RTRIM(LTRIM(@FILE))
	SET @ConnectionString  = N'Excel 8.0;DATABASE='+@FILE+';HDR=YES;IMEX=1'
	SET @Query             = N'SELECT * FROM [Sheet1$]'

	SET @SQL = N'SELECT [UserID]
 		FROM OPENROWSET(' + QUOTENAME(@Provider, N'''') + N', ' 
	       + QUOTENAME(@ConnectionString, N'''') + N', '
	       + QUOTENAME(@Query, N'''') + N')'

print @sql

	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#UserList') AND TYPE = 'U')
		DROP TABLE #UserList
		
	CREATE	TABLE #UserList
	(
		[UserID] [NVARCHAR] (50)
	)

	BEGIN
		INSERT INTO #UserList([UserID])

		EXEC SP_EXECUTESQL @SQL
	END

	IF @@ROWCOUNT > 0
		BEGIN
			INSERT INTO Multek_ZH.dbo.AD_UserCheck_users([EmployeeID])
			SELECT * FROM #UserList
		END
END

GO
