USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MI_UserInsert]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_MI_UserInsert] 
	@uid nvarchar(50),
	@name nvarchar(50),
	@domain nvarchar(50),
	@phone nvarchar(50),
	@email nvarchar(50),
	@department nvarchar(50),
	@title nvarchar(50),
	@createdBy nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @count INT--影响行数
	INSERT INTO MI_User([uid], [name], [domain], [phone], [email], [department], [title], [createdBy], [creationDate]) 
	VALUES(@uid, @name, @domain, @phone, @email, @department, @title, @createdBy, getdate()) 
	
	SET @count= @@rowcount
	--Initial user's menus
	INSERT INTO MI_Authority ([UserID],[MenuID],[CanSee],[CanAdd],[CanModify],[CanDelete])
	SELECT 
		b.[domain] + '\' + b.[uid]
		,a.[ID]
		,0
		,0
		,0
		,0
	FROM MI_Menu AS a,MI_User AS b
	WHERE a.[ID] + b.[domain] + '\' + b.[uid] NOT IN (
						SELECT [MenuID] + [UserID]
						FROM  [MI_Authority]
						   )
	SELECT @count
END




GO
