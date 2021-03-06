USE [Multek_ZH_New]
GO
/****** Object:  StoredProcedure [dbo].[sp_SGP_deleteQuote]    Script Date: 11/06/2014 15:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_SGP_deleteQuote] @rfq nvarchar(30)
as
set nocount on
declare @id int,@message nvarchar(100),@count int
select @count=count(rfq) from dbo.sgp_data where rfq = @rfq
if @count=1
begin
	select @id=id from dbo.sgp_data where rfq = @rfq
	execute [sp_SGP_UpdateHistory] 'D','0',@id
	delete dbo.sgp_data where rfq = @rfq
	select @message = 'RFQ:'+ @rfq +' was deleted!'
end
else
begin
	if(@count=0)
		select @message = 'RFQ:'+ @rfq +' not found!'
	else
		select @message = 'Cannot delete. More than 1 RFQ:'+ @rfq +' found!'
end

select @message as msg

set nocount off
GO
