USE [Multek_ZH]
GO
/****** Object:  UserDefinedFunction [dbo].[fx_getPeriodPrevious]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create  function [dbo].[fx_getPeriodPrevious](@iperiod int)
returns int
as 
begin 

declare @period int
set @period=0
select top 1 @period = iperiod from vw_calender_ext
where iperiod < @iperiod
order by iperiod desc

return @period
end
GO
