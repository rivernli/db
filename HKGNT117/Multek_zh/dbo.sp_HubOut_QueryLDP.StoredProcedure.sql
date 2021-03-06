USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_HubOut_QueryLDP]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE  procedure [dbo].[sp_HubOut_QueryLDP]
@timeline tinyint,@start int,@end int
as
begin

if(@timeline = 1)
begin
	SELECT isnull(OEM,'') as OEM,fiscalYear as T,isnull(sum(amt),0) as tamt 
	FROM vw_CalenderLDFY LEFT JOIN vw_4RP_HubOutByDate ON lastDate = iDate
	where fiscalYear between @start and @end
	group by OEM,fiscalYear order by fiscalYear
end
if(@timeline=2)
begin
	SELECT isnull(OEM,'') as OEM,iQuarter as T,isnull(sum(amt),0) as tamt 
	FROM vw_CalenderLDQ LEFT JOIN vw_4RP_HubOutByDate ON lastDate = iDate
	where iQuarter between @start and @end
	group by OEM,iQuarter order by iQuarter
end
if(@timeline =3)
begin
	SELECT isnull(OEM,'') as OEM,iPeriod as T,isnull(sum(amt),0) as tamt 
	FROM vw_CalenderLDP LEFT JOIN vw_4RP_HubOutByDate ON lastDate = iDate
	where iperiod between @start and @end
	group by OEM,iPeriod order by iPeriod
end 


if(@timeline=4)
begin
	SELECT isnull(OEM,'') as OEM,vw_calender_ext.idate as T,isnull(amt,0) as tamt 
	FROM vw_calender_ext LEFT JOIN vw_4RP_HubOutByDate ON vw_calender_ext.iDate = vw_4RP_HubOutByDate.iDate
	where vw_calender_ext.iDate between @start and @end
	order by vw_calender_ext.iDate
end

if(@timeline=5)
begin
	SELECT isnull(OEM,'') as OEM,vw_calender_ext.idate as T,isnull(amt,0) as tamt 
	FROM vw_calender_ext LEFT JOIN vw_4RP_HubOutByDate ON vw_calender_ext.iDate = vw_4RP_HubOutByDate.iDate
	where vw_calender_ext.iPeriod between @start and @end
	order by vw_calender_ext.iDate
end
end







GO
