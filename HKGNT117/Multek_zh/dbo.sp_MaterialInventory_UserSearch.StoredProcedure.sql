USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MaterialInventory_UserSearch]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



create  PROCEDURE [dbo].[sp_MaterialInventory_UserSearch] 
	@Value	VARCHAR(50)
AS
BEGIN
	SELECT
		[id]
		,[name]
		,[domain]
		,[uid]
		,[title]
		,[phone]
		,[email]
		,[department]
	FROM [MaterialInventory_User]
	WHERE [name] = @Value
		OR [uid] = @Value
	ORDER By Name

END



GO
