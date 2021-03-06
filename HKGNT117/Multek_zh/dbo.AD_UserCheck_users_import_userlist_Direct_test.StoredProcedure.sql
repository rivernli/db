USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[AD_UserCheck_users_import_userlist_Direct_test]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AD_UserCheck_users_import_userlist_Direct_test] 
@UserID	nvarchar(MAX)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @Len INT, @Idx INT
	DECLARE	@UserI	nvarchar(50)

    -- Insert statements for procedure here
	SELECT @Len=LEN(@UserID)
	SELECT @Idx=CHARINDEX(',',@UserID)

	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID('tempdb.#temp') AND TYPE = 'U')
		DROP TABLE #temp

	create table #temp(Userid nvarchar(50))

	SELECT @Len=LEN(@UserID)
	SELECT @Idx=CHARINDEX(',',@UserID)

	WHILE @Idx>0
	BEGIN
		SELECT @UserI=SUBSTRING(@UserID,1,@Idx-1)
		SELECT @UserID=SUBSTRING(@UserID,@Idx+1,@Len-@Idx)
		SELECT @Idx=CHARINDEX(',',@UserID)
		insert into #temp values(@UserI)
	END

	insert into Multek_ZH.dbo.AD_UserCheck_users([EmployeeID]) select * from #temp
	--INSERT INTO Multek_ZH.dbo.AD_UserCheck_users([EmployeeID]) values(@UserID)
END


GO
