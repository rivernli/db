USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[KOI_sp_getUser]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 

create PROCEDURE [dbo].[KOI_sp_getUser] 
	@uid nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	if(dbo.fx_trim(@uid)='')
		select * from KOI_Users order by BDM
	else
		select * from KOI_Users where Account=@uid
END


GO
