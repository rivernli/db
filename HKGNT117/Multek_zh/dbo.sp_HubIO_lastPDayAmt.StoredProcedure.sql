USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_HubIO_lastPDayAmt]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE procedure [dbo].[sp_HubIO_lastPDayAmt]
@inputTime int,@byTimeLine int, @isInventory bit,
@lastdate int output, @amount int output

as
--last period date at previous period by fy,quarter,period and date
/*declare @inputTime int
declare @byTimeLine int
declare @isInventory bit
set @isInventory = 1
set @byTimeLine = 4
set @inputTime = 20110120
declare @lastdate int
declare @amount int
*/
/*
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
*/
select @lastdate=[dbo].[fx_getLastDate](@inputTime,@byTimeLine)

if @isInventory = 1
	select @amount=isnull(round(sum(amount),0),0) from vw_4RP_HubInvExt where iDate=@lastdate
else
	select @amount=isnull(round(sum(amount),0),0) from vw_4RP_HubOutExt where iDate=@lastdate
/*
select @currentperiod
select @lastdate
select @amount*/


GO
