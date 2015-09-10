USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_getPeriodDate]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[sp_getPeriodDate] 
@period int output,
@iDate int = 0
as

if(@iDate =0)
	set @iDate =cast(convert(char(8),getdate(),112) as int)
	--set @period = dbo.fx_getPeriodDate(null)
	--set @period = dbo.fx_getPeriodDate(default)
	--set @period = dbo.fx_getPeriodDate(@iDate)


select @period = iperiod from vw_calender_ext where idate = @iDate
GO
