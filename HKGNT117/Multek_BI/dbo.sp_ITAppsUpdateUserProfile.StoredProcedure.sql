USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_ITAppsUpdateUserProfile]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





create procedure [dbo].[sp_ITAppsUpdateUserProfile] 
@uid char(8),@domain varchar(12), @dashboardId int
as
set nocount on;
	update ITAppsUserProfile set defaultDashboardProfileId = @dashboardId
	where uid=@uid and domain=@domain

set nocount off;
GO
