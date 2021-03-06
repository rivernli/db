USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MaterialInventory_AuthoritySync]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create PROCEDURE [dbo].[sp_MaterialInventory_AuthoritySync] 
AS
BEGIN

	--Initial user's menus
	INSERT INTO MaterialInventory_Authority ([UserID],[MenuID],[CanSee],[CanAdd],[CanModify],[CanDelete])
	SELECT 
		b.[domain] + '\' + b.[uid]
		,a.[ID]
		,0
		,0
		,0
		,0
	FROM MaterialInventory_Menu AS a,MaterialInventory_User AS b
	WHERE a.[ID] + b.[domain] + '\' + b.[uid] NOT IN (
						SELECT [MenuID] + [UserID]
						FROM  [MaterialInventory_Authority]
						   )

	DELETE MaterialInventory_Authority
	WHERE MenuID NOT IN (
					SELECT [ID]
					FROM MaterialInventory_Menu
				 )
	DELETE MaterialInventory_Authority
	WHERE [UserID] NOT IN (
					SELECT [domain] + '\' + [uid]
					FROM MaterialInventory_User
				 )
	
	
	SELECT @@rowcount
END



GO
