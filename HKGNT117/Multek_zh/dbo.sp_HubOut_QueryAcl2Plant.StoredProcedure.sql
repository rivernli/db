USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_HubOut_QueryAcl2Plant]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create procedure [dbo].[sp_HubOut_QueryAcl2Plant]
@timeline tinyint,@start int,@end int,@isOEM bit,@plant char(4)
as
begin
if(@timeline = 1)
begin

	if(@isOEM=1)
		SELECT isnull(OEM,'') as OEM,a.fiscalYear as T,isnull(sum(amount),0) as tamt 
		FROM vw_CalenderLDFY as a LEFT JOIN vw_4RP_HubOutExt as b ON a.fiscalYear = b.fiscalYear
		where a.fiscalYear between @start and @end and b.plant=@plant
		group by OEM,a.fiscalYear order by a.fiscalYear
	else
		SELECT isnull(plant,'') as plant,a.fiscalYear as T,isnull(sum(amount),0) as tamt 
		FROM vw_CalenderLDFY as a LEFT JOIN vw_4RP_HubOutExt as b ON a.fiscalYear = b.fiscalYear
		where a.fiscalYear between @start and @end and b.plant=@plant
		group by plant,a.fiscalYear order by a.fiscalYear

end
if(@timeline=2)
begin
	if(@isOEM=1)
		SELECT isnull(OEM,'') as OEM,a.iquarter as T,isnull(sum(amount),0) as tamt 
		FROM vw_CalenderLDQ as a LEFT JOIN vw_4RP_HubOutExt as b ON a.iquarter = b.iquarter
		where a.iQuarter between @start and @end and b.plant=@plant
		group by OEM,a.iquarter order by a.iquarter
	else
		SELECT isnull(plant,'') as plant,a.iquarter as T,isnull(sum(amount),0) as tamt 
		FROM vw_CalenderLDQ as a LEFT JOIN vw_4RP_HubOutExt as b ON a.iquarter = b.iquarter
		where a.iQuarter between @start and @end and b.plant=@plant
		group by plant,a.iquarter order by a.iquarter
end
if(@timeline =3)
begin
	if(@isOEM=1)
		SELECT isnull(OEM,'') as OEM,a.iPeriod as T,isnull(sum(amount),0) as tamt 
		FROM vw_CalenderLDP as a LEFT JOIN vw_4RP_HubOutExt as b ON a.iPeriod = b.iPeriod
		where a.iPeriod  between @start and @end and b.plant=@plant
		group by OEM,a.iPeriod order by a.iPeriod
	else
		SELECT isnull(plant,'') as plant,a.iPeriod as T,isnull(sum(amount),0) as tamt 
		FROM vw_CalenderLDP as a LEFT JOIN vw_4RP_HubOutExt as b ON a.iPeriod = b.iPeriod
		where a.iPeriod  between @start and @end and b.plant=@plant
		group by plant,a.iPeriod order by a.iPeriod
end 
if(@timeline=6)
begin
	if(@isOEM=1)
		SELECT isnull(OEM,'') as OEM,a.iMonth as T,isnull(sum(amount),0) as tamt 
		FROM vw_CalenderLDM as a LEFT JOIN vw_4RP_HubOutExt as b ON a.iMonth = b.iMonth
		where a.iMonth  between @start and @end and b.plant=@plant
		group by OEM,a.iMonth order by a.iMonth
	else
		SELECT isnull(plant,'') as plant,a.iMonth as T,isnull(sum(amount),0) as tamt 
		FROM vw_CalenderLDM as a LEFT JOIN vw_4RP_HubOutExt as b ON a.iMonth = b.iMonth
		where a.iMonth  between @start and @end and b.plant=@plant
		group by plant,a.iMonth order by a.iMonth

end


if(@timeline=4)
begin
	if(@isOEM=1)
		SELECT isnull(OEM,'') as OEM,a.idate as T,isnull(amount,0) as tamt 
		FROM vw_calender_ext as a LEFT JOIN 
		(select OEM,idate,sum(amount) as amount from vw_4RP_HubOutExt where plant=@plant group by OEM,idate) as b ON a.iDate = b.iDate
		where a.iDate between @start and @end
		order by a.iDate
	else
		SELECT isnull(Plant,'') as Plant,a.idate as T,isnull(amount,0) as tamt 
		FROM vw_calender_ext as a LEFT JOIN 
		(select Plant,idate,sum(amount) as amount from vw_4RP_HubOutExt where plant=@plant group by Plant,idate) as b ON a.iDate = b.iDate 
		where a.iDate between @start and @end
		order by a.iDate
end
if(@timeline=5)
begin
	if(@isOEM=1)
		SELECT isnull(OEM,'') as OEM,a.idate as T,isnull(amount,0) as tamt 
		FROM vw_calender_ext as a LEFT JOIN 
		(select OEM,idate,sum(amount) as amount from vw_4RP_HubOutExt where plant=@plant group by OEM,idate) as b ON a.iDate = b.iDate
		where a.iPeriod between @start and @end
		order by a.iDate
	else
		SELECT isnull(Plant,'') as Plant,a.idate as T,isnull(amount,0) as tamt 
		FROM vw_calender_ext as a LEFT JOIN 
		(select Plant,idate,sum(amount) as amount from vw_4RP_HubOutExt where plant=@plant group by Plant,idate) as b ON a.iDate = b.iDate 
		where a.iPeriod between @start and @end
		order by a.iDate
end

end


















GO
