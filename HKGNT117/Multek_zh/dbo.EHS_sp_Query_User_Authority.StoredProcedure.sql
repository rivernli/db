USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[EHS_sp_Query_User_Authority]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[EHS_sp_Query_User_Authority]
	@UserID VARCHAR(50)
AS

SET NOCOUNT ON

--Get user's menus
SELECT a.MenuID ,
	dbo.EHS_fun_GetParentMenuName (a.MenuID) AS MenuName,
	m.Description AS ChildMenuName, 
	a.CanSee,a.User_Right, 
	 m.Page+'?MenuID='+a.MenuID AS NavigateUrl,
	 (
		SELECT ID FROM EHS_Menu WHERE ID=(CASE LEN(a.MenuID) WHEN 5 THEN NULL ELSE LEFT(a.MenuID,LEN(a.MenuID)-5) END)
	 ) AS ParentMenuID
INTO #Temp
FROM EHS_Authority a left join EHS_Menu m
on a.MenuID = m.ID
WHERE a.UserID = @UserID
ORDER BY a.MenuID

--SELECT * FROM #Temp WHERE CanSee=1 ORDER BY MenuID 
 SELECT * FROM #Temp WHERE User_Right>0 ORDER BY MenuID 







GO
