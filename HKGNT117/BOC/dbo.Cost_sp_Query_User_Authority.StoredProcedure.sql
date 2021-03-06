USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[Cost_sp_Query_User_Authority]    Script Date: 2014/11/12 17:02:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Cost_sp_Query_User_Authority]
	@UserID VARCHAR(50)
AS

SET NOCOUNT ON


----Get user's menus
--SELECT a.MenuID ,
--	dbo.Cost_fun_GetParentMenuName (a.MenuID) AS MenuName,
--	m.Description AS ChildMenuName, 
--	a.CanSee,
--	 m.Page AS NavigateUrl,
--	 (
--		SELECT ID FROM Cost_Menu WHERE ID=(CASE LEN(a.MenuID) WHEN 5 THEN NULL ELSE LEFT(a.MenuID,LEN(a.MenuID)-5) END)
--	 ) AS ParentMenuID
--FROM Cost_Authority a,Cost_Menu m
--WHERE a.MenuID = m.ID
--	AND a.UserID=@UserID
--ORDER BY a.MenuID

IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#Temp') and type = 'U')
	drop table #Temp

SELECT a.MenuID ,
	dbo.Cost_fun_GetParentMenuName (a.MenuID) AS MenuName,
	m.Description AS ChildMenuName, 
	a.CanSee,
	 m.Page AS NavigateUrl,
	 (
		SELECT ID FROM Cost_Menu WHERE ID=(CASE LEN(a.MenuID) WHEN 5 THEN NULL ELSE LEFT(a.MenuID,LEN(a.MenuID)-5) END)
	 ) AS ParentMenuID
INTO #Temp
FROM Cost_Authority a left join Cost_Menu m
on a.MenuID = m.ID
WHERE a.UserID=@UserID
ORDER BY a.MenuID

SELECT * FROM #Temp WHERE CanSee=1 ORDER BY MenuID

--SELECT a.MenuID ,
--	dbo.EXR2_fun_GetParentMenuName (a.MenuID) AS MenuName,
--	m.Description AS ChildMenuName, 
--	a.CanSee,
--	 m.Page AS NavigateUrl,
--	 (
--		SELECT ID FROM EXR2_Menu WHERE ID=(CASE LEN(a.MenuID) WHEN 5 THEN NULL ELSE LEFT(a.MenuID,LEN(a.MenuID)-5) END)
--	 ) AS ParentMenuID
--INTO #Temp
--FROM EXR2_Authority a left join EXR2_Menu m
--on a.MenuID = m.ID
--WHERE a.UserID = @UserID
--ORDER BY a.MenuID

GO
