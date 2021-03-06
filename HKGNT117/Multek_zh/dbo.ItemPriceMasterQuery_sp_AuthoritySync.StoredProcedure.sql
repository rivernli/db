USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[ItemPriceMasterQuery_sp_AuthoritySync]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
create PROCEDURE [dbo].[ItemPriceMasterQuery_sp_AuthoritySync] 
AS
BEGIN

	--Initial user's menus
	INSERT INTO ItemPriceMasterQuery_Authority ([UserID],[MenuID],[CanSee],[CanAdd],[CanModify],[CanDelete])
	SELECT 
		b.[domain] + '\' + b.[uid]
		,a.[ID]
		,0
		,0
		,0
		,0
	FROM ItemPriceMasterQuery_Menu AS a,ItemPriceMasterQuery_User AS b
	WHERE a.[ID] + b.[domain] + '\' + b.[uid] NOT IN (
						SELECT [MenuID] + [UserID]
						FROM  [ItemPriceMasterQuery_Authority]
						   )

	DELETE ItemPriceMasterQuery_Authority
	WHERE MenuID NOT IN (
					SELECT [ID]
					FROM ItemPriceMasterQuery_Menu
				 )
	DELETE ItemPriceMasterQuery_Authority
	WHERE [UserID] NOT IN (
					SELECT [domain] + '\' + [uid]
					FROM ItemPriceMasterQuery_User
				 )
	
	
	SELECT @@rowcount
END




GO
