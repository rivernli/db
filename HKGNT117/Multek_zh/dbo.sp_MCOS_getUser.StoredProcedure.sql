USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MCOS_getUser]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_MCOS_getUser] 
	@uid nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	if(dbo.fx_trim(@uid)='')
		select * from MCOS_nUser order by userName
	else
		select * from MCOS_nUser where uid=@uid
END




GO
