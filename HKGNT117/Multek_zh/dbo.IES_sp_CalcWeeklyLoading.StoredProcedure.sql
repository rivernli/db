USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[IES_sp_CalcWeeklyLoading]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IES_sp_CalcWeeklyLoading] 	
AS
	--重新同步当天MPS数据
	TRUNCATE TABLE IES_WeeklyLoading
	DECLARE @PBPID INT
	DECLARE @Building VARCHAR(10)
	DECLARE @CapacityHours DECIMAL(18, 2)
	
	DECLARE pbp_cursor CURSOR FOR 
	SELECT ID, Building,CapacityHours FROM IES_ProcessByPlant
	OPEN pbp_cursor

	FETCH NEXT FROM pbp_cursor INTO @PBPID,@Building,@CapacityHours

	WHILE @@FETCH_STATUS = 0
		BEGIN
			
			INSERT INTO IES_WeeklyLoading(LoadingType,Building,PBPID,[Year],[Month],YearWeek,CapacityHours,TotalTime)
			SELECT 'MPS',Building,@PBPID,[Year],[Month],YearWeek,@CapacityHours,
				   SUM(CASE WHEN ISNULL(Unit,0) = 0 OR ISNULL(Yield,0) = 0 THEN 0 ELSE BookingQty/Unit/Yield*CycleTime END) AS TotalTime
				   FROM (SELECT t1.BookingQty, t2.Unit, t2.Yield, t1.[Year], t1.[Month],t1.YearWeek, t1.Building, 
								ISNULL((SELECT TOP 1 CycleTime FROM IES_PJDatabase_CycleTime WHERE PJID = t2.ID AND PBPID = @PBPID),0) AS CycleTime 
							FROM IES_ByMPSCalc t1 INNER JOIN IES_PJDatabase t2 ON t1.Project = t2.Project AND t1.Building = t2.Building 
							WHERE t1.Building = @Building
						) AS t
					GROUP BY [Year],[Month],YearWeek,Building

			FETCH NEXT FROM pbp_cursor INTO @PBPID,@Building,@CapacityHours
		END 
	CLOSE pbp_cursor
	DEALLOCATE pbp_cursor
	
	
	UPDATE twl SET twl.WorkingDay = tc.WorkingDay, 
		twl.Loading = (CASE WHEN tc.WorkingDay = 0 OR twl.CapacityHours = 0 THEN 0 ELSE twl.TotalTime/tc.WorkingDay/twl.CapacityHours END)
		FROM IES_WeeklyLoading twl INNER JOIN IES_Calendar tc 
		ON twl.Building = tc.Building AND twl.[Year] = tc.[Year] AND twl.[Month] = tc.[Month] AND twl.YearWeek = tc.YearWeek

GO
