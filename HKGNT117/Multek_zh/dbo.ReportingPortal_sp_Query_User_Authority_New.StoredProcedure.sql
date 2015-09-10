USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[ReportingPortal_sp_Query_User_Authority_New]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*============================================ ReportingPortal_sp_Query_User_Authority_New ===================================================================*/

CREATE PROCEDURE [dbo].[ReportingPortal_sp_Query_User_Authority_New]
	@UserID			VARCHAR(100)=NULL,
	@ParentMenuID	 	VARCHAR(200)=NULL
AS
/*----------------------------------------------------------------------------------------------
功能:	动态显示目录层次关系,以便前台用TREEVIEW显示目录架构.
作者:	张建光
时间:	2007-05-15
----------------------------------------------------------------------------------------------*/
SET NOCOUNT ON

IF @ParentMenuID IS NOT NULL AND @ParentMenuID <>''
	BEGIN
		SELECT f.ID AS NodeCode,
			 f.Description AS NodeName,
			 (
				@ParentMenuID
			 ) AS ParentNodeCode,
			 (
				SELECT COUNT (*)
				FROM ReportingPortal_Authority aa
				WHERE aa.UserID=@UserID
					AND aa.CanSee=1
					AND LEN(aa.MenuID)=LEN(@ParentMenuID)+10
					AND aa.MenuID LIKE  f.ID+'%'
			) AS ChildNodeCount,
			 a.CanSee
		FROM ReportingPortal_Authority a,ReportingPortal_Menu f
		WHERE a.UserID=@UserID
			AND a.MenuID=f.ID
			AND f.ID LIKE @ParentMenuID+'%'
			AND LEN(f.ID)=LEN(@ParentMenuID)+5
			--AND a.CanSee=1
		ORDER BY f.ID
	END
ELSE
	BEGIN
		SELECT f.ID AS NodeCode,
			 f.Description AS NodeName,
			 NULL AS ParentNodeCode,
			 (
				SELECT COUNT (*)
				FROM ReportingPortal_Authority aa
				WHERE aa.UserID=@UserID
					AND aa.CanSee=1
					AND LEN(aa.MenuID)=10
					AND aa.MenuID LIKE f.ID+'%'
			) AS ChildNodeCount,
			 a.CanSee
		FROM ReportingPortal_Authority a,ReportingPortal_Menu f
		WHERE a.UserID=@UserID
			AND a.MenuID=f.ID
			AND LEN(f.ID)=5
			--AND a.CanSee=1
		ORDER BY f.ID
	END

GO
