USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Product_Cost_Analysis_sp_Query_User_Authority]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
create PROCEDURE [dbo].[Product_Cost_Analysis_sp_Query_User_Authority]
	@UserID VARCHAR(50)
AS

SET NOCOUNT ON

--Get user's menus
SELECT a.MenuID ,
	dbo.Product_Cost_Analysis_fun_GetParentMenuName (a.MenuID) AS MenuName,
	m.Description AS ChildMenuName, 
	a.CanSee,
	 m.Page AS NavigateUrl,
	 (
		SELECT ID FROM Product_Cost_Analysis_Menu WHERE ID=(CASE LEN(a.MenuID) WHEN 5 THEN NULL ELSE LEFT(a.MenuID,LEN(a.MenuID)-5) END)
	 ) AS ParentMenuID
INTO #Temp
FROM Product_Cost_Analysis_Authority a left join Product_Cost_Analysis_Menu m
on a.MenuID = m.ID
WHERE a.UserID = @UserID
ORDER BY a.MenuID


	
	SELECT * FROM #Temp WHERE CanSee=1 ORDER BY MenuID









GO
