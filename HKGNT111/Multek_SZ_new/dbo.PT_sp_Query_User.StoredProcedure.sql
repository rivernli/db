USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[PT_sp_Query_User]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[PT_sp_Query_User]
	@Site VARCHAR(50)=NULL,
	@Department VARCHAR(50)=NULL,
	@Domain VARCHAR(50)=NULL,
	@Account VARCHAR(50)=NULL,
	@BDMGAM	VARCHAR(50)=NULL,
	@Email	VARCHAR(50)=NULL,
	@OperatorUserID VARCHAR(50)=NULL
AS

SET NOCOUNT ON

SET @Site='%'+RTRIM(LTRIM(ISNULL(@Site,'')))+'%'
SET @Department='%'+RTRIM(LTRIM(ISNULL(@Department,'')))+'%'

SET @Domain=ISNULL(@Domain,'')
SET @Domain='%'+RTRIM(LTRIM(@Domain))+'%'
SET @Account=ISNULL(@Account,'')
SET @Account='%'+RTRIM(LTRIM(@Account))+'%'
SET @BDMGAM=ISNULL(@BDMGAM,'')
SET @BDMGAM='%'+RTRIM(LTRIM(@BDMGAM))+'%'
SET @Email=ISNULL(@Email,'')
SET @Email='%'+RTRIM(LTRIM(@Email))+'%'

DECLARE @OperatorSiteName VARCHAR(500)

IF EXISTS(SELECT * FROM PT_uvw_User WHERE UserID=@OperatorUserID AND Administrator<>1 )
	BEGIN
		SET @OperatorSiteName=(SELECT SiteName FROM PT_uvw_User WHERE UserID=@OperatorUserID)
	END
IF EXISTS(SELECT * FROM PT_uvw_User WHERE UserID=@OperatorUserID AND Administrator=1)OR @OperatorUserID IS NULL
	BEGIN
		SET @OperatorSiteName='%'
	END

SELECT a.*,a.BDM+' ('+a.Account+')' AS UserName ,b.Name AS DepartmentName,c.Name AS LocationName
FROM PT_Users a,PT_Department b,PT_Location c
WHERE a.Region LIKE @Domain
	AND a.Account LIKE @Account
	AND a.BDM LIKE @BDMGAM
	AND a.Email LIKE @Email
	AND a.DepartmentAutoID=b.AutoID
	AND b.LocationAutoID=c.AutoID
	AND c.Name LIKE @Site
	AND b.Name LIKE @Department
	AND c.Name LIKE @OperatorSiteName
ORDER BY a.UserID ASC
GO
