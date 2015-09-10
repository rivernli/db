USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vw_KOI_Calender_Month]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_KOI_Calender_Month]
as
SELECT CalenderYear,CalenderMonth,CONVERT(varchar(12),MIN(CalenderDate),23) as CalenderDateFrom,
 CONVERT(varchar(12),MAX(CalenderDate),23) as CalenderDateTo  
 FROM DataWarehouse.dbo.DW_DIM_Calender 
 WHERE Calenderdate < CONVERT(VARCHAR(10),GETDATE()-1,120) 
 GROUP BY CalenderYear,CalenderMonth 

GO
