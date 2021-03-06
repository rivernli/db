USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[sp_Exr2_UserDelete]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_Exr2_UserDelete] 
	@id	VARCHAR(50)
AS
BEGIN
	DECLARE @count INT--影响行数
	
	DELETE [Exr2_User]
	WHERE [id] IN ( SELECT  CONVERT(INT,col)   FROM   [dbo].[Exr2_fun_split](@id,','))  -- 分割字符串 
	SET @count= @@rowcount
	
	
	--Initial user's menus
	--DELETE MSS_Authority
	--WHERE MenuID NOT IN (
	--				SELECT ID
	--				FROM MSS_Menu
	--			 )
	--DELETE MSS_Authority
	--WHERE [UserID] NOT IN (
	--				SELECT [domain] + '\' + [uid]
	--				FROM MSS_User
	--			 )
	
	SELECT @count
END



GO
