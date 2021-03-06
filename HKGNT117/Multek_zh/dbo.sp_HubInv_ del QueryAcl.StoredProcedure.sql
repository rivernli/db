USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_HubInv_|del|QueryAcl]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




create procedure [dbo].[sp_HubInv_|del|QueryAcl]
@timeline tinyint,@start int,@end int
as
begin

if(@timeline = 1)
begin
	SELECT isnull(OEM,'') as OEM,a.fiscalYear as T,isnull(sum(amt),0) as tamt 
	FROM vw_CalenderLDFY as a LEFT JOIN vw_4RP_HubInvByDateCalender as b ON a.fiscalYear = b.fiscalYear
	where a.fiscalYear between @start and @end
	group by OEM,a.fiscalYear order by a.fiscalYear

end
if(@timeline=2)
begin
	SELECT isnull(OEM,'') as OEM,a.iQuarter as T,isnull(sum(amt),0) as tamt 
	FROM vw_CalenderLDQ as a LEFT JOIN vw_4RP_HubInvByDateCalender as b ON a.iQuarter = b.iQuarter
	where a.iQuarter between @start and @end
	group by OEM,a.iQuarter order by a.iQuarter
end
if(@timeline =3)
begin
	SELECT isnull(OEM,'') as OEM,a.iPeriod as T,isnull(sum(amt),0) as tamt 
	FROM vw_CalenderLDP as a LEFT JOIN vw_4RP_HubInvByDateCalender as b ON a.iPeriod = b.iPeriod
	where a.iPeriod  between @start and @end
	group by OEM,a.iPeriod order by a.iPeriod

end 


if(@timeline=4)
begin
	SELECT isnull(OEM,'') as OEM,vw_calender_ext.idate as T,isnull(amt,0) as tamt 
	FROM vw_calender_ext LEFT JOIN vw_4RP_HubInvByDate ON vw_calender_ext.iDate = vw_4RP_HubInvByDate.iDate
	where vw_calender_ext.iDate between @start and @end
	order by vw_calender_ext.iDate
end

if(@timeline=5)
begin
	SELECT isnull(OEM,'') as OEM,vw_calender_ext.idate as T,isnull(amt,0) as tamt 
	FROM vw_calender_ext LEFT JOIN vw_4RP_HubInvByDate ON vw_calender_ext.iDate = vw_4RP_HubInvByDate.iDate
	where vw_calender_ext.iPeriod between @start and @end
	order by vw_calender_ext.iDate
end
end









GO
