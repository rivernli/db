USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[sp_PresidentDashboard_logging]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[sp_PresidentDashboard_logging] 
	@uid nvarchar(50),
	@action nvarchar(50),
	@description nvarchar(500),
	@url nvarchar(250),
	@sessId nvarchar(100)
AS
BEGIN
	SET NOCOUNT ON;
	insert into PresidentDashboard_log (uid,actionTime,action,description,url,session_id)
	values (@uid,getdate(),@action,@description,@url,@sessId)
END
GO
