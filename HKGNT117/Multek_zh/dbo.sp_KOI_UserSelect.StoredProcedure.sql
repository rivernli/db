USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_KOI_UserSelect]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_KOI_UserSelect] 
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
	FROM KOI_User 
	WHERE uid=@uid AND [domain]=@domain
END



GO
