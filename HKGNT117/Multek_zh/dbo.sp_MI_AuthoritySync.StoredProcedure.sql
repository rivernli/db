USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MI_AuthoritySync]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_MI_AuthoritySync] 
AS
BEGIN

	--Initial user's menus
	INSERT INTO MI_Authority ([UserID],[MenuID],[CanSee],[CanAdd],[CanModify],[CanDelete])
	SELECT 
		b.[domain] + '\' + b.[uid]
		,a.[ID]
		,0
		,0
		,0
		,0
	FROM MI_Menu AS a,MI_User AS b
	WHERE a.[ID] + b.[domain] + '\' + b.[uid] NOT IN (
						SELECT [MenuID] + [UserID]
						FROM  [MI_Authority]
						   )

	DELETE MI_Authority
	WHERE MenuID NOT IN (
					SELECT [ID]
					FROM MI_Menu
				 )
	DELETE MI_Authority
	WHERE [UserID] NOT IN (
					SELECT [domain] + '\' + [uid]
					FROM MI_User
				 )
	
	
	SELECT @@rowcount
END




GO
