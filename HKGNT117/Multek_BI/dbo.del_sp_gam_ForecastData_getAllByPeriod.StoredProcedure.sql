USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[del_sp_gam_ForecastData_getAllByPeriod]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[del_sp_gam_ForecastData_getAllByPeriod]
@startPeriod int,
@endPeriod int
as 

select * from gam_oem left join gam_forecast on oemid = oem_id
and fiscal_period between @startPeriod and @endPeriod
and isValid=1

GO
