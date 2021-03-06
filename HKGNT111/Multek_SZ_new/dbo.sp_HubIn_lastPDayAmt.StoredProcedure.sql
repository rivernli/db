USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[sp_HubIn_lastPDayAmt]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_HubIn_lastPDayAmt]
@inputTime int,@byTimeLine int,@lastdate int output, @amount int output
as

declare @currentperiod int

if(@byTimeLine=1)
	select top 1 @currentperiod=iperiod from vw_calender_ext where fiscalYear=@inputTime order by iperiod
if(@byTimeLine=2)
	select top 1 @currentperiod=iperiod from vw_calender_ext where iQuarter=@inputTime order by iperiod
if(@byTimeLine=3)
	select @currentperiod=@inputTime
if(@byTimeLine=4)
	select @currentperiod=iperiod from vw_calender_ext where idate = @inputTime

select top 1 @lastdate=idate from vw_calender_ext where iperiod < @currentperiod order by idate desc

select @amount=isnull(round(sum(amount),0),0) from vw_4RP_HubInEx where iDate=@lastdate
/*
--last date and hkdate in same period
select @amount=isnull(round(sum(amount),0),0) from vw_4RP_HubInExDate where iDate=@lastdate and iperiod = hkperiod

--last date and hkdate in same date
select @amount=isnull(round(sum(amount),0),0) from vw_4RP_HubInExDate where iDate=@lastdate and iDate = hkDate
*/
GO
