USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_HubInv_stockOverSit_detail]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE procedure [dbo].[sp_HubInv_stockOverSit_detail]
@idate int,@startday int,@endday int,
@oem nvarchar(50) ='',@plant nvarchar(10) = ''
as 
/*set @idate = 20110606
set @startday = -7
set @endday = -1
*/
/*
if(@oem = '' or @oem is null)
	select OEM,plant,partnumber,round(sum(amount),0) as tamt from 
	(
		select a.OEM,a.plant,partNumber,amount,qty,datediff(d,outDate,inDate) -isnull(billingpolicy,0) -isnull(transit,0) as overdueDays,idate
		from dbo.vw_4RP_HubInv as a left join dbo.hubInventoryOEMPolicy as b on  a.warehouseId=b.warehouseId where idate = @idate
	)
	 as ov where overdueDays between @startday and @endday group by oem,plant,partnumber
else
	select OEM,plant,partnumber,round(sum(amount),0) as tamt from 
	(
		select a.OEM,a.plant,partNumber,amount,qty,datediff(d,outDate,inDate) -isnull(billingpolicy,0) -isnull(transit,0) as overdueDays,idate
		from dbo.vw_4RP_HubInv as a left join dbo.hubInventoryOEMPolicy as b on a.warehouseId=b.warehouseId where idate = @idate
	)
	 as ov where overdueDays between @startday and @endday and oem=@oem and plant=@plant group by oem,plant,partnumber

*/
select OEM,plant,partnumber,round(sum(amount),0) as tamt into #tmp from 
(
	select a.OEM,a.plant,partNumber,amount,qty,datediff(d,outDate,inDate) -isnull(billingpolicy,0) -isnull(transit,0) as overdueDays,idate
	from dbo.vw_4RP_HubInv as a left join dbo.hubInventoryOEMPolicy as b on  a.warehouseId=b.warehouseId where idate = @idate
)
as ov where overdueDays between @startday and @endday group by oem,plant,partnumber

if(@oem ='' and @plant = '')
	select * from #tmp
else
begin
	if(@oem = '')
		select * from #tmp where plant = @plant
	else
		select * from #tmp where plant = @plant and oem=@oem
end
drop table #tmp
GO
