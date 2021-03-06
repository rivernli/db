USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MaterialInventory_AuthorityByPage]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_MaterialInventory_AuthorityByPage] 
	@uid nvarchar(50)
	,@domain nvarchar(50)
	,@Url VARCHAR(50)
AS
BEGIN
	DECLARE @UserID VARCHAR(50)
	SET @UserID= @domain +'\'+ @uid
	SELECT 
		[CanSee]
	FROM [MaterialInventory_Authority] AS A LEFT JOIN [MaterialInventory_Menu]AS B
	ON  A.[MenuID] =B.[ID]
	WHERE [UserID]=@UserID
		AND B.[Page]=@Url
END

GO
