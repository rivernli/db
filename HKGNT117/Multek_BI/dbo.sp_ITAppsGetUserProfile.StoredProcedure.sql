USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_ITAppsGetUserProfile]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE procedure [dbo].[sp_ITAppsGetUserProfile] 
@uid char(8),@domain varchar(12)
as
	SET NOCOUNT ON;
	if(dbo.fx_trim(@uid)='')
		select * from itappsUserProfile order by userName
	else
		select * from itappsUserProfile where uid=@uid and domain=@domain


set nocount off;
GO
