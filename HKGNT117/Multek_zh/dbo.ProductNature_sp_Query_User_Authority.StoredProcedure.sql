USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[ProductNature_sp_Query_User_Authority]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create PROCEDURE [dbo].[ProductNature_sp_Query_User_Authority]
	@UserID VARCHAR(50)
AS

SET NOCOUNT ON

--Get user's menus
SELECT a.MenuID ,
	dbo.ProductNature_fun_GetParentMenuName (a.MenuID) AS MenuName,
	m.Description AS ChildMenuName, 
	a.CanSee,
	 m.Page+'?MenuID='+a.MenuID AS NavigateUrl,
	 (
		SELECT ID FROM ProductNature_Menu WHERE ID=(CASE LEN(a.MenuID) WHEN 5 THEN NULL ELSE LEFT(a.MenuID,LEN(a.MenuID)-5) END)
	 ) AS ParentMenuID
INTO #Temp
FROM ProductNature_Authority a left join ProductNature_Menu m
on a.MenuID = m.ID
WHERE a.UserID = @UserID
ORDER BY a.MenuID

SELECT * FROM #Temp WHERE CanSee=1 ORDER BY MenuID



GO
