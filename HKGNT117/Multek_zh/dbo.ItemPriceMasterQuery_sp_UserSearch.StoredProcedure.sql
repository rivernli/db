USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[ItemPriceMasterQuery_sp_UserSearch]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
create PROCEDURE [dbo].[ItemPriceMasterQuery_sp_UserSearch] 
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
	FROM [ItemPriceMasterQuery_User]
	WHERE [name] = @Value
		OR [uid] = @Value
	ORDER By Name

END




GO
