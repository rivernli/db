USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_b2f_forecast_result_vertical]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_gam_b2f_forecast_result_vertical]
as
set nocount on

declare @sp int 
select @sp=multek_zh.dbo.fx_getCurrentPeriod()
select forecastPeriod,cpn,qty * (smtPrice + fpcPrice + bomPrice) as amt,
sales,0 as oemid,oem +' B2F' as cusOEM, oem as oemName,'B2F' as plant,
pn,0 as expASP,0 as expASPPeriod,0 cusASP,0 as maxASp, 0 as minAsp, '' as layer,'' as tech,
'' as surf,0 as ttlamt,0 as ttlsqft, 0 as ttlqty,'' as remark,null as d, null as q
 from gam_b2f where uploadperiod=@sp
 
 set nocount off




 
GO
