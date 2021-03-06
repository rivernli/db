USE [Multek_ZH_New]
GO
/****** Object:  StoredProcedure [dbo].[sp_SGP_deleteQuoteById_CanI]    Script Date: 11/06/2014 15:50:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_SGP_deleteQuoteById_CanI](@qid int, @salesId nvarchar(10),@CanI bit output)

as
select @canI=0

set nocount on
if not exists (select 1 from SGP_data where id=@qid)
begin
	return
end

declare @status char(1),@name nvarchar(100)
select @status=status,@name = name from SGP_ACL where uid=@salesId
if(@status ='A')
begin
	select @canI = 1
end	
else
begin
		if exists(select 1 from SGP_data where id=@qid and (salesman = @name or uid=@salesId or puid=@salesId))
		begin
			select @canI=1
		end
end
set nocount off
GO
