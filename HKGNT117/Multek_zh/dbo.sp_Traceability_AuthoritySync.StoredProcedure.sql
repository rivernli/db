USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_Traceability_AuthoritySync]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE  PROCEDURE [dbo].[sp_Traceability_AuthoritySync] 
AS
BEGIN

	--Initial user's menus
	INSERT INTO [Traceability_Authority] ([UserID],[MenuID],[CanSee],[CanAdd],[CanModify],[CanDelete])
	SELECT 
		b.[domain] + '\' + b.[uid]
		,a.[ID]
		,0
		,0
		,0
		,0
	FROM [Traceability_Menu] AS a,[Traceability_User] AS b
	WHERE a.[ID] + b.[domain] + '\' + b.[uid] NOT IN (
						SELECT [MenuID] + [UserID]
						FROM  [Traceability_Authority]
						   )

	DELETE [Traceability_Authority]
	WHERE MenuID NOT IN (
					SELECT [ID]
					FROM [Traceability_Menu]
				 )
	DELETE [Traceability_Authority]
	WHERE [UserID] NOT IN (
					SELECT [domain] + '\' + [uid]
					FROM [Traceability_User]
				 )
	
	
	SELECT @@rowcount
END



GO
