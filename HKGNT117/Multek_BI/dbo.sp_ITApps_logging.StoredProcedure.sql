USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_ITApps_logging]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[sp_ITApps_logging] 
	@uid nvarchar(50),
	@action nvarchar(50),
	@description nvarchar(500),
	@url nvarchar(250),
	@sessId nvarchar(100)
AS
BEGIN
	SET NOCOUNT ON;
	insert into ITApps_log (uid,actionTime,action,description,url,session_id)
	values (@uid,getdate(),@action,@description,@url,@sessId)
END










GO
