USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Monthly_Cu_Tensile_Strength_sp_Query_Log]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 

create PROCEDURE [dbo].[Monthly_Cu_Tensile_Strength_sp_Query_Log]
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
	FROM Monthly_Cu_Tensile_Strength_Log a left join Monthly_Cu_Tensile_Strength_Users b on
	a.UserID=b.UserID
	WHERE 	(a.UserID LIKE @UserID)
		AND a.Operation LIKE @Operation
		AND a.Remark LIKE @Remark
	ORDER BY a.AutoID DESC
END






GO
