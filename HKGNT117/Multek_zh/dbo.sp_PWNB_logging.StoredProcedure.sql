USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_PWNB_logging]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[sp_PWNB_logging] 
	@uid nvarchar(50),
	@action nvarchar(50),
	@description nvarchar(500),
	@url nvarchar(250)
AS
BEGIN
	SET NOCOUNT ON;
	insert into PWNB_log (uid,actionTime,action,description,url)
	values (@uid,getdate(),@action,@description,@url)
END







GO
