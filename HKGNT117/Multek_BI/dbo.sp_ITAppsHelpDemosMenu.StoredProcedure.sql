USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_ITAppsHelpDemosMenu]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



create procedure [dbo].[sp_ITAppsHelpDemosMenu]
as
select DemoId,Title,parentId,isItem from dbo.ITAppsHelpDemos where isItem=0 order by sortDesc 


GO
