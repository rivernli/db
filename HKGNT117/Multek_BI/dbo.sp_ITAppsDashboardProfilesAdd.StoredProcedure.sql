USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_ITAppsDashboardProfilesAdd]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE procedure [dbo].[sp_ITAppsDashboardProfilesAdd] 
@ParentId int,@Title nvarchar(200),@Description nvarchar(255),
@isItem bit,@isItemXML bit,@isItemURL nvarchar(255),@isItemTargetURL nvarchar(255),
@sortDesc int,@output nvarchar(50) output,@DBPId int output

as 
set NOCOUNT ON
set @DBPId= 0
if(@ParentId=0 and @isItem = 1)
	set @output = 'Item cannot place under root.'
else
begin
	declare @isParentIsItem bit
	set @isParentIsItem = 0

	if(@parentId >0)
		select @isParentIsItem=isItem from itappsDashboardProfiles where DBPId=@parentId

	if(@isParentIsItem = 0)
	begin
		insert into itappsDashboardProfiles 
		(ParentId,Title,Description,isItem,isItemXML,isItemURL,isItemTargetURL,sortDesc) values
		(@ParentId,@Title,@Description,@isItem,@isItemXML,@isItemURL,@isItemTargetURL,@sortDesc) 
		SELECT @DBPId = @@IDENTITY
		set @output = 'Item added'
	end
	else
		set @output = 'Parent is not a container'
end
set NOCOUNT OFF




GO
