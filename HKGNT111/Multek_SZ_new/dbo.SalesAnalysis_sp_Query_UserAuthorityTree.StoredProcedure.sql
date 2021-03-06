USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[SalesAnalysis_sp_Query_UserAuthorityTree]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SalesAnalysis_sp_Query_UserAuthorityTree]
	@UserID VARCHAR(50)
AS

SET NOCOUNT ON

/*
--Initial user's menus
INSERT INTO SalesAnalysis_Authority (UserID,MenuID)
SELECT b.UserID,a.ID
FROM SalesAnalysis_Menu a,SalesAnalysis_Users b
WHERE a.ID+b.UserID NOT IN (
					SELECT MenuID+UserID
					FROM  SalesAnalysis_Authority
			           )

DELETE SalesAnalysis_Authority
WHERE MenuID NOT IN (
				SELECT ID
				FROM SalesAnalysis_Menu
			 )

--Initial Administrator's authority
UPDATE SalesAnalysis_Authority
SET CanSee=1
WHERE UserID IN
	(SELECT UserID FROM SalesAnalysis_Users WHERE Administrator=1)

UPDATE SalesAnalysis_Authority
SET CanSee=1
WHERE MenuID IN ('00001','00007')
*/

--Get user's menus
SELECT a.MenuID ,
	dbo.SalesAnalysis_fun_GetParentMenuName (a.MenuID) AS MenuName,
	m.Description AS ChildMenuName, 
	a.CanSee,
	 m.Page AS NavigateUrl,
	 (
		SELECT ID FROM SalesAnalysis_Menu WHERE ID=(CASE LEN(a.MenuID) WHEN 5 THEN NULL ELSE LEFT(a.MenuID,LEN(a.MenuID)-5) END)
	 ) AS ParentMenuID
INTO #Temp
FROM SalesAnalysis_Authority a,SalesAnalysis_Menu m
WHERE a.MenuID*=m.ID
	AND a.UserID=@UserID
ORDER BY a.MenuID

SELECT * FROM #Temp ORDER BY MenuID
GO
