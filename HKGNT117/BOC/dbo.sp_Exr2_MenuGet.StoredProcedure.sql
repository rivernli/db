USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[sp_Exr2_MenuGet]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_Exr2_MenuGet] 
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
		,B.[Page]
		,B.[Target]
	FROM [Exr2_Authority] AS A LEFT JOIN [Exr2_Menu]AS B
	ON  A.[MenuID] =B.[ID]
	WHERE A.[UserID]=@UserID
		AND A.[CanSee]=1
	ORDER BY A.[MenuID]
END



GO
