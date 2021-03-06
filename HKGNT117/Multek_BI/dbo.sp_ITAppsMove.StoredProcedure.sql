USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_ITAppsMove]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_ITAppsMove] 
@nodeId int, @newParentId int

as

if(@newParentId=0)
begin
	update ITApps set parentAppId=@newParentId where appId=@nodeId
end
else
begin
declare @tempParentId int
declare @is bit

select @is = isApp from itapps where appId=@newParentId
if(@is=0)
	set @is = 1
else
	set @is = 0

set @tempParentId = @newParentId
while(@is=1 and @tempParentId >0)
begin
	select @tempParentId=parentAppId from itapps where appId = @tempParentId
	if(@tempParentId=@nodeId)
		set @is=0
end

if(@is=1)
begin
	update ITApps set parentAppId=@newParentId where appId=@nodeId
end
end

GO
