USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[sp_Exr2_MenuSearch]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<sun zhang>
-- Create date: <3/16/2011>
-- Description:	<搜索菜单>
-- =============================================
CREATE PROCEDURE  [dbo].[sp_Exr2_MenuSearch]
	@uid nvarchar(50)
	,@domain nvarchar(50)
	,@ChildMenuName  VARCHAR(500)=NULL
AS
BEGIN
	DECLARE @UserID VARCHAR(50)
	SET @UserID= @domain +'\'+ @uid
	IF EXISTS(SELECT * FROM SYSOBJECTS WHERE ID = OBJECT_ID(N'tempdb.#Temp') and type = 'U')
	drop table [#Temp]

	SELECT a.[MenuID] ,
		[dbo].[Exr2_fun_GetParentMenuName] (a.MenuID) AS MenuName,
		m.[Description] AS [ChildMenuName], 
		a.[CanSee],
		 m.[Page] AS [NavigateUrl],
		 (
			SELECT ID FROM [Exr2_Menu] WHERE ID=(CASE LEN(a.MenuID) WHEN 5 THEN NULL ELSE LEFT(a.MenuID,LEN(a.MenuID)-5) END)
		 ) AS ParentMenuID
	INTO #Temp
	FROM [Exr2_Authority] a left join [Exr2_Menu] m
	on a.MenuID = m.ID
	WHERE a.UserID=@UserID 
	ORDER BY a.MenuID

	If @ChildMenuName is NULL
	BEGIN
		SELECT * FROM #Temp WHERE CanSee=1 And  NavigateUrl is not Null ORDER BY MenuID
	END
	ELSE
	BEGIN
		SELECT * FROM #Temp WHERE CanSee=1 And  NavigateUrl is not Null And ChildMenuName Like '%'+@ChildMenuName+'%' ORDER BY MenuID
	   
	END
END



GO
