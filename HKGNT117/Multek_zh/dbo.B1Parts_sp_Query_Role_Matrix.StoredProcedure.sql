USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[B1Parts_sp_Query_Role_Matrix]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



create PROCEDURE [dbo].[B1Parts_sp_Query_Role_Matrix] 
	@Domain VARCHAR(50)=NULL,
	@Account VARCHAR(50)=NULL,
	@BDMGAM	VARCHAR(50)=NULL,
	@Email	VARCHAR(50)=NULL
AS
BEGIN

	SET NOCOUNT ON

	SET @Domain=ISNULL(@Domain,'')
	SET @Domain='%'+RTRIM(LTRIM(@Domain))+'%'
	SET @Account=ISNULL(@Account,'')
	SET @Account='%'+RTRIM(LTRIM(@Account))+'%'
	SET @BDMGAM=ISNULL(@BDMGAM,'')
	SET @BDMGAM='%'+RTRIM(LTRIM(@BDMGAM))+'%'
	SET @Email=ISNULL(@Email,'')
	SET @Email='%'+RTRIM(LTRIM(@Email))+'%'

    -- Insert statements for procedure here
	DECLARE @UserID VARCHAR(50),@UserBDM VARCHAR(200),@SQLString VARCHAR(5000)

	SELECT ID,Description AS Roles
	INTO #Temp
	FROM B1Parts_Menu
	ORDER BY ID

	DECLARE User_C CURSOR FOR
	SELECT UserID,BDM+' ('+UserID+')' AS UserBDM
	FROM B1Parts_Users
	WHERE Region LIKE @Domain
			AND Account LIKE @Account
			AND BDM LIKE @BDMGAM
			AND Email LIKE @Email

	OPEN User_C
	FETCH NEXT FROM User_C INTO @UserID,@UserBDM
	WHILE @@FETCH_STATUS=0
		BEGIN
			SET @SQLString='ALTER TABLE #Temp ADD ['+@UserBDM+']  BIT NULL'
			EXECUTE (@SQLString)
			SET @SQLString='UPDATE #Temp SET ['+@UserBDM+']=b.CanSee FROM #Temp a,B1Parts_Authority b WHERE b.UserID='+''''+@UserID+''''+' AND a.ID=b.MenuID'
			EXECUTE (@SQLString)
			FETCH NEXT FROM User_C INTO @UserID,@UserBDM
		END

	CLOSE User_C
	DEALLOCATE User_C

	SELECT * FROM #Temp
END








GO
