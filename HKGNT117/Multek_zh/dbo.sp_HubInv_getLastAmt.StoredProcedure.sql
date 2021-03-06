USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_HubInv_getLastAmt]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[sp_HubInv_getLastAmt]
@timeline tinyint,@start int
as
begin

if(@timeline = 1)
begin
select sum(amt) as tamt,max(iDate) as lastDate from vw_4RP_HubInvByDateCalender where iDate in (select top 1 iDate from vw_4RP_HubInvByDateCalender where 
	FiscalYear  < @start 
order by iDate,amt,oem desc)
end

if(@timeline=2)
begin
select sum(amt) as tamt,max(iDate) as lastDate from vw_4RP_HubInvByDateCalender where iDate in (select top 1 iDate from vw_4RP_HubInvByDateCalender where 
	iQuarter  < @start 
order by iDate,amt,oem desc)
end

if(@timeline=3)
begin
select sum(amt) as tamt,max(iDate) as lastDate from vw_4RP_HubInvByDateCalender where iDate in (select top 1 iDate from vw_4RP_HubInvByDateCalender where 
	iPeriod  < @start 
order by iDate,amt,oem desc)
end 

if(@timeline=4)
begin
select sum(amt) as tamt,max(iDate) as lastDate from vw_4RP_HubInvByDateCalender where iDate in (select top 1 iDate from vw_4RP_HubInvByDateCalender where 
	idate  < @start 
order by iDate,amt,oem desc)
end

end



GO
