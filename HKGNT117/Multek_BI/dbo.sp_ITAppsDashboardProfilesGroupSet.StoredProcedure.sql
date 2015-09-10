USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_ITAppsDashboardProfilesGroupSet]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[sp_ITAppsDashboardProfilesGroupSet] @DBPId int
as
select * from dbo.ITAppsDashboardProfiles where dbpid=@DBPId or parentId=@DBPId
or parentID in (select dbpid from dbo.ITAppsDashboardProfiles where parentId=@DBPId)
order by parentId
GO
