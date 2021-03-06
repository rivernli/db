USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vw_B2F_Forecast_detail_New]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[vw_B2F_Forecast_detail_New]
as
SELECT substring(CONVERT(VARCHAR(11), convert(datetime,[month]),113),4,8) as [Forecast Period],
userName as Sales,oem,partNumber as [Customer Part No.],internalprojectno as [Internal Part No.],
sqft_pnl as sqft, forecastqty as qty,
array,smtprice as smt,fpcunitprice as fpc,bomprice as bom

 from 
B2F_Forecast_detail_New
GO
