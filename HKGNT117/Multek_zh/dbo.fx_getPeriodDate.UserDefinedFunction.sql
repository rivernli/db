USE [Multek_ZH]
GO
/****** Object:  UserDefinedFunction [dbo].[fx_getPeriodDate]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*declare @a int

select @a = dbo.fx_getPeriodDate(default)
print @a
*/

CREATE function [dbo].[fx_getPeriodDate](@iDate int=null)
returns int
as 
begin 

declare @period int
set @period=0
if(@iDate is null)
	set @iDate = cast(convert(char(8),getdate(),112) as int)

select @period = iperiod from vw_calender_ext where idate = @iDate
return @period

end



GO
