USE [ContractTracker]
GO
/****** Object:  StoredProcedure [dbo].[sp_Query_User_Authority]    Script Date: 11/06/2014 15:55:54 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Query_User_Authority]
	@UserID VARCHAR(50)
AS

SET NOCOUNT ON

/*
--Initial user's menus
INSERT INTO Authority (UserID,MenuID)
SELECT b.UserID,a.ID
FROM Menu a,Users b
WHERE a.ID+b.UserID NOT IN (
					SELECT MenuID+UserID
					FROM  Authority
			           )

DELETE Authority
WHERE MenuID NOT IN (
				SELECT ID
				FROM Menu
			 )

--Initial Administrator's authority
UPDATE Authority
SET CanSee=1
WHERE UserID IN
	(SELECT UserID FROM Users WHERE Administrator=1)

UPDATE Authority
SET CanSee=1
WHERE MenuID IN ('00001','00002','00006','00007')
*/

--Get user's menus
SELECT a.MenuID ,
	dbo.fun_GetParentMenuName (a.MenuID) AS MenuName,
	m.Description AS ChildMenuName, 
	a.CanSee,
	 m.Page AS NavigateUrl,
	 (
		SELECT ID FROM Menu WHERE ID=(CASE LEN(a.MenuID) WHEN 5 THEN NULL ELSE LEFT(a.MenuID,LEN(a.MenuID)-5) END)
	 ) AS ParentMenuID
FROM Authority a,Menu m
WHERE a.MenuID*=m.ID
	AND a.UserID=@UserID
ORDER BY a.MenuID
GO
