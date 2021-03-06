USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_ForecastData_History]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_gam_ForecastData_History] (@oem_id int,@fiscal_period int)
as
SELECT top 10
lo.fcst_period as submit_fcst_period, 
submit_date, 
lo.fcst_amt,  
f.fcst_amt_sumbypart AS current_amt, 
f.fcst_amt_sumbypart - lo.fcst_amt AS diff,
f.ols_adjust as current_ols,
f.topside_adjust as current_topside,
lo.ols_adjust as ols,
lo.topside_adjust as topside
FROM         dbo.gam_forecast_log AS lo LEFT OUTER JOIN
                      dbo.gam_forecast AS f ON lo.oem_id = f.oem_id AND lo.fiscal_period = f.fiscal_period
where lo.oem_id=@oem_id and lo.fiscal_period=@fiscal_period
order by submit_fcst_period desc
GO
