USE [Multek_ZH_New]
GO
/****** Object:  StoredProcedure [dbo].[sp_SGP_getUser]    Script Date: 11/06/2014 15:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_SGP_getUser] 
	@uid nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	if(dbo.fx_trim(@uid)='')
		select * from sgp_acl order by name
	else
		select * from sgp_acl where uid = @uid  or name like '%'+ @uid +'%'
END
GO
