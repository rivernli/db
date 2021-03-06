USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[sp_Exr2_AuthoritySync]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_Exr2_AuthoritySync] 
AS
BEGIN

	--Initial user's menus
	INSERT INTO Exr2_Authority ([UserID],[MenuID],[CanSee],[CanAdd],[CanModify],[CanDelete])
	SELECT 
		b.[domain] + '\' + b.[uid]
		,a.[ID]
		,0
		,0
		,0
		,0
	FROM Exr2_Menu AS a,Exr2_User AS b
	WHERE a.[ID] + b.[domain] + '\' + b.[uid] NOT IN (
						SELECT [MenuID] + [UserID]
						FROM  [Exr2_Authority]
						   )

	DELETE Exr2_Authority
	WHERE MenuID NOT IN (
					SELECT [ID]
					FROM Exr2_Menu
				 )
	DELETE Exr2_Authority
	WHERE [UserID] NOT IN (
					SELECT [domain] + '\' + [uid]
					FROM Exr2_User
				 )
	
	
	SELECT @@rowcount
END



GO
