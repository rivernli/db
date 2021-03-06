USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_HubOut_QueryLDP2]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






create  procedure [dbo].[sp_HubOut_QueryLDP2]
@timeline tinyint,@start int,@end int,@isOEM bit
as
begin

if(@timeline = 1)
begin
	if(@isOEM=1)
		SELECT isnull(OEM,'') as OEM,a.fiscalYear as T,isnull(sum(amount),0) as tamt 
		from vw_CalenderLDFY as a LEFT JOIN vw_4RP_HubOutExt as b on lastDate=iDate
		where a.fiscalYear between @start and @end
		group by OEM,a.fiscalYear order by a.fiscalYear
	else
		SELECT isnull(plant,'') as Plant,a.fiscalYear as T,isnull(sum(amount),0) as tamt 
		from vw_CalenderLDFY as a LEFT JOIN vw_4RP_HubOutExt as b on lastDate=iDate
		where a.fiscalYear between @start and @end
		group by plant,a.fiscalYear order by a.fiscalYear
end
if(@timeline=2)
begin
	if(@isOEM=1)
		SELECT isnull(OEM,'') as OEM,a.iQuarter as T,isnull(sum(amount),0) as tamt 
		from vw_CalenderLDQ as a LEFT JOIN vw_4RP_HubOutExt as b on lastDate=iDate
		where a.iQuarter between @start and @end
		group by OEM,a.iQuarter order by a.iQuarter
	else
		SELECT isnull(plant,'') as Plant,a.iQuarter as T,isnull(sum(amount),0) as tamt 
		from vw_CalenderLDQ as a LEFT JOIN vw_4RP_HubOutExt as b on lastDate=iDate
		where a.iQuarter between @start and @end
		group by plant,a.iQuarter order by a.iQuarter
end
if(@timeline =3)
begin
	if(@isOEM=1)
		SELECT isnull(OEM,'') as OEM,a.iPeriod as T,isnull(sum(amount),0) as tamt 
		from vw_CalenderLDP as a LEFT JOIN vw_4RP_HubOutExt as b on lastDate=iDate
		where a.iPeriod between @start and @end
		group by OEM,a.iPeriod order by a.iPeriod
	else
		SELECT isnull(plant,'') as Plant,a.iPeriod as T,isnull(sum(amount),0) as tamt 
		from vw_CalenderLDP as a LEFT JOIN vw_4RP_HubOutExt as b on lastDate=iDate
		where a.iPeriod between @start and @end
		group by plant,a.iPeriod order by a.iPeriod
end 
if(@timeline =6)
begin
	if(@isOEM=1)
		SELECT isnull(OEM,'') as OEM,a.iMonth as T,isnull(sum(amount),0) as tamt 
		from vw_CalenderLDM as a LEFT JOIN vw_4RP_HubOutExt as b on lastDate=iDate
		where a.iMonth between @start and @end
		group by OEM,a.iMonth order by a.iMonth
	else
		SELECT isnull(plant,'') as Plant,a.iMonth as T,isnull(sum(amount),0) as tamt 
		from vw_CalenderLDM as a LEFT JOIN vw_4RP_HubOutExt as b on lastDate=iDate
		where a.iMonth between @start and @end
		group by plant,a.iMonth order by a.iMonth
end 

if(@timeline=4)
begin
	if(@isOEM=1)
		SELECT isnull(OEM,'') as OEM,a.idate as T,isnull(amount,0) as tamt 
		FROM vw_calender_ext as a LEFT JOIN 
		(select OEM,idate,sum(amount) as amount from vw_4RP_HubOutExt group by OEM,idate) as b
		ON a.iDate = b.iDate where a.iDate between @start and @end
		order by a.iDate
	else
		SELECT isnull(Plant,'') as Plant,a.idate as T,isnull(amount,0) as tamt 
		FROM vw_calender_ext as a LEFT JOIN 
		(select Plant,idate,sum(amount) as amount from vw_4RP_HubOutExt group by Plant,idate) as b
		ON a.iDate = b.iDate where a.iDate between @start and @end
		order by a.iDate
end

if(@timeline=5)
begin
	if(@isOEM=1)
		SELECT isnull(OEM,'') as OEM,a.idate as T,isnull(amount,0) as tamt 
		FROM vw_calender_ext as a LEFT JOIN 
		(select OEM,idate,sum(amount) as amount from vw_4RP_HubOutExt group by OEM,idate) as b
		ON a.iDate = b.iDate where a.iPeriod between @start and @end
		order by a.iDate
	else
		SELECT isnull(Plant,'') as Plant,a.idate as T,isnull(amount,0) as tamt 
		FROM vw_calender_ext as a LEFT JOIN 
		(select Plant,idate,sum(amount) as amount from vw_4RP_HubOutExt group by Plant,idate) as b
		ON a.iDate = a.iDate where a.iPeriod between @start and @end
		order by a.iDate
end
end











GO
