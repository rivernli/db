USE [AMD_Lab]
GO
/****** Object:  StoredProcedure [dbo].[AMD_sp_Query_Log]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*============================================ AMD_sp_Query_Log ======================================================================*/

CREATE PROCEDURE [dbo].[AMD_sp_Query_Log]
	@UserID VARCHAR(50),
	@Operation VARCHAR(50),
	@Remark VARCHAR(5000)
AS
BEGIN
	SET NOCOUNT ON;
	
	SET @UserID='%'+LTRIM(RTRIM(ISNULL(@UserID,'')))+'%'
	SET @Operation='%'+LTRIM(RTRIM(ISNULL(@Operation,'')))+'%'
	SET @Remark='%'+ltrim(rtrim(ISNULL(@Remark,'')))+'%'

	SELECT a.* ,b.BDM+' ('+b.Account+')' AS OperatorName
	FROM AMD_Log a left join AMD_Users b on
	a.UserID=b.UserID
	WHERE 	(a.UserID LIKE @UserID)
		AND a.Operation LIKE @Operation
		AND a.Remark LIKE @Remark
	ORDER BY a.AutoID DESC
END

GO
