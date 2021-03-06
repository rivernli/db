USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[PT_sp_Update_Department_CheckList]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PT_sp_Update_Department_CheckList]
	@DepartmentSite VARCHAR(500),
	@CheckListAutoID INT,
	@Enable BIT
AS

SET NOCOUNT ON

UPDATE PT_Department_CheckList
SET Enable=@Enable
WHERE CheckListAutoID=@CheckListAutoID
	AND DepartmentAutoID=(
							SELECT a.AutoID
							FROM PT_Department a,PT_Location b
							WHERE a.LocationAutoID=b.AutoID
								AND a.Name+' ('+b.Name+')'=@DepartmentSite
						 )
GO
