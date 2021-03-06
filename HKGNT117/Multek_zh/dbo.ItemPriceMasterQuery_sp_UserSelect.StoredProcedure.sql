USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[ItemPriceMasterQuery_sp_UserSelect]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
create PROCEDURE [dbo].[ItemPriceMasterQuery_sp_UserSelect] 
	@uid nvarchar(50)
	,@domain nvarchar(50)
AS
BEGIN
	SELECT 
		[id]
		,[uid]
		,[name]
		,[domain]
		,[phone]
		,[email]
		,[department]
		,[title]
		,[createdBy]
		,[creationDate]
		,[lastLoginTime] 
	FROM ItemPriceMasterQuery_User 
	WHERE uid=@uid AND [domain]=@domain
END




GO
