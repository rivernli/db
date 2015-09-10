USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_HubInv_QueryLDP_QTY_Plant]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO











create  procedure [dbo].[sp_HubInv_QueryLDP_QTY_Plant]
@timeline tinyint,@start int,@end int
as
begin

if(@timeline = 1)
begin
		SELECT isnull(Plant,'') as Plant,vw_CalenderLDFY.fiscalYear as T,isnull(sum(qty),0) as tamt 
		from vw_CalenderLDFY LEFT JOIN vw_4RP_HubInvExt on lastDate=iDate
		where vw_CalenderLDFY.fiscalYear between @start and @end
		group by Plant,vw_CalenderLDFY.fiscalYear order by vw_CalenderLDFY.fiscalYear
end
if(@timeline=2)
begin
		SELECT isnull(Plant,'') as Plant,vw_CalenderLDQ.iQuarter as T,isnull(sum(qty),0) as tamt 
		from vw_CalenderLDQ LEFT JOIN vw_4RP_HubInvExt on lastDate=iDate
		where vw_CalenderLDQ.iQuarter between @start and @end
		group by Plant,vw_CalenderLDQ.iQuarter order by vw_CalenderLDQ.iQuarter
end
if(@timeline =3)
begin
		SELECT isnull(Plant,'') as Plant,vw_CalenderLDP.iPeriod as T,isnull(sum(qty),0) as tamt 
		from vw_CalenderLDP LEFT JOIN vw_4RP_HubInvExt on lastDate=iDate
		where vw_CalenderLDP.iPeriod between @start and @end
		group by Plant,vw_CalenderLDP.iPeriod order by vw_CalenderLDP.iPeriod
end 
if(@timeline =6)
begin
		SELECT isnull(Plant,'') as Plant,a.iMonth as T,isnull(sum(qty),0) as tamt 
		from vw_CalenderLDM as a LEFT JOIN vw_4RP_HubInvExt as b on lastDate=iDate
		where a.iMonth between @start and @end
		group by Plant,a.iMonth order by a.iMonth
end 

declare @lastDate int
if(@timeline=4)
begin
	select @lastDate = dbo.fx_getLastDate(@start,4)
	select * from (
		select Plant,idate as T,sum(qty) as tamt from vw_4RP_HubInvExt where idate = @lastDate group by Plant,idate
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
	select * from (
		select Plant,idate +' closing' as T,sum(qty) as tamt from vw_4RP_HubInvExt where idate = @lastDate group by Plant,idate
		union all
		SELECT isnull(Plant,'') as Plant,a.idate as T,isnull(qty,0) as tamt 
		FROM vw_calender_ext as a LEFT JOIN 
		(select Plant,idate,sum(qty) as qty from vw_4RP_HubInvExt group by Plant,idate) as b ON a.iDate = b.iDate 
		where a.iPeriod between @start and @end
	) as xy order by T
end
end
















GO
