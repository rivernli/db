USE [Multek_ZH]
GO
/****** Object:  UserDefinedFunction [dbo].[fx_getCurrentPeriod]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[fx_getCurrentPeriod]()
returns int
as 
begin 

declare @period int
set @period=0

select @period = iperiod from vw_calender_ext where idate = Convert(varchar(8),getdate(),112)
return @period

end
GO
