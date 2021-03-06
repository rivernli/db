USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[PT_sp_Query_Department_CheckList]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PT_sp_Query_Department_CheckList] 
	@Site VARCHAR(50)=NULL,
	@Department VARCHAR(50)=NULL,
	@OperatorUserID VARCHAR(50)=NULL
AS
BEGIN

	SET NOCOUNT ON

	SET @Site='%'+RTRIM(LTRIM(ISNULL(@Site,'')))+'%'
	SET @Department='%'+RTRIM(LTRIM(ISNULL(@Department,'')))+'%'

	--Initial Department CheckList
	DELETE PT_Department_CheckList WHERE CheckListAutoID NOT IN (SELECT AutoID FROM PT_CheckList)
	INSERT INTO PT_Department_CheckList (DepartmentAutoID,CheckListAutoID)
	SELECT a.AutoID AS DepartmentAutoID ,b.AutoID AS CheckListAutoID
	FROM PT_Department a,PT_CheckList b
	WHERE a.AutoID NOT IN (SELECT DepartmentAutoID FROM PT_Department_CheckList)
		AND b.AutoID NOT IN (SELECT CheckListAutoID FROM PT_Department_CheckList)

	DECLARE @DepartmentAutoID INT,@DepartmentName VARCHAR(500),@SQLString VARCHAR(5000)
	DECLARE @OperatorSiteName VARCHAR(500)

	IF EXISTS(SELECT * FROM PT_uvw_User WHERE UserID=@OperatorUserID AND Administrator<>1 )
		BEGIN
			SET @OperatorSiteName=(SELECT SiteName FROM PT_uvw_User WHERE UserID=@OperatorUserID)
		END
	IF EXISTS(SELECT * FROM PT_uvw_User WHERE UserID=@OperatorUserID AND Administrator=1)OR @OperatorUserID IS NULL
		BEGIN
			SET @OperatorSiteName='%'
		END

	SELECT AutoID,Name AS CheckList
	INTO #Temp
	FROM PT_CheckList

	DECLARE Department_C CURSOR FOR 
	SELECT a.AutoID,a.Name +' ('+b.Name+')' AS Department
	FROM PT_Department a,PT_Location b
	WHERE a.LocationAutoID=b.AutoID
			AND a.Enable=1
			AND a.Name LIKE @Department
			AND b.Name LIKE @Site
			AND b.Name LIKE @OperatorSiteName
	ORDER BY b.Name,a.Name

	OPEN Department_C
	FETCH NEXT FROM Department_C INTO @DepartmentAutoID,@DepartmentName
	WHILE @@FETCH_STATUS=0
		BEGIN
			SET @SQLString='ALTER TABLE #Temp ADD ['+@DepartmentName+']  BIT NULL'
			EXECUTE (@SQLString)
			SET @SQLString='UPDATE #Temp SET ['+@DepartmentName+']=b.Enable FROM #Temp a,PT_Department_CheckList b WHERE b.DepartmentAutoID='+''''+CONVERT(VARCHAR(50),@DepartmentAutoID)+''''+' AND a.AutoID=b.CheckListAutoID'
			EXECUTE (@SQLString)
			FETCH NEXT FROM Department_C INTO @DepartmentAutoID,@DepartmentName
		END

	CLOSE Department_C
	DEALLOCATE Department_C

	SELECT * FROM #Temp
END
GO
