USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[IES_sp_Sync_WO_Calc]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IES_sp_Sync_WO_Calc] 	
AS
	--重新同步当天WO数据
	TRUNCATE TABLE IES_ByWOCalc_Source
	INSERT INTO IES_ByWOCalc_Source(Building, Project, Customer, CalendarDate, BookingQty, BacklogSqft, ProductionType)
	SELECT [PLANT], RTRIM(LTRIM([PROJECT])), RTRIM(LTRIM([CUSTOMER])), [WO DATE], [BACKLOG QTY], [BACKLOG SQFT], ISNULL(RTRIM(LTRIM([PRODUCT TYPE])),'') FROM HKGNT117.Multek_ZH.dbo.[Multek_IE_WO_BACKLOG]

	--更新现有的WO数据
	--UPDATE t1 SET t1.BookingQty = t2.BookingQty, t1.BacklogSqFt = t2.BacklogSqFt
	--	FROM IES_ByWOCalc t1 INNER JOIN IES_ByWOCalc_Source t2 
	--		ON t1.Building = t2.Building
	--		AND t1.Project = t2.Project
	--		AND t1.Customer = t2.Customer
	--		AND t1.CalendarDate = t2.CalendarDate
	--		AND t1.ProductionType = t2.ProductionType
	
	UPDATE IES_ByWOCalc_Source SET QTA = 1 
		WHERE EXISTS(
			SELECT * FROM IES_QTAMaintain 
				WHERE IES_QTAMaintain.Building = IES_ByWOCalc_Source.Building 
				AND IES_QTAMaintain.Project = IES_ByWOCalc_Source.Project 
				AND IES_QTAMaintain.WoDate = IES_ByWOCalc_Source.CalendarDate)
	
	TRUNCATE TABLE IES_ByWOCalc
	
	--插入最新的WO数据
	INSERT INTO IES_ByWOCalc(Building, Project, Customer, CalendarDate, BookingQty, BacklogSqFt, Year, Month, YearWeek, ProductionType)
	SELECT t1.Building, Project, Customer, t1.CalendarDate, BookingQty, BacklogSqFt, tc.Year, tc.Month, tc.YearWeek, t1.ProductionType FROM IES_ByWOCalc_Source t1
	INNER JOIN IES_Calendar tc ON t1.CalendarDate = tc.CalendarDate AND t1.Building = tc.Building
		ORDER BY t1.CalendarDate


GO
