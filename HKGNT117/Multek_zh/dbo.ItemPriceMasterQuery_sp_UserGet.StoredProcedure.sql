USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[ItemPriceMasterQuery_sp_UserGet]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
create PROCEDURE [dbo].[ItemPriceMasterQuery_sp_UserGet] 
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
	ORDER By Name

END




GO
