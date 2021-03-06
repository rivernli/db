USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[PT_sp_Query_User_Authority]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PT_sp_Query_User_Authority]
	@UserID VARCHAR(50)
AS

SET NOCOUNT ON

--Get user's menus
SELECT a.MenuID ,
	dbo.PT_fun_GetParentMenuName (a.MenuID) AS MenuName,
	m.Description AS ChildMenuName, 
	a.CanSee,
	 m.Page AS NavigateUrl,
	 (
		SELECT ID FROM PT_Menu WHERE ID=(CASE LEN(a.MenuID) WHEN 5 THEN NULL ELSE LEFT(a.MenuID,LEN(a.MenuID)-5) END)
	 ) AS ParentMenuID
INTO #Temp
FROM PT_Authority a,PT_Menu m
WHERE a.MenuID*=m.ID
	AND a.UserID=@UserID
	--AND a.MenuID NOT IN ('00002')
ORDER BY a.MenuID

IF EXISTS(SELECT * FROM PT_Department WHERE Creatept=1 AND AutoID=(SELECT DepartmentAutoID FROM PT_Users WHERE UserID=@UserID))
	BEGIN
		UPDATE #Temp SET CanSee=1 WHERE MenuID='00002'
	END
IF EXISTS(SELECT DepartmentAutoID FROM PT_Users WHERE UserID=@UserID AND Administrator=1)
	BEGIN
		UPDATE #Temp SET CanSee=1 WHERE MenuID='00002'
	END

SELECT * FROM #Temp
GO
