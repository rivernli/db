USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_ITAppsHelpDemosAdd]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE procedure [dbo].[sp_ITAppsHelpDemosAdd] 
@ParentId int,@Title nvarchar(200),@Description nvarchar(255),
@isItem bit,@DemoURL nvarchar(255),@AppURL nvarchar(255),
@sortDesc int,@height int, @width int,
@output nvarchar(50) output,@DemoId int output

as 
set NOCOUNT ON
set @DemoId= 0
if(@ParentId=0 and @isItem = 1)
	set @output = 'Item cannot place under root.'
else
begin
	declare @isParentIsItem bit
	set @isParentIsItem = 0

	if(@parentId >0)
		select @isParentIsItem=isItem from ITAppsHelpDemos where DemoId=@parentId

	if(@isParentIsItem = 0)
	begin
		insert into ITAppsHelpDemos 
		(ParentId,Title,Description,isItem,DemoURL,AppURL,sortDesc,height,width) values
		(@ParentId,@Title,@Description,@isItem,@DemoURL,@AppURL,@sortDesc,@height,@width) 
		SELECT @DemoId = @@IDENTITY
		set @output = 'Item added'
	end
	else
		set @output = 'Parent is not a container'
end
set NOCOUNT OFF






GO
