USE [DataWarehouse]
GO
/****** Object:  View [dbo].[vc_verify_calender_with_tfgld105]    Script Date: 2014/11/12 17:04:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view [dbo].[vc_verify_calender_with_tfgld105]
as
SELECT FISCALYEARDESC,FISCALPERIODDESC,MIN(CALENDERDATE) as StartDate,MAX(CALENDERDATE) as EndDate
FROM DBO.DW_DIM_CALENDER
GROUP BY FISCALYEARDESC,FISCALPERIODDESC

GO
