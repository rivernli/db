USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_ITAppsDashboardProfilesUpdate]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_ITAppsDashboardProfilesUpdate]
@DBPId int,@Title nvarchar(200),@Description nvarchar(255),
@isItemXML bit,@isItemURL nvarchar(255),@isItemTargetURL nvarchar(255),@sortDesc int
as 
set NOCOUNT ON
	update itappsDashboardProfiles 
	set title=@title, description=@description,isItemXML=@isItemXML,isItemURL=@isItemURL,sortDesc=@sortDesc,isItemTargetURL=@isItemTargetURL
	where DBPId=@DBPId
	

set NOCOUNT OFF

GO
