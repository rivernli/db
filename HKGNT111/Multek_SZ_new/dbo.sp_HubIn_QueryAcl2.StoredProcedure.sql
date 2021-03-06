USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[sp_HubIn_QueryAcl2]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_HubIn_QueryAcl2]
@timeline tinyint,@start int,@end int,@isOEM bit
as
begin

if(@timeline = 1)
begin
	if(@isOEM =1)
		select isnull(OEM,'') as OEM,a.FiscalYear as T,isnull(sum(amount),0) as tamt 
		from vw_CalenderLDFY as a left join vw_4RP_HubInExDate as b on a.FiscalYear=b.iYear and b.iYear=b.hkYear
		where a.FiscalYear between @start and @end
		group by OEM,a.FiscalYear order by a.FiscalYear
	else
		select isnull(Plant,'') as Plant,a.FiscalYear as T,isnull(sum(amount),0) as tamt 
		from vw_CalenderLDFY as a left join vw_4RP_HubInExDate as b on a.FiscalYear=b.iYear and b.iYear=b.hkYear
		where a.FiscalYear between @start and @end
		group by Plant,a.FiscalYear order by a.FiscalYear
end
if(@timeline=2)
begin
	if(@isOEM =1)
		select isnull(OEM,'') as OEM,a.iQuarter as T,isnull(sum(amount),0) as tamt 
		from vw_CalenderLDQ as a left join vw_4RP_HubInExDate as b on a.iQuarter=b.iQuarter and b.iQuarter=b.hkQuarter
		where a.iQuarter between @start and @end
		group by OEM,a.iQuarter order by a.iQuarter
	else
		select isnull(Plant,'') as Plant,a.iQuarter as T,isnull(sum(amount),0) as tamt 
		from vw_CalenderLDQ as a left join vw_4RP_HubInExDate as b on a.iQuarter=b.iQuarter and b.iQuarter=b.hkQuarter
		where a.iQuarter between @start and @end
		group by Plant,a.iQuarter order by a.iQuarter
end
if(@timeline =3)
begin
	if(@isOEM =1)
		select isnull(OEM,'') as OEM,a.iPeriod as T,isnull(sum(amount),0) as tamt 
		from vw_CalenderLDP as a left join vw_4RP_HubInExDate as b on a.iPeriod=b.iPeriod and b.iPeriod=b.hkPeriod
		where a.iPeriod between @start and @end
		group by OEM,a.iPeriod order by a.iPeriod
	else
		select isnull(Plant,'') as Plant,a.iPeriod as T,isnull(sum(amount),0) as tamt 
		from vw_CalenderLDP as a left join vw_4RP_HubInExDate as b on a.iPeriod=b.iPeriod and b.iPeriod=b.hkPeriod
		where a.iPeriod between @start and @end
		group by Plant,a.iPeriod order by a.iPeriod
end 
if(@timeline =6)
begin
	if(@isOEM =1)
		select isnull(OEM,'') as OEM,a.iMonth as T,isnull(sum(amount),0) as tamt 
		from vw_CalenderLDM as a left join vw_4RP_HubInExDate as b on a.iMonth=b.iMonth and b.iMonth=b.hkmonth
		where a.iMonth between @start and @end
		group by OEM,a.iMonth order by a.iMonth
	else
		select isnull(Plant,'') as Plant,a.iMonth as T,isnull(sum(amount),0) as tamt 
		from vw_CalenderLDM as a left join vw_4RP_HubInExDate as b on a.iMonth=b.iMonth and b.iMonth=b.hkmonth
		where a.iMonth between @start and @end
		group by Plant,a.iMonth order by a.iMonth
end 


if(@timeline=4)
begin
	if(@isOEM=1)
		SELECT isnull(OEM,'') as OEM,a.idate as T,isnull(amount,0) as tamt 
		FROM vw_calender_ext as a LEFT JOIN 
		(select OEM,idate,sum(amount) as amount from vw_4RP_HubInEx group by OEM,idate) as b ON a.iDate = b.iDate
		where a.iDate between @start and @end
		order by a.iDate
	else
		SELECT isnull(Plant,'') as Plant,a.idate as T,isnull(amount,0) as tamt 
		FROM vw_calender_ext as a LEFT JOIN 
		(select Plant,idate,sum(amount) as amount from vw_4RP_HubInEx group by Plant,idate) as b ON a.iDate = b.iDate
		where a.iDate between @start and @end
		order by a.iDate
	
end

if(@timeline=5)
begin
	if(@isOEM=1)
		SELECT isnull(OEM,'') as OEM,a.idate as T,isnull(amount,0) as tamt 
		FROM vw_calender_ext as a LEFT JOIN 
		(select OEM,idate,sum(amount) as amount from vw_4RP_HubInEx group by OEM,idate) as b ON a.iDate = b.iDate
		where a.iPeriod between @start and @end
		order by a.iDate
	else
		SELECT isnull(Plant,'') as Plant,a.idate as T,isnull(amount,0) as tamt 
		FROM vw_calender_ext as a LEFT JOIN 
		(select Plant,idate,sum(amount) as amount from vw_4RP_HubInEx group by Plant,idate) as b ON a.iDate = b.iDate
		where a.iPeriod between @start and @end
		order by a.iDate
end
end
GO
