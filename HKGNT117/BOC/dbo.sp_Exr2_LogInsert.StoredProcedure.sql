USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[sp_Exr2_LogInsert]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_Exr2_LogInsert] 
	@domain nvarchar(50),
	@uid nvarchar(50) ,
	@action nvarchar(50),
	@description nvarchar(500),
	@url nvarchar(250),
	@sessId nvarchar(100),
	@log_id int output
AS
BEGIN
	SET NOCOUNT ON;
	insert into [Exr2_Log] ([domain],[uid],actionTime,action,description,url,session_id)
	values (@domain,@uid,getdate(),@action,@description,@url,@sessId)
	SET @log_id= IDENT_CURRENT('Exr2_Log')  ---返回自动编号的id 
END



GO
