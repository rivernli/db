USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[PT_sp_Query_Location]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[PT_sp_Query_Location]
	@Name VARCHAR(200)=NULL,
	@Alias VARCHAR(3)=NULL,
	@Enable BIT=NULL,
	@OperatorUserID VARCHAR(50)=NULL
AS

SET NOCOUNT ON

SET @Name='%'+ISNULL(@Name,'')+'%'
SET @Alias='%'+ISNULL(@Alias,'')+'%'

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
		SELECT *
		FROM PT_Location
		WHERE Name LIKE @Name
			AND Alias LIKE @Alias
			AND Name LIKE @OperatorSiteName
		ORDER BY Name
	END
ELSE
	BEGIN
		SELECT *
		FROM PT_Location
		WHERE Name LIKE @Name
			AND Alias LIKE @Alias
			AND Enable=@Enable
			AND Name LIKE @OperatorSiteName
		ORDER BY Name
	END
GO
