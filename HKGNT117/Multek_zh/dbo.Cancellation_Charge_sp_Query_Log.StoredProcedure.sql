USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Cancellation_Charge_sp_Query_Log]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*============================================ Cancellation_Charge_sp_Query_Log ======================================================================*/

CREATE PROCEDURE [dbo].[Cancellation_Charge_sp_Query_Log]
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
	FROM Cancellation_Charge_Log a left join Cancellation_Charge_Users b on
	a.UserID=b.UserID
	WHERE 	(a.UserID LIKE @UserID)
		AND a.Operation LIKE @Operation
		AND a.Remark LIKE @Remark
	ORDER BY a.AutoID DESC
END

GO
