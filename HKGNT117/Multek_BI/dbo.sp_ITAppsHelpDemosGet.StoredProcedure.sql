USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_ITAppsHelpDemosGet]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[sp_ITAppsHelpDemosGet]
@demoId int
as 
set NOCOUNT ON
	select * from  ITAppsHelpDemos 
	where demoId=@demoId
set NOCOUNT OFF


GO
