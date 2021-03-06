USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_forecast_output_prepareUpdateASP]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[sp_gam_forecast_output_prepareUpdateASP]
as
set nocount on
declare @current_period int
select @current_period = multek_zh.[dbo].[fx_getPeriodDate](default)

--select * from dbo.gam_part_forecast
update gam_part_forecast set asp=a.asp
from dbo.gam_customerPart_remark as a left join gam_part_forecast as b
on a.oem_id=b.oemid and project=part_no and a.asp<>b.asp
where period > @current_period

--select * from dbo.gam_part_forecast where asp <> 0
set nocount off
GO
