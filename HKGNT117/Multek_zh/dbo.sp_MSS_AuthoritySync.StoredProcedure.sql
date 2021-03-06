USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MSS_AuthoritySync]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_MSS_AuthoritySync] 
AS
BEGIN

	--Initial user's menus
	INSERT INTO MSS_Authority ([UserID],[MenuID],[CanSee],[CanAdd],[CanModify],[CanDelete])
	SELECT 
		b.[domain] + '\' + b.[uid]
		,a.[ID]
		,0
		,0
		,0
		,0
	FROM MSS_Menu AS a,MSS_User AS b
	WHERE a.[ID] + b.[domain] + '\' + b.[uid] NOT IN (
						SELECT [MenuID] + [UserID]
						FROM  [MSS_Authority]
						   )

	DELETE MSS_Authority
	WHERE MenuID NOT IN (
					SELECT [ID]
					FROM MSS_Menu
				 )
	DELETE MSS_Authority
	WHERE [UserID] NOT IN (
					SELECT [domain] + '\' + [uid]
					FROM MSS_User
				 )
	
	
	SELECT @@rowcount
END



GO
