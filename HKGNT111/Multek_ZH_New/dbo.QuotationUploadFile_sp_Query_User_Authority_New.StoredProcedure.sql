USE [Multek_ZH_New]
GO
/****** Object:  StoredProcedure [dbo].[QuotationUploadFile_sp_Query_User_Authority_New]    Script Date: 11/06/2014 15:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[QuotationUploadFile_sp_Query_User_Authority_New]
	@UserID			VARCHAR(100)=NULL,
	@ParentMenuID	 	VARCHAR(200)=NULL
AS

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
				FROM QuotationUploadFile_Authority aa
				WHERE aa.UserID=@UserID
					AND aa.CanSee=1
					AND LEN(aa.MenuID)=LEN(@ParentMenuID)+10
					AND aa.MenuID LIKE  f.ID+'%'
			) AS ChildNodeCount,
			 a.CanSee
		FROM QuotationUploadFile_Authority a,QuotationUploadFile_Menu f
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
				FROM QuotationUploadFile_Authority aa
				WHERE aa.UserID=@UserID
					AND aa.CanSee=1
					AND LEN(aa.MenuID)=10
					AND aa.MenuID LIKE f.ID+'%'
			) AS ChildNodeCount,
			 a.CanSee
		FROM QuotationUploadFile_Authority a,QuotationUploadFile_Menu f
		WHERE a.UserID=@UserID
			AND a.MenuID=f.ID
			AND LEN(f.ID)=5
			--AND a.CanSee=1
		ORDER BY f.ID
	END
GO
