USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[ItemPriceMasterQuery_sp_UserUpdate]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 

create PROCEDURE [dbo].[ItemPriceMasterQuery_sp_UserUpdate] 
	@uid nvarchar(50),
	@name nvarchar(50),
	@domain nvarchar(50),
	@phone nvarchar(50),
	@email nvarchar(50),
	@department nvarchar(100),
	@title nvarchar(50)                                                           
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE ItemPriceMasterQuery_User
	SET [name]=@name,
	[phone]=@phone,
	[email]=@email,
	[department]=@department,
	[title]=@title
	WHERE [uid]=@uid
	AND domain=@domain
	
	select @@rowcount
END









GO
