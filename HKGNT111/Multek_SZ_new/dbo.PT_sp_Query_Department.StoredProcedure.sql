USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[PT_sp_Query_Department]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[PT_sp_Query_Department]
	@Location VARCHAR(200)=NULL,
	@Name VARCHAR(200)=NULL,
	@Distribution VARCHAR(200)=NULL,
	@Enable	BIT=NULL,
	@OperatorUserID VARCHAR(50)=NULL
AS

SET NOCOUNT ON

SET @Location='%'+ISNULL(@Location,'')+'%'
SET @Name='%'+ISNULL(@Name,'')+'%'
SET @Distribution='%'+ISNULL(@Distribution,'')+'%'

DECLARE @OperatorSiteName VARCHAR(500)

IF EXISTS(SELECT * FROM PT_uvw_User WHERE UserID=@OperatorUserID AND Administrator<>1 )
	BEGIN
		SET @OperatorSiteName=(SELECT SiteName FROM PT_uvw_User WHERE UserID=@OperatorUserID)
	END
IF EXISTS(SELECT * FROM PT_uvw_User WHERE UserID=@OperatorUserID AND Administrator=1)OR @OperatorUserID IS NULL
	BEGIN
		SET @OperatorSiteName='%'
	END

IF @Enable IS NULL
	BEGIN
		SELECT a.*,b.Name AS LocationName
		FROM PT_Department a,PT_Location b
		WHERE	a.LocationAutoID=b.AutoID 
				AND a.Name LIKE @Name
				AND a.Distribution LIKE @Distribution
				AND b.Name LIKE @Location
				AND b.Name LIKE @OperatorSiteName
		ORDER BY b.Name,a.Name	
	END
ELSE
	BEGIN
		SELECT a.*,b.Name AS LocationName
		FROM PT_Department a,PT_Location b
		WHERE	a.LocationAutoID=b.AutoID 
				AND a.Name LIKE @Name
				AND a.Distribution LIKE @Distribution
				AND b.Name LIKE @Location
				AND a.Enable=@Enable
				AND b.Enable=@Enable
				AND b.Name LIKE @OperatorSiteName
		ORDER BY b.Name,a.Name	
	END
GO
