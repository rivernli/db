USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_HubInv_QueryLDP_CEMOEM]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






/*
1.fiscal year
2.quator
3.period
4.date
5.date by period
6.month
*/

CREATE  procedure [dbo].[sp_HubInv_QueryLDP_CEMOEM]
@timeline tinyint,@start int,@end int
as
begin

create table #tmp (	oem nvarchar(100) null,	t nvarchar(50),tamt real)

if(@timeline = 1)
begin
	insert into #tmp (oem,t,tamt)
		SELECT rtrim(isnull(CEM,''))+ '|' + rtrim(isnull(OEM,'')) as CEM,vw_CalenderLDFY.fiscalYear as T,isnull(sum(amount),0) as tamt 
		from vw_CalenderLDFY LEFT JOIN vw_4RP_HubInvExt on lastDate=iDate
		where vw_CalenderLDFY.fiscalYear between @start and @end 
		group by rtrim(isnull(CEM,''))+ '|' + rtrim(isnull(OEM,'')),vw_CalenderLDFY.fiscalYear order by vw_CalenderLDFY.fiscalYear
end
if(@timeline=2)
begin
	insert into #tmp (oem,t,tamt)
		SELECT rtrim(isnull(CEM,''))+ '|' + rtrim(isnull(OEM,'')) as CEM,vw_CalenderLDQ.iQuarter as T,isnull(sum(amount),0) as tamt 
		from vw_CalenderLDQ LEFT JOIN vw_4RP_HubInvExt on lastDate=iDate
		where vw_CalenderLDQ.iQuarter between @start and @end
		group by rtrim(isnull(CEM,''))+ '|' + rtrim(isnull(OEM,'')),vw_CalenderLDQ.iQuarter order by vw_CalenderLDQ.iQuarter
end
if(@timeline =3)
begin
	insert into #tmp (oem,t,tamt)
		SELECT rtrim(isnull(CEM,''))+ '|' + rtrim(isnull(OEM,'')) as CEM,vw_CalenderLDP.iPeriod as T,isnull(sum(amount),0) as tamt 
		from vw_CalenderLDP LEFT JOIN vw_4RP_HubInvExt on lastDate=iDate
		where vw_CalenderLDP.iPeriod between @start and @end
		group by rtrim(isnull(CEM,''))+ '|' + rtrim(isnull(OEM,'')),vw_CalenderLDP.iPeriod order by vw_CalenderLDP.iPeriod
end 
if(@timeline =6)
begin
	insert into #tmp (oem,t,tamt)
		SELECT rtrim(isnull(CEM,''))+ '|' + rtrim(isnull(OEM,'')) as CEM,a.iMonth as T,isnull(sum(amount),0) as tamt 
		from vw_CalenderLDM as a LEFT JOIN vw_4RP_HubInvExt as b on lastDate=iDate
		where a.iMonth between @start and @end
		group by rtrim(isnull(CEM,''))+ '|' + rtrim(isnull(OEM,'')),a.iMonth order by a.iMonth
end 

declare @lastDate int
if(@timeline=4)
begin
	select @lastDate = dbo.fx_getLastDate(@start,4)
	insert into #tmp (oem,t,tamt)
	select * from (
			select rtrim(isnull(CEM,''))+ '|' + rtrim(isnull(OEM,'')) as CEM,idate as T,sum(amount) as tamt from vw_4RP_HubInvExt 
			where idate = @lastDate and iperiod > 201201 group by rtrim(isnull(CEM,''))+ '|' + rtrim(isnull(OEM,'')),idate
			union all
			SELECT isnull(CEM,'') as CEM,a.idate as T,isnull(amount,0) as tamt 
			FROM vw_calender_ext as a LEFT JOIN 
			(select rtrim(isnull(CEM,''))+ '|' + rtrim(isnull(OEM,'')) as CEM,idate,sum(amount) as amount from vw_4RP_HubInvExt 
			where iperiod > 201201 group by rtrim(isnull(CEM,''))+ '|' + rtrim(isnull(OEM,'')),idate) as b ON a.iDate = b.iDate 
			where a.iDate between @start and @end
	) as xy order by T
end

if(@timeline=5)
begin
	select @lastDate = [dbo].[fx_getLastDate](@start,3)
	insert into #tmp (oem,t,tamt)
	select * from (
			select rtrim(isnull(CEM,''))+ '|' + rtrim(isnull(OEM,'')) as CEM,idate +' closing' as T,sum(amount) as tamt from vw_4RP_HubInvExt 
			where idate = @lastDate and iperiod > 201201 group by rtrim(isnull(CEM,''))+ '|' + rtrim(isnull(OEM,'')),idate
			union all
			SELECT isnull(CEM,'') as CEM,a.idate as T,isnull(amount,0) as tamt 
			FROM vw_calender_ext as a LEFT JOIN 
			(select rtrim(isnull(CEM,''))+ '|' + rtrim(isnull(OEM,'')) as CEM,idate,sum(amount) as amount from vw_4RP_HubInvExt 
			where iperiod > 201201 group by rtrim(isnull(CEM,''))+ '|' + rtrim(isnull(OEM,'')),idate) as b ON a.iDate = b.iDate 
			where a.iPeriod between @start and @end
	) as xy order by T
end
update #tmp set oem = null where oem = '|'
select * from #tmp
drop table #tmp

end




















GO
