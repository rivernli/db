USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MI_UserDelete]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE  PROCEDURE [dbo].[sp_MI_UserDelete] 
	@id	VARCHAR(50)
AS
BEGIN
	DECLARE @count INT--影响行数
	
	DELETE [MI_User]
	WHERE [id] IN ( SELECT  CONVERT(INT,col)   FROM   dbo.f_split(@id,','))  -- 分割字符串 
	SET @count= @@rowcount
	
	
	--Initial user's menus
	--DELETE MI_Authority
	--WHERE MenuID NOT IN (
	--				SELECT ID
	--				FROM MI_Menu
	--			 )
	--DELETE MI_Authority
	--WHERE [UserID] NOT IN (
	--				SELECT [domain] + '\' + [uid]
	--				FROM MI_User
	--			 )
	
	SELECT @count
END



GO
