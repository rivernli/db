USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[sp_Exr2_UserSearch]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE  PROCEDURE [dbo].[sp_Exr2_UserSearch] 
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
	FROM [Exr2_User]
	WHERE [name] = @Value
		OR [uid] = @Value
	ORDER By Name

END




GO
