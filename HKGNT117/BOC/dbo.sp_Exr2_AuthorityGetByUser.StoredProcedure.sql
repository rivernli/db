USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[sp_Exr2_AuthorityGetByUser]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_Exr2_AuthorityGetByUser] 
	@MenuID VARCHAR(50)
AS
BEGIN
	
	SELECT 
		A.[MenuID]
		,A.[CanSee]
		,B.[domain]
		,B.[uid]
		,B.[name]
	FROM (
		SELECT 
			[UserID]
			,[CanSee]
			,[MenuID]
		FROM [Exr2_Authority]
		WHERE [MenuID]=@MenuID
	) AS A LEFT JOIN [Exr2_User]AS B
	ON  A.[UserID] =B.[domain] +'\'+ B.[uid]
	ORDER BY  A.[CanSee] DESC, B.[name]
END



GO
