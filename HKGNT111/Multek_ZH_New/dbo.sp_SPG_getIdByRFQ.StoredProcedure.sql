USE [Multek_ZH_New]
GO
/****** Object:  StoredProcedure [dbo].[sp_SPG_getIdByRFQ]    Script Date: 11/06/2014 15:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_SPG_getIdByRFQ] @rfq nvarchar(50),@pn nvarchar(100), @id int output, @pass bit output
as
set nocount on
declare @num int

select @pass=0
select @num = count(rfq),@id =max(id) from sgp_data where rfq = @rfq group by rfq
if(@num > 1)
	select @num = count(rfq),@id =max(id) from sgp_data where rfq = @rfq and pn =@pn group by rfq

if(@num =1)
	select @pass=1
set nocount off
GO
