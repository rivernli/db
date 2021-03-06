USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[IES_sp_Sync_MSS_Calc]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IES_sp_Sync_MSS_Calc] 	
AS
	--重新同步当天MSS数据
	TRUNCATE TABLE IES_ByMSSCalc_Source
	INSERT INTO IES_ByMSSCalc_Source(Building, Project, Customer, CalendarDate, BookingQty, BacklogSqft)
	SELECT T$PLNT, CASE WHEN LEN(RTRIM(LTRIM(T$ITEM))) > 8 THEN SUBSTRING(RTRIM(LTRIM(T$ITEM)), 5, 8) ELSE RTRIM(LTRIM(T$ITEM)) END, T$DSCA, T$PDAT, T$AUA, T$ASQ FROM HKGNT117.Multek_ZH.dbo.[Multek_IE_MSS_Calc]

	--更新现有的MSS数据
	--UPDATE t1 SET t1.BookingQty = t2.BookingQty, t1.BacklogSqFt = t2.BacklogSqFt 
	--	FROM IES_ByMSSCalc t1 INNER JOIN IES_ByMSSCalc_Source t2 
	--		ON t1.Building = t2.Building
	--		AND t1.Project = t2.Project
	--		AND t1.Customer = t2.Customer
	--		AND t1.CalendarDate = t2.CalendarDate
	
	-- 删除旧的MSS数据
	TRUNCATE TABLE IES_ByMSSCalc
	
	--插入最新的MSS数据
	INSERT INTO IES_ByMSSCalc(Building, Project, Customer, CalendarDate, BookingQty, BacklogSqFt, Year, Month, YearWeek)
	SELECT t1.Building, Project, Customer, t1.CalendarDate, BookingQty, BacklogSqFt, tc.Year, tc.Month, tc.YearWeek FROM IES_ByMSSCalc_Source t1
	INNER JOIN IES_Calendar tc ON t1.CalendarDate = tc.CalendarDate AND t1.Building = tc.Building
	WHERE NOT EXISTS(SELECT * FROM IES_ByMSSCalc t2 
		WHERE t1.Building = t2.Building
			AND t1.Project = t2.Project
			AND t1.Customer = t2.Customer
			AND t1.CalendarDate = t2.CalendarDate)
		ORDER BY t1.CalendarDate

GO
