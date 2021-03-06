USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[ItemPriceMasterQuery_sp_UserDelete]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



 
CREATE PROCEDURE [dbo].[ItemPriceMasterQuery_sp_UserDelete] 
	@id	VARCHAR(50)
AS
BEGIN
	DECLARE @count INT--影响行数
	
	DELETE ItemPriceMasterQuery_Authority
	WHERE Userid IN (select domain+'\'+uid from ItemPriceMasterQuery_user WHERE [id] IN ( SELECT  CONVERT(INT,col)   FROM   dbo.f_split(@id,',')));

	DELETE ItemPriceMasterQuery_user
	WHERE [id] IN ( SELECT  CONVERT(INT,col)   FROM   dbo.f_split(@id,','))  -- 分割字符串 
	
	SET @count= @@rowcount
	
	SELECT @count
END






GO
