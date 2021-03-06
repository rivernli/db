USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_ITAppsHelpDemosUpdate]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[sp_ITAppsHelpDemosUpdate]
@DemoId int,@Title nvarchar(200),@Description nvarchar(255),
@DemoURL nvarchar(255),@AppURL nvarchar(255),@sortDesc int,
@height int, @width int
as
set NOCOUNT ON
	update ITAppsHelpDemos 
	set title=@title, description=@description,DemoURL=@DemoURL,sortDesc=@sortDesc,AppURL=@AppURL,
	height=@height, width=@width
	where DemoId=@DemoId
	

set NOCOUNT OFF



GO
