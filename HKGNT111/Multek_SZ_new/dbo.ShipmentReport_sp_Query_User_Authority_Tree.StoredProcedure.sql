USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Query_User_Authority_Tree]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Query_User_Authority_Tree]
	@UserID VARCHAR(50)
AS

SET NOCOUNT ON

/*
--Initial user's menus
INSERT INTO ShipmentReport_Authority (UserID,MenuID)
SELECT b.UserID,a.ID
FROM ShipmentReport_Menu a,ShipmentReport_Users b
WHERE a.ID+b.UserID NOT IN (
					SELECT MenuID+UserID
					FROM  ShipmentReport_Authority
			           )

DELETE ShipmentReport_Authority
WHERE MenuID NOT IN (
				SELECT ID
				FROM ShipmentReport_Menu
			 )

--Initial Administrator's authority
UPDATE ShipmentReport_Authority
SET CanSee=1
WHERE UserID IN
	(SELECT UserID FROM ShipmentReport_Users WHERE Administrator=1)

UPDATE ShipmentReport_Authority
SET CanSee=1
WHERE MenuID IN ('00001','00005')
*/

--Get user's menus
SELECT a.MenuID ,
	dbo.ShipmentReport_fun_GetParentMenuName (a.MenuID) AS MenuName,
	m.Description AS ChildMenuName, 
	a.CanSee,
	 m.Page AS NavigateUrl,
	 (
		SELECT ID FROM ShipmentReport_Menu WHERE ID=(CASE LEN(a.MenuID) WHEN 5 THEN NULL ELSE LEFT(a.MenuID,LEN(a.MenuID)-5) END)
	 ) AS ParentMenuID
INTO #Temp
FROM ShipmentReport_Authority a,ShipmentReport_Menu m
WHERE a.MenuID*=m.ID
	AND a.UserID=@UserID
ORDER BY a.MenuID

SELECT * FROM #Temp ORDER BY MenuID
GO
