USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_ITAppsHelpDemosGets]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



create procedure [dbo].[sp_ITAppsHelpDemosGets]
@DemoId int
as 
set NOCOUNT ON
	select * from  ITAppsHelpDemos 
	where ParentId=@DemoId order by sortDesc asc
set NOCOUNT OFF



GO
