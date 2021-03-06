USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_KOI_AuthorityGetByUser]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_KOI_AuthorityGetByUser] 
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
		FROM [KOI_Authority]
		WHERE [MenuID]=@MenuID
	) AS A LEFT JOIN [KOI_User]AS B
	ON  A.[UserID] =B.[domain] +'\'+ B.[uid]
	ORDER BY  A.[CanSee] DESC, B.[name]
END



GO
