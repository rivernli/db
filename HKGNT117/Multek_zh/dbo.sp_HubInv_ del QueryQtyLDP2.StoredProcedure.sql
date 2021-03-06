USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_HubInv_|del|QueryQtyLDP2]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO










create  procedure [dbo].[sp_HubInv_|del|QueryQtyLDP2]
@timeline tinyint,@start int,@end int,@isOEM bit
as
begin

if(@timeline = 1)
begin
	if(@isOEM=1)
		SELECT isnull(OEM,'') as OEM,vw_CalenderLDFY.fiscalYear as T,isnull(sum(qty),0) as tamt 
		from vw_CalenderLDFY LEFT JOIN vw_4RP_HubInvExt on lastDate=iDate
		where vw_CalenderLDFY.fiscalYear between @start and @end
		group by OEM,vw_CalenderLDFY.fiscalYear order by vw_CalenderLDFY.fiscalYear
	else
		SELECT isnull(plant,'') as Plant,vw_CalenderLDFY.fiscalYear as T,isnull(sum(qty),0) as tamt 
		from vw_CalenderLDFY LEFT JOIN vw_4RP_HubInvExt on lastDate=iDate
		where vw_CalenderLDFY.fiscalYear between @start and @end
		group by plant,vw_CalenderLDFY.fiscalYear order by vw_CalenderLDFY.fiscalYear
end
if(@timeline=2)
begin
	if(@isOEM=1)
		SELECT isnull(OEM,'') as OEM,vw_CalenderLDQ.iQuarter as T,isnull(sum(qty),0) as tamt 
		from vw_CalenderLDQ LEFT JOIN vw_4RP_HubInvExt on lastDate=iDate
		where vw_CalenderLDQ.iQuarter between @start and @end
		group by OEM,vw_CalenderLDQ.iQuarter order by vw_CalenderLDQ.iQuarter
	else
		SELECT isnull(plant,'') as Plant,vw_CalenderLDQ.iQuarter as T,isnull(sum(qty),0) as tamt 
		from vw_CalenderLDQ LEFT JOIN vw_4RP_HubInvExt on lastDate=iDate
		where vw_CalenderLDQ.iQuarter between @start and @end
		group by plant,vw_CalenderLDQ.iQuarter order by vw_CalenderLDQ.iQuarter
end
if(@timeline =3)
begin
	if(@isOEM=1)
		SELECT isnull(OEM,'') as OEM,vw_CalenderLDP.iPeriod as T,isnull(sum(qty),0) as tamt 
		from vw_CalenderLDP LEFT JOIN vw_4RP_HubInvExt on lastDate=iDate
		where vw_CalenderLDP.iPeriod between @start and @end
		group by OEM,vw_CalenderLDP.iPeriod order by vw_CalenderLDP.iPeriod
	else
		SELECT isnull(plant,'') as Plant,vw_CalenderLDP.iPeriod as T,isnull(sum(qty),0) as tamt 
		from vw_CalenderLDP LEFT JOIN vw_4RP_HubInvExt on lastDate=iDate
		where vw_CalenderLDP.iPeriod between @start and @end
		group by plant,vw_CalenderLDP.iPeriod order by vw_CalenderLDP.iPeriod
end 
if(@timeline =6)
begin
	if(@isOEM=1)
		SELECT isnull(OEM,'') as OEM,a.iMonth as T,isnull(sum(qty),0) as tamt 
		from vw_CalenderLDM as a LEFT JOIN vw_4RP_HubInvExt as b on lastDate=iDate
		where a.iMonth between @start and @end
		group by OEM,a.iMonth order by a.iMonth
	else
		SELECT isnull(plant,'') as Plant,a.iMonth as T,isnull(sum(qty),0) as tamt 
		from vw_CalenderLDM as a LEFT JOIN vw_4RP_HubInvExt as b on lastDate=iDate
		where a.iMonth between @start and @end
		group by plant,a.iMonth order by a.iMonth
end 

declare @lastDate int
if(@timeline=4)
begin
select @lastDate = dbo.fx_getLastDate(@start,4)

	if(@isOEM=1)
select * from (
		select OEM,idate as T,sum(qty) as tamt from vw_4RP_HubInvExt where idate = @lastDate group by OEM,idate
		union all
		SELECT isnull(OEM,'') as OEM,a.idate as T,isnull(qty,0) as tamt 
		FROM vw_calender_ext as a LEFT JOIN 
		(select OEM,idate,sum(qty) as qty from vw_4RP_HubInvExt group by OEM,idate) as b ON a.iDate = b.iDate 
		where a.iDate between @start and @end
) as xy order by T
	else
select * from (
		select Plant,idate as T,sum(qty) as tamt from vw_4RP_HubInvExt where idate = @lastDate group by plant,idate
		union all
		SELECT isnull(Plant,'') as Plant,a.idate as T,isnull(qty,0) as tamt 
		FROM vw_calender_ext as a LEFT JOIN 
		(select Plant,idate,sum(qty) as qty from vw_4RP_HubInvExt group by Plant,idate) as b ON a.iDate = b.iDate 
		where a.iDate between @start and @end
) as xy order by T
end

if(@timeline=5)
begin
select @lastDate = [dbo].[fx_getLastDate](@start,3)
	if(@isOEM=1)
select * from (
		select OEM,idate +' closing' as T,sum(qty) as tamt from vw_4RP_HubInvExt where idate = @lastDate group by OEM,idate
		union all
		SELECT isnull(OEM,'') as OEM,a.idate as T,isnull(qty,0) as tamt 
		FROM vw_calender_ext as a LEFT JOIN 
		(select OEM,idate,sum(qty) as qty from vw_4RP_HubInvExt group by OEM,idate) as b ON a.iDate = b.iDate 
		where a.iPeriod between @start and @end
) as xy order by T
	else
select * from (
		select Plant,idate as T,sum(qty) as tamt from vw_4RP_HubInvExt where idate = @lastDate group by plant,idate
		union all
		SELECT isnull(Plant,'') as Plant,a.idate as T,isnull(qty,0) as tamt 
		FROM vw_calender_ext as a LEFT JOIN 
		(select Plant,idate,sum(qty) as qty from vw_4RP_HubInvExt group by Plant,idate) as b ON a.iDate = b.iDate 
		where a.iPeriod between @start and @end
) as xy order by T
end
end















GO
