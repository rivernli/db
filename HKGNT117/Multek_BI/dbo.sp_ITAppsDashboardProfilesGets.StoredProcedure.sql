USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_ITAppsDashboardProfilesGets]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[sp_ITAppsDashboardProfilesGets]
@DBPId int
as 
set NOCOUNT ON
	select * from  itappsDashboardProfiles 
	where ParentId=@DBPId order by sortDesc asc
set NOCOUNT OFF


GO
