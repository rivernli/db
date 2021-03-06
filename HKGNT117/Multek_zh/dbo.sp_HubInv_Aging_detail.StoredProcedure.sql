USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_HubInv_Aging_detail]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE  procedure [dbo].[sp_HubInv_Aging_detail] 
@iDate int,
@oem nvarchar(50),
@plant nvarchar(10),
@oversitStart int,
@oversitEnd int
as
IF OBJECT_ID('tempdb..#tempOverSit') IS NOT NULL
	drop table #tempOverSit

CREATE TABLE #tempOverSit
(
	oem nvarchar(100),
	plant nvarchar(20),
	partNumber nvarchar(100),
	tamt float
)
/*
if(@oversitStart > 12)
begin
	insert into #tempOverSit
	select oem,plant,partNumber,round(sum(amount),0) as tamt
	from dbo.vw_4RP_HubInv 
	where iDate = @iDate
	and datediff(d,outDate,inDate)/7 > 12
	group by oem,plant,partnumber
end
else
begin
	insert into #tempOverSit
	select oem,plant,partNumber,round(sum(amount),0) as tamt
	from dbo.vw_4RP_HubInv 
	where iDate = @iDate
	and datediff(d,outDate,inDate)/7 between @oversitStart and @oversitEnd
	group by oem,plant,partnumber
end

if(@oem != '')
	select * from #tempOverSit where oem = @oem and plant = @plant
else
	select * from #tempOverSit
*/
declare @ds bit
set @ds = 1

if(@oversitStart > 84)
begin
	set @ds=0
	insert into #tempOverSit
	select o.oem,o.plant,partnumber,round(sum(amount),0) as tamt
	from vw_4RP_HubInv as o left join dbo.hubInventoryOEMPolicy as p
	on o.warehouseId=p.warehouseId
	where iDate = @idate
	and (datediff(d,outDate,inDate)-transit) > 84
	group by o.oem,o.plant,partnumber
end

if(@oversitStart < 0)
begin
	set @ds=0
	insert into #tempOverSit
	select o.oem,o.plant,partnumber,round(sum(amount),0) as tamt
	from vw_4RP_HubInv as o left join dbo.hubInventoryOEMPolicy as p
	on o.warehouseId=p.warehouseId
	where iDate = @idate
	and (datediff(d,outDate,inDate)) >=0 and datediff(d,outDate,inDate) <= transit
	group by o.oem,o.plant,partnumber
end
if(@ds=1)
begin
	insert into #tempOverSit
	select o.oem,o.plant,partnumber,round(sum(amount),0) as tamt
	from vw_4RP_HubInv as o left join dbo.hubInventoryOEMPolicy as p
	on o.warehouseId=p.warehouseId
	where iDate = @idate
	and (datediff(d,outDate,inDate)-transit) between @oversitStart and @oversitEnd
	group by o.oem,o.plant,partnumber
end

if(@oem='' and @plant ='')
	select * from #tempOverSit
else
begin
	if(@oem = '')
		select * from #tempOverSit where plant = @plant
	else
		select * from #tempOverSit where oem = @oem and plant = @plant
end 
/*
if(@oem != '')
	select * from #tempOverSit where oem = @oem and plant = @plant
else
	select * from #tempOverSit
*/
drop table #tempOverSit







GO
