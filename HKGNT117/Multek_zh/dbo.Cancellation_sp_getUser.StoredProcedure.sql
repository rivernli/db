USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Cancellation_sp_getUser]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Cancellation_sp_getUser] 
	@uid nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	
	set @uid = ISNULL(@uid,'')
	
	if(dbo.fx_trim(@uid)='')
		select * from dbo.Cancellation_Users order by BDM
	else
		select * from dbo.Cancellation_Users where Account=@uid
END






GO
