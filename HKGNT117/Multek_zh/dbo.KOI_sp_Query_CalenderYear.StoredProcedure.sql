USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[KOI_sp_Query_CalenderYear]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[KOI_sp_Query_CalenderYear]
as 
SELECT  TOP 5 calenderYear 
	From DataWarehouse.dbo.DW_DIM_Calender
	WHERE calenderDate<=CONVERT(VARCHAR(10),GETDATE()-1,120)
	GROUP BY calenderYear
	ORDER BY calenderYear DESC 
GO
