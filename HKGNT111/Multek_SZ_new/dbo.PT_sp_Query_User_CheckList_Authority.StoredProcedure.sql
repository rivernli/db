USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[PT_sp_Query_User_CheckList_Authority]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[PT_sp_Query_User_CheckList_Authority]
	-- Add the parameters for the stored procedure here
	@UserID VARCHAR(50)=NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF EXISTS(SELECT * FROM PT_Users WHERE UserID=@UserID AND (Administrator=1 OR SiteOwner=1))
		BEGIN
			SELECT  1 AS CheckList1,
					1 AS CheckList2,
					1 AS CheckList3,
					1 AS CheckList4,
					1 AS CheckList5,
					1 AS CheckList6,
					1 AS CheckList7,
					1 AS CheckList8,
					1 AS CheckList9,
					1 AS CheckList10,
					1 AS CheckList11,
					1 AS CheckList12,
					1 AS CheckList13,
					1 AS CheckList14,
					1 AS CheckList15,
					1 AS CheckList16,
					1 AS CheckList17,
					1 AS CheckList18,
					1 AS CheckList19,
					1 AS CheckList20,
					1 AS CheckList21,
					1 AS CheckList22,
					1 AS Administrator,
					1 AS SiteOwner
		END
	ELSE
		BEGIN
			SELECT  (
						SELECT COUNT(*)
						FROM PT_Department_CheckList a,PT_Users b
						WHERE a.DepartmentAutoID=b.DepartmentAutoID
							AND a.CheckListAutoID=1
							AND b.UserID=@UserID
							AND a.Enable=1
					) AS CheckList1,
					(
						SELECT COUNT(*)
						FROM PT_Department_CheckList a,PT_Users b
						WHERE a.DepartmentAutoID=b.DepartmentAutoID
							AND a.CheckListAutoID=2
							AND b.UserID=@UserID
							AND a.Enable=1
					) AS CheckList2,
					(
						SELECT COUNT(*)
						FROM PT_Department_CheckList a,PT_Users b
						WHERE a.DepartmentAutoID=b.DepartmentAutoID
							AND a.CheckListAutoID=3
							AND b.UserID=@UserID
							AND a.Enable=1
					) AS CheckList3,
					(
						SELECT COUNT(*)
						FROM PT_Department_CheckList a,PT_Users b
						WHERE a.DepartmentAutoID=b.DepartmentAutoID
							AND a.CheckListAutoID=4
							AND b.UserID=@UserID
							AND a.Enable=1
					) AS CheckList4,
					(
						SELECT COUNT(*)
						FROM PT_Department_CheckList a,PT_Users b
						WHERE a.DepartmentAutoID=b.DepartmentAutoID
							AND a.CheckListAutoID=5
							AND b.UserID=@UserID
							AND a.Enable=1
					) AS CheckList5,
					(
						SELECT COUNT(*)
						FROM PT_Department_CheckList a,PT_Users b
						WHERE a.DepartmentAutoID=b.DepartmentAutoID
							AND a.CheckListAutoID=6
							AND b.UserID=@UserID
							AND a.Enable=1
					) AS CheckList6,
					(
						SELECT COUNT(*)
						FROM PT_Department_CheckList a,PT_Users b
						WHERE a.DepartmentAutoID=b.DepartmentAutoID
							AND a.CheckListAutoID=7
							AND b.UserID=@UserID
							AND a.Enable=1
					) AS CheckList7,
					(
						SELECT COUNT(*)
						FROM PT_Department_CheckList a,PT_Users b
						WHERE a.DepartmentAutoID=b.DepartmentAutoID
							AND a.CheckListAutoID=8
							AND b.UserID=@UserID
							AND a.Enable=1
					) AS CheckList8,
					(
						SELECT COUNT(*)
						FROM PT_Department_CheckList a,PT_Users b
						WHERE a.DepartmentAutoID=b.DepartmentAutoID
							AND a.CheckListAutoID=9
							AND b.UserID=@UserID
							AND a.Enable=1
					) AS CheckList9,
					(
						SELECT COUNT(*)
						FROM PT_Department_CheckList a,PT_Users b
						WHERE a.DepartmentAutoID=b.DepartmentAutoID
							AND a.CheckListAutoID=10
							AND b.UserID=@UserID
							AND a.Enable=1
					) AS CheckList10,
					(
						SELECT COUNT(*)
						FROM PT_Department_CheckList a,PT_Users b
						WHERE a.DepartmentAutoID=b.DepartmentAutoID
							AND a.CheckListAutoID=11
							AND b.UserID=@UserID
							AND a.Enable=1
					) AS CheckList11,
					(
						SELECT COUNT(*)
						FROM PT_Department_CheckList a,PT_Users b
						WHERE a.DepartmentAutoID=b.DepartmentAutoID
							AND a.CheckListAutoID=12
							AND b.UserID=@UserID
							AND a.Enable=1
					) AS CheckList12,
					(
						SELECT COUNT(*)
						FROM PT_Department_CheckList a,PT_Users b
						WHERE a.DepartmentAutoID=b.DepartmentAutoID
							AND a.CheckListAutoID=13
							AND b.UserID=@UserID
							AND a.Enable=1
					) AS CheckList13,
					(
						SELECT COUNT(*)
						FROM PT_Department_CheckList a,PT_Users b
						WHERE a.DepartmentAutoID=b.DepartmentAutoID
							AND a.CheckListAutoID=14
							AND b.UserID=@UserID
							AND a.Enable=1
					) AS CheckList14,
					(
						SELECT COUNT(*)
						FROM PT_Department_CheckList a,PT_Users b
						WHERE a.DepartmentAutoID=b.DepartmentAutoID
							AND a.CheckListAutoID=15
							AND b.UserID=@UserID
							AND a.Enable=1
					) AS CheckList15,
					(
						SELECT COUNT(*)
						FROM PT_Department_CheckList a,PT_Users b
						WHERE a.DepartmentAutoID=b.DepartmentAutoID
							AND a.CheckListAutoID=16
							AND b.UserID=@UserID
							AND a.Enable=1
					) AS CheckList16,
					(
						SELECT COUNT(*)
						FROM PT_Department_CheckList a,PT_Users b
						WHERE a.DepartmentAutoID=b.DepartmentAutoID
							AND a.CheckListAutoID=17
							AND b.UserID=@UserID
							AND a.Enable=1
					) AS CheckList17,
					(
						SELECT COUNT(*)
						FROM PT_Department_CheckList a,PT_Users b
						WHERE a.DepartmentAutoID=b.DepartmentAutoID
							AND a.CheckListAutoID=18
							AND b.UserID=@UserID
							AND a.Enable=1
					) AS CheckList18,
					(
						SELECT COUNT(*)
						FROM PT_Department_CheckList a,PT_Users b
						WHERE a.DepartmentAutoID=b.DepartmentAutoID
							AND a.CheckListAutoID=19
							AND b.UserID=@UserID
							AND a.Enable=1
					) AS CheckList19,
					(
						SELECT COUNT(*)
						FROM PT_Department_CheckList a,PT_Users b
						WHERE a.DepartmentAutoID=b.DepartmentAutoID
							AND a.CheckListAutoID=20
							AND b.UserID=@UserID
							AND a.Enable=1
					) AS CheckList20,
					(
						SELECT COUNT(*)
						FROM PT_Department_CheckList a,PT_Users b
						WHERE a.DepartmentAutoID=b.DepartmentAutoID
							AND a.CheckListAutoID=21
							AND b.UserID=@UserID
							AND a.Enable=1
					) AS CheckList21,
					(
						SELECT COUNT(*)
						FROM PT_Department_CheckList a,PT_Users b
						WHERE a.DepartmentAutoID=b.DepartmentAutoID
							AND a.CheckListAutoID=22
							AND b.UserID=@UserID
							AND a.Enable=1
					) AS CheckList22,
					(
						SELECT COUNT(*) 
						FROM PT_Users 
						WHERE UserID=@UserID
							AND Administrator=1
					) AS Administrator,
					(
						SELECT COUNT(*) 
						FROM PT_Users 
						WHERE UserID=@UserID
							AND SiteOwner=1
					) AS SiteOwner
		END
END
GO
