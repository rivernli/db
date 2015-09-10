USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_ITAppsHelpDemosGroupSet]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[sp_ITAppsHelpDemosGroupSet] @DemoId int
as
select * from dbo.ITAppsHelpDemos where DemoId=@DemoId or parentId=@DemoId
or parentID in (select DemoId from dbo.ITAppsHelpDemos where parentId=@DemoId)
order by parentId

GO
