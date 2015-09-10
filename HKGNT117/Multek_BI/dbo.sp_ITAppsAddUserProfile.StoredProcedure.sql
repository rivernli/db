USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_ITAppsAddUserProfile]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





create procedure [dbo].[sp_ITAppsAddUserProfile] 
@uid char(8),@domain varchar(12),@userName nvarchar(50), @dashboardId int
as
set nocount on;
	insert into ITAppsUserProfile(uid,domain,userName,defaultDashboardProfileId)
	values (@uid,@domain,@userName,@dashboardId)

set nocount off;
GO
