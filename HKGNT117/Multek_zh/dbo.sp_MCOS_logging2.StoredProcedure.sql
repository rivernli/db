USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MCOS_logging2]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[sp_MCOS_logging2] 
	@uid nvarchar(50),
	@action nvarchar(50),
	@description nvarchar(500),
	@url nvarchar(250),
	@sessId nvarchar(100)
AS
BEGIN
	SET NOCOUNT ON;
	insert into MCOS_log (uid,actionTime,action,description,url,session_id)
	values (@uid,getdate(),@action,@description,@url,@sessId)
END








GO
