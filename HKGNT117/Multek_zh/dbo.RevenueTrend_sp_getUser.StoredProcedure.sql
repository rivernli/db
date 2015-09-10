USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[RevenueTrend_sp_getUser]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



create PROCEDURE [dbo].[RevenueTrend_sp_getUser] 
	@uid nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	if(dbo.fx_trim(@uid)='')
		select * from RevenueTrend_Users order by BDM
	else
		select * from RevenueTrend_Users where Account=@uid
END


GO
