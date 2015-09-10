USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_NI_getLog]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_NI_getLog] 
	@type tinyint ,
	@key nvarchar(50)
AS
BEGIN
	/*	0 nothing get all result, 
		1 search by user, 
		2 search by action 
	*/
	if(@type = 1)
		select top 1000 * from nonInventory_log where uid = @key order by log_id desc
	if(@type=2)
		select top 1000 * from nonInventory_log where [action] = @key order by log_id desc
	if(@type=0)
		select top 1000 * from nonInventory_log order by log_id desc
END






GO
