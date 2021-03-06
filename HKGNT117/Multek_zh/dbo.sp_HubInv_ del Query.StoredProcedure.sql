USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_HubInv_|del|Query]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE procedure [dbo].[sp_HubInv_|del|Query]
@timeline tinyint,@start int,@end int
as
begin

if(@timeline = 1)
begin
select OEM,FiscalYear as T,sum(amt) as tamt from vw_4RP_HubInvByDateCalender
where fiscalYear between @start and @end 
group by OEM,FiscalYear order by FiscalYear
end

if(@timeline=2)
begin
select OEM,iQuarter as T,sum(amt) as tamt from dbo.vw_4RP_HubInvByDateCalender
where iQuarter between @start and @end
group by OEM,iQuarter order by iQuarter
end

if(@timeline =3)
begin
select OEM,iPeriod as T,sum(amt) as tamt from dbo.vw_4RP_HubInvByDateCalender
where iPeriod between @start and @end
group by OEM,iPeriod order by iPeriod
end 


if(@timeline=4)
begin
select OEM,iDate as T,amt as tamt from dbo.vw_4RP_HubInvByDateCalender 
where iDate between @start and @end
order by iDate
end
if(@timeline=5)
begin
select OEM,iDate as T,amt as tamt from dbo.vw_4RP_HubInvByDateCalender 
where iPeriod between @start and @end
order by iDate
end
end





GO
