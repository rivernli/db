USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[IES_sp_Import_Calendar]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IES_sp_Import_Calendar] 	
		@FILEPATH VARCHAR(1000)
AS

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[IES_Calendar_Temp]') AND type in (N'U'))
	BEGIN
		DROP TABLE [IES_Calendar_Temp]
	END

DECLARE @SQLSTR VARCHAR(2000)
SET @SQLSTR = 'SELECT *, CAST(WODate AS DateTime) AS CalendarDate, YEAR(CAST(WODate AS DateTime)) AS Year INTO IES_Calendar_Temp FROM OPENROWSET(''MICROSOFT.JET.OLEDB.4.0'',''Excel 8.0;HDR=YES;DATABASE='+@FILEPATH+''',''SELECT * FROM [Calendar$]'')'
EXEC(@SQLSTR)

DELETE FROM IES_Calendar_Temp WHERE WODate IS NULL 

DECLARE @Building VARCHAR(50)
DECLARE @MaxDate DATETIME
DECLARE @MinDate DATETIME

SELECT @MaxDate=MAX(WODate),@MinDate=MIN(WODate) FROM IES_Calendar_Temp

UPDATE IES_Calendar_Temp 
	SET IES_Calendar_Temp.WorkingDay = 
		ISNULL(
			(SELECT TOP 1 it.WorkingDay FROM IES_Calendar_Temp it 
				WHERE it.[Year] = IES_Calendar_Temp.[Year] 
					AND it.YearWeek = IES_Calendar_Temp.YearWeek 
					AND it.WorkingDay IS NOT NULL), 
			(SELECT TOP 1 tt.WorkingDay FROM IES_Calendar_Temp tt 
				WHERE tt.[Year] = (IES_Calendar_Temp.[Year] - 1)
					AND MONTH(tt.CalendarDate) = 12
					AND tt.YearWeek = IES_Calendar_Temp.YearWeek 
					AND tt.WorkingDay IS NOT NULL))
	WHERE IES_Calendar_Temp.WorkingDay IS NULL
	


DECLARE building_cursor CURSOR FOR 
	SELECT Building FROM IES_Building ORDER BY Building
OPEN building_cursor

FETCH NEXT FROM building_cursor INTO @Building

WHILE @@FETCH_STATUS = 0
	BEGIN
		
		DELETE FROM IES_Calendar WHERE [CalendarDate] <= @MaxDate AND [CalendarDate] >= @MinDate AND [Building] = @Building
		
		INSERT INTO IES_Calendar([Building],[CalendarDate],[WODate],[Year],[Month],[Quarter],[YearWeek],[Date],[FinWeek],[WorkingDay])
			SELECT b.[Building], c.[CalendarDate], CONVERT(VARCHAR(12), c.[CalendarDate], 111), CASE WHEN Month(c.CalendarDate) = 12 AND c.Month = 1 THEN c.[Year] + 1 WHEN Month(c.CalendarDate) = 1 AND c.Month = 12 THEN c.[Year] - 1 ELSE c.[Year] END, c.[Month], 
				CASE WHEN c.Month < 4 THEN 4 ELSE DATEPART(QUARTER, c.[CalendarDate]) - 1 END, c.[YearWeek], DATEPART(DAYOFYEAR, c.[CalendarDate]), c.[FinWeek],
				c.[WorkingDay] FROM IES_Building b, IES_Calendar_Temp c 
					WHERE b.[Building] = @Building 
						AND c.[CalendarDate] > ISNULL(
							(
								SELECT MAX([CalendarDate]) FROM IES_Calendar 
									WHERE [Building] = @Building), CAST('1900-01-01' AS DATETIME)
							)
		FETCH NEXT FROM building_cursor INTO @Building
	END 
CLOSE building_cursor
DEALLOCATE building_cursor

DROP TABLE IES_Calendar_Temp

GO
