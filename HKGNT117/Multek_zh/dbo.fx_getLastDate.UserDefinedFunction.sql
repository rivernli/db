USE [Multek_ZH]
GO
/****** Object:  UserDefinedFunction [dbo].[fx_getLastDate]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create 
function [dbo].[fx_getLastDate](@inputTime int,@byTimeLine int)
returns int
as
begin

declare @lastdate int
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
return @lastdate

end
GO
