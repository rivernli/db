USE [Multek_ZH_New]
GO
/****** Object:  StoredProcedure [dbo].[sp_SGP_deleteQuoteById]    Script Date: 11/06/2014 15:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_SGP_deleteQuoteById](@qid int, @salesId nvarchar(10),@message nvarchar(100) output)

as
select @message = ''

set nocount on
if not exists (select 1 from sgp_data where id=@qid)
begin
	select @message = 'quoate not found!'
	return
end

declare @status char(1),@name nvarchar(100)
select @status=status,@name = name from dbo.SGP_ACL where uid=@salesId
if(@status ='A')
begin
	execute [sp_SGP_UpdateHistory] 'D',@salesId,@qid
	delete dbo.sgp_data where id=@qid
	select @message = 'RFQ deleted!'
end	
else
begin
		if exists(select 1 from sgp_data where id=@qid and (salesman = @name or uid=@salesId or puid=@salesId))
		begin
			execute [sp_SGP_UpdateHistory] 'D',@salesId,@qid
			delete dbo.sgp_data where id=@qid
			select @message = 'RFQ deleted!'
		end
		else
			select @message = 'you cannot delete this quoate'
end
set nocount off
GO
