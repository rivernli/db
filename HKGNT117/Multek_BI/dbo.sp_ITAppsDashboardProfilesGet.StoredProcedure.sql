USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_ITAppsDashboardProfilesGet]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[sp_ITAppsDashboardProfilesGet]
@DBPId int
as 
set NOCOUNT ON
	select * from  itappsDashboardProfiles 
	where DBPId=@DBPId
set NOCOUNT OFF

GO
