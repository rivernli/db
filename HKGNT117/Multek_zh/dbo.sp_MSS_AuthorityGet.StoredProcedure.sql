USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MSS_AuthorityGet]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_MSS_AuthorityGet] 
	@uid nvarchar(50)
	,@domain nvarchar(50)
AS
BEGIN
	DECLARE @UserID VARCHAR(50)
	SET @UserID= @domain +'\'+ @uid
	SELECT 
		A.[MenuID]
		,substring(A.[MenuID], 0, LEN([MenuID])-4)AS ParentMenuID
		,B.[Description]
		,A.[CanSee]
	FROM [MSS_Authority] AS A LEFT JOIN [MSS_Menu]AS B
	ON  A.[MenuID] =B.[ID]
	WHERE A.[UserID]=@UserID
	ORDER BY A.[MenuID]
END


GO
