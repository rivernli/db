USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[sp_HubIn_QueryLDP]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_HubIn_QueryLDP]
@timeline tinyint,@start int,@end int
as
begin

if(@timeline = 1)
begin
	SELECT isnull(OEM,'') as OEM,fiscalYear as T,isnull(sum(amount),0) as tamt 
	FROM vw_CalenderLDFY LEFT JOIN 
	(select OEM,idate,sum(amount) as amount from vw_4RP_HubInEx group by OEM,idate) as b ON lastDate = iDate
	where fiscalYear between @start and @end
	group by OEM,fiscalYear order by fiscalYear
end
if(@timeline=2)
begin
	SELECT isnull(OEM,'') as OEM,iQuarter as T,isnull(sum(amount),0) as tamt 
	FROM vw_CalenderLDQ LEFT JOIN
	(select OEM,idate,sum(amount) as amount from vw_4RP_HubInEx group by OEM,idate) as b ON lastDate = iDate
	where iQuarter between @start and @end
	group by OEM,iQuarter order by iQuarter
end
if(@timeline =3)
begin
	SELECT isnull(OEM,'') as OEM,iPeriod as T,isnull(sum(amount),0) as tamt 
	FROM vw_CalenderLDP LEFT JOIN 
	(select OEM,idate,sum(amount) as amount from vw_4RP_HubInEx group by OEM,idate) as b ON lastDate = iDate
	where iperiod between @start and @end
	group by OEM,iPeriod order by iPeriod
end 
if(@timeline =6)
begin
	SELECT isnull(OEM,'') as OEM,iMonth as T,isnull(sum(amount),0) as tamt 
	FROM vw_CalenderLDM LEFT JOIN 
	(select OEM,idate,sum(amount) as amount from vw_4RP_HubInEx group by OEM,idate) as b ON lastDate = iDate
	where imonth between @start and @end
	group by OEM,iMonth order by iMonth
end 


if(@timeline=4)
begin
	SELECT isnull(OEM,'') as OEM,a.idate as T,isnull(amount,0) as tamt 
	FROM vw_calender_ext as a LEFT JOIN 
	(select OEM,idate,sum(amount) as amount from vw_4RP_HubInEx group by OEM,idate) as b ON a.iDate = b.iDate
	where a.iDate between @start and @end
	order by a.iDate
end

if(@timeline=5)
begin
	SELECT isnull(OEM,'') as OEM,a.idate as T,isnull(amount,0) as tamt 
	FROM vw_calender_ext as a LEFT JOIN 
	(select OEM,idate,sum(amount) as amount from vw_4RP_HubInEx group by OEM,idate) as b ON a.iDate = b.iDate
	where a.iPeriod between @start and @end
	order by a.iDate
end
end
GO
