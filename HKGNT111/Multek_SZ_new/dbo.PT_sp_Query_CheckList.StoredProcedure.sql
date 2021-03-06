USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[PT_sp_Query_CheckList]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[PT_sp_Query_CheckList]
	@Name VARCHAR(200)=NULL,
	@UserID VARCHAR(50)=NULL
AS

SET NOCOUNT ON

SET @Name='%'+ISNULL(@Name,'')+'%'

SELECT c.AutoID,c.Name
FROM PT_Department_CheckList a,PT_Users b,PT_CheckList c
WHERE a.DepartmentAutoID=b.DepartmentAutoID
	AND a.CheckListAutoID=c.AutoID
	AND c.Name LIKE @Name
	AND	b.UserID=@UserID
GO
