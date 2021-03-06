USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_cem_forecast_mix_result_download]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_gam_cem_forecast_mix_result_download]
as
set nocount on

declare @currentPeriod int
select @currentPeriod=multek_zh.[dbo].[fx_getPeriodDate](default)
if not exists (select top 1 1 from gam_CEM_mix_Sales_forecast_result where period=@currentPeriod and username='CEM')
begin
	exec [sp_gam_cem_forecast_mix_result]
end
select userName,cusOEM,oemName,plant,cpn as cusPart,ipn as item,cusASP,expASP,expASPPeriod,maxASP,minASP,
ttlAMt,ttlQty,ttlSQFT,layer,tech,surf,remark,
p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p12,p13 
from gam_CEM_mix_Sales_forecast_result where period=@currentPeriod

set nocount off
GO
