USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[B1Parts_sp_Query_User_Authority]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[B1Parts_sp_Query_User_Authority]
	@UserID VARCHAR(50)
AS

SET NOCOUNT ON

--Get user's menus
SELECT a.MenuID ,
	dbo.B1Parts_fun_GetParentMenuName (a.MenuID) AS MenuName, 
	m.Description AS ChildMenuName, 
	a.CanSee,a.User_Right, 
	 m.Page+'?MenuID='+a.MenuID AS NavigateUrl,
	 (
		SELECT ID FROM B1Parts_Menu WHERE ID=(CASE LEN(a.MenuID) WHEN 5 THEN NULL ELSE LEFT(a.MenuID,LEN(a.MenuID)-5) END)
	 ) AS ParentMenuID
INTO #Temp
FROM B1Parts_Authority a left join B1Parts_Menu m
on a.MenuID = m.ID
WHERE a.UserID = @UserID
ORDER BY a.MenuID

SELECT * FROM #Temp WHERE User_Right>0 ORDER BY MenuID 






GO
