USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_KOI_AuthoritySync]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create PROCEDURE [dbo].[sp_KOI_AuthoritySync] 
AS
BEGIN

	--Initial user's menus
	INSERT INTO KOI_Authority ([UserID],[MenuID],[CanSee],[CanAdd],[CanModify],[CanDelete])
	SELECT 
		b.[domain] + '\' + b.[uid]
		,a.[ID]
		,0
		,0
		,0
		,0
	FROM KOI_Menu AS a,KOI_User AS b
	WHERE a.[ID] + b.[domain] + '\' + b.[uid] NOT IN (
						SELECT [MenuID] + [UserID]
						FROM  [KOI_Authority]
						   )

	DELETE KOI_Authority
	WHERE MenuID NOT IN (
					SELECT [ID]
					FROM [KOI_Menu]
				 )
	DELETE [KOI_Authority]
	WHERE [UserID] NOT IN (
					SELECT [domain] + '\' + [uid]
					FROM [KOI_User]
				 )
	
	
	SELECT @@rowcount
END



GO
