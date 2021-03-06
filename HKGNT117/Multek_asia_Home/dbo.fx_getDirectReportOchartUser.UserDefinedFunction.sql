USE [Multek_AsiaHome]
GO
/****** Object:  UserDefinedFunction [dbo].[fx_getDirectReportOchartUser]    Script Date: 2014/11/12 17:07:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create FUNCTION [dbo].[fx_getDirectReportOchartUser](
    @mid int,@levels int
) RETURNS @List TABLE (UniqueId int)

BEGIN

insert into @List select UniqueId from ochart where uniqueid = @mid or managerId=@mid
while(@@rowcount >0 and @levels > 0)
begin
	set @levels = @levels-1
	insert into @List
	select a.UniqueId from ochart as a join @List as b on a.managerId=b.uniqueid 
	where a.uniqueid not in (select uniqueid from @List)
end

return
end

GO
