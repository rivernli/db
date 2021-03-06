USE [Multek_AsiaHome]
GO
/****** Object:  UserDefinedFunction [dbo].[fx_getDirectReportOchartUserByUid]    Script Date: 2014/11/12 17:07:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create FUNCTION [dbo].[fx_getDirectReportOchartUserByUid](
    @uid nvarchar(10),@levels int
) RETURNS @List TABLE (UniqueId int)

BEGIN

insert into @List select UniqueId from ochart where userId=@uid
while(@@rowcount >0 and @levels > 1)
begin
	set @levels = @levels-1
	insert into @List
	select a.UniqueId from ochart as a join @List as b on a.managerId=b.uniqueid 
	where a.uniqueid not in (select uniqueid from @List)
end

return
end

GO
