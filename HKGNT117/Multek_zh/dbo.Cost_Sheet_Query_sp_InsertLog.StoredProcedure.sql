USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Cost_Sheet_Query_sp_InsertLog]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[Cost_Sheet_Query_sp_InsertLog] 
	@uid nvarchar(50),
	@action nvarchar(50),
	@description nvarchar(500),
	@url nvarchar(250),
	@sessId nvarchar(100)
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO dbo.Cost_Sheet_Query_log (uid,actionTime,action,description,url,session_id)
	VALUES (@uid,getdate(),@action,@description,@url,@sessId)
END










GO
