USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_GAM_UsersGetGroup]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[sp_GAM_UsersGetGroup] 
	@group nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	if(dbo.fx_trim(@group)='')
		select * from gam_Users order by uGroup, userName
	else
		select * from gam_users where uGroup=@group
END

set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON



GO
