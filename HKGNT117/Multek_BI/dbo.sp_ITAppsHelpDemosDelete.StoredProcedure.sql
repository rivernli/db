USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_ITAppsHelpDemosDelete]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[sp_ITAppsHelpDemosDelete] @DemoId int,@output nvarchar(50) output
as
SET NOCOUNT ON 

if not exists (select 1 from ITAppsHelpDemos where ParentId =@DemoId)
begin
	delete ITAppsHelpDemos where DemoId =@DemoId
    if @@ROWCOUNT  > 0
		set @output= 'Record deleted';
	else
		set @output = 'No record found for delete'
end
else
	set @output= 'Cannot be deleted. Child items are existed'
SET NOCOUNT OFF




GO
