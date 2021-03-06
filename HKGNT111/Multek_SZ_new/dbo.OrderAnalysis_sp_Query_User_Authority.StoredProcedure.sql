USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[OrderAnalysis_sp_Query_User_Authority]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[OrderAnalysis_sp_Query_User_Authority]
	@UserID			VARCHAR(100)=NULL
AS
/*----------------------------------------------------------------------------------------------
功能:	动态显示目录层次关系,以便前台用TREEVIEW显示目录架构.
作者:	张建光
时间:	2007-05-15
----------------------------------------------------------------------------------------------*/
SET NOCOUNT ON

SELECT b.ID AS MenuCode,b.Description AS MenuName,
	 (
		SELECT TOP 1 c.ID FROM OrderAnalysis_Menu c WHERE LEN(c.ID)=LEN(b.ID)-5 AND LEFT(b.ID,LEN(c.ID))=c.ID ORDER BY c.ID ASC
	 ) AS ParentMenuCode,
	 b.Page  AS NavigateUrl,
	 a.CanSee,a.CanAdd,a.CanModify,a.CanDelete
FROM OrderAnalysis_Authority a,OrderAnalysis_Menu b
WHERE a.UserID=@UserID
	AND a.MenuID=b.ID
ORDER BY b.ID
GO
