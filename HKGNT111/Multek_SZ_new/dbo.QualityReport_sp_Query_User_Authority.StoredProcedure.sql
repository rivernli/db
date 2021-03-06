USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[QualityReport_sp_Query_User_Authority]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[QualityReport_sp_Query_User_Authority]
	@UserID VARCHAR(50)
AS

SET NOCOUNT ON

/*
--Initial user's menus
INSERT INTO QualityReport_Authority (UserID,MenuID)
SELECT b.UserID,a.ID
FROM QualityReport_Menu a,QualityReport_Users b
WHERE a.ID+b.UserID NOT IN (
					SELECT MenuID+UserID
					FROM  QualityReport_Authority
			           )

DELETE QualityReport_Authority
WHERE MenuID NOT IN (
				SELECT ID
				FROM QualityReport_Menu
			 )

--Initial Administrator's authority
UPDATE QualityReport_Authority
SET CanSee=1
WHERE UserID IN
	(SELECT UserID FROM QualityReport_Users WHERE Administrator=1)

UPDATE QualityReport_Authority
SET CanSee=1
WHERE MenuID IN ('00001')
*/

--Get user's menus
SELECT a.MenuID ,
	dbo.QualityReport_fun_GetParentMenuName (a.MenuID) AS MenuName,
	m.Description AS ChildMenuName, 
	a.CanSee,
	 m.Page AS NavigateUrl,
	 (
		SELECT ID FROM QualityReport_Menu WHERE ID=(CASE LEN(a.MenuID) WHEN 5 THEN NULL ELSE LEFT(a.MenuID,LEN(a.MenuID)-5) END)
	 ) AS ParentMenuID
FROM QualityReport_Authority a,QualityReport_Menu m
WHERE a.MenuID*=m.ID
	AND a.UserID=@UserID
ORDER BY a.MenuID
GO
