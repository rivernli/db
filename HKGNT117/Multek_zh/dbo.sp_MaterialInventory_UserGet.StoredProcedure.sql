USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MaterialInventory_UserGet]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create PROCEDURE [dbo].[sp_MaterialInventory_UserGet] 
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
	ORDER By Name

END



GO
