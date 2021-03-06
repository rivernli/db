USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[IES_sp_Sync_MPS_Calc]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IES_sp_Sync_MPS_Calc] 	
AS
	--重新同步当天MPS数据
	TRUNCATE TABLE IES_ByMPSCalc_Source
	INSERT INTO IES_ByMPSCalc_Source(Building, Project, Customer, CalendarDate, BookingQty, BacklogSqft)
	SELECT T$PLNT, CASE WHEN LEN(RTRIM(LTRIM(T$ITEM))) > 8 THEN SUBSTRING(RTRIM(LTRIM(T$ITEM)), 5, 8) ELSE RTRIM(LTRIM(T$ITEM)) END, T$DSCA, T$WODT, T$OUUA, T$SQFT FROM HKGNT117.Multek_ZH.dbo.[Multek_IE_MPS_Calc]

	--更新现有的MPS数据
	--UPDATE t1 SET t1.BookingQty = t2.BookingQty, t1.BacklogSqFt = t2.BacklogSqFt 
	--	FROM IES_ByMPSCalc t1 INNER JOIN IES_ByMPSCalc_Source t2 
	--		ON t1.Building = t2.Building
	--		AND t1.Project = t2.Project
	--		AND t1.Customer = t2.Customer
	--		AND t1.CalendarDate = t2.CalendarDate
	
	-- 删除旧的MPS数据
	TRUNCATE TABLE IES_ByMPSCalc
	
	--插入最新的MPS数据
	INSERT INTO IES_ByMPSCalc(Building, Project, Customer, CalendarDate, BookingQty, BacklogSqFt, Year, Month, YearWeek)
	SELECT t1.Building, Project, Customer, t1.CalendarDate, BookingQty, BacklogSqFt, tc.Year, tc.Month, tc.YearWeek FROM IES_ByMPSCalc_Source t1
	INNER JOIN IES_Calendar tc ON t1.CalendarDate = tc.CalendarDate AND t1.Building = tc.Building
	WHERE NOT EXISTS(SELECT * FROM IES_ByMPSCalc t2 
		WHERE t1.Building = t2.Building
			AND t1.Project = t2.Project
			AND t1.Customer = t2.Customer
			AND t1.CalendarDate = t2.CalendarDate)
		ORDER BY t1.CalendarDate

GO
