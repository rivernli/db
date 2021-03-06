USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[ReportingPortal_sp_Query_User_Authority]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*============================================ ReportingPortal_sp_Query_User_Authority ===================================================================*/

CREATE PROCEDURE [dbo].[ReportingPortal_sp_Query_User_Authority]
	@UserID VARCHAR(50)
AS

SET NOCOUNT ON

--Get user's menus
SELECT a.MenuID ,
	dbo.ReportingPortal_fun_GetParentMenuName (a.MenuID) AS MenuName,
	m.Description AS ChildMenuName, 
	a.CanSee,
	 m.Page AS NavigateUrl,
	 (
		SELECT ID FROM ReportingPortal_Menu WHERE ID=(CASE LEN(a.MenuID) WHEN 5 THEN NULL ELSE LEFT(a.MenuID,LEN(a.MenuID)-5) END)
	 ) AS ParentMenuID
INTO #Temp
FROM ReportingPortal_Authority a left join ReportingPortal_Menu m
on a.MenuID = m.ID
WHERE a.UserID = @UserID
ORDER BY a.MenuID

IF CHARINDEX(@UserID,'asia\lgzjzhan;asia\hkg10369;asia\MCN00318;asia\admin_hkg10369')=0
	BEGIN
		IF EXISTS(SELECT * FROM #Temp WHERE MenuID='0000200001' AND CanSee=1)
			BEGIN
				DELETE #Temp WHERE MenuID IN ('0000200002','0000200003')
			END
		IF EXISTS(SELECT * FROM #Temp WHERE MenuID='0000200002' AND CanSee=1)
			BEGIN
				DELETE #Temp WHERE MenuID IN ('0000200001','0000200003')
			END
		IF EXISTS(SELECT * FROM #Temp WHERE MenuID='0000200003' AND CanSee=1)
			BEGIN
				DELETE #Temp WHERE MenuID IN ('0000200001','0000200002')
			END
		IF NOT EXISTS(SELECT * FROM #Temp WHERE MenuID='0000200001' AND CanSee=1) AND NOT EXISTS(SELECT * FROM #Temp WHERE MenuID='0000200002' AND CanSee=1) AND NOT EXISTS(SELECT * FROM #Temp WHERE MenuID='0000200003' AND CanSee=1)
			BEGIN
				DELETE #Temp WHERE MenuID IN ('0000200001','0000200002','0000200003')
			END

	END

GO
