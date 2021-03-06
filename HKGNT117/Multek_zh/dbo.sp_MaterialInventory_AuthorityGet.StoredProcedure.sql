USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MaterialInventory_AuthorityGet]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create PROCEDURE [dbo].[sp_MaterialInventory_AuthorityGet] 
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
	FROM [MaterialInventory_Authority] AS A LEFT JOIN [MaterialInventory_Menu]AS B
	ON  A.[MenuID] =B.[ID]
	WHERE A.[UserID]=@UserID
	ORDER BY A.[MenuID]
END


GO
