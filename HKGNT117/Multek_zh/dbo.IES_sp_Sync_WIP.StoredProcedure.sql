USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[IES_sp_Sync_WIP]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IES_sp_Sync_WIP] 	
	@OutputDate DATETIME=NULL
AS
	DECLARE @Building VARCHAR(50),@Project VARCHAR(50),@WOC VARCHAR(30),@Output DECIMAL(18, 2),@Month INT,@YearWeek INT
	DECLARE @PJID INT, @PBPID INT, @PJBuilding VARCHAR(50), @PJProject VARCHAR(50)
	TRUNCATE TABLE IES_WIP_Source
	INSERT INTO IES_WIP_Source(Building,Project,OutputDate,WOC,Output)
		SELECT CASE T$PLNT WHEN 'P1' THEN 'B1' 
			WHEN 'P2' THEN 'B1' 
			WHEN '12' THEN 'B3' 
			WHEN '2F' THEN 'B2F' 
			ELSE T$PLNT END,
			LEFT(LTRIM(RTRIM([T$PITM])), 8) + RIGHT(LTRIM(RTRIM([T$PITM])), 3),
			[T$DTAT],LTRIM(RTRIM([T$CWOC])),[T$QTYA]
		FROM [HKGNT117].[Multek_ZH].[dbo].[TFSOLP130180]
		
		WHERE [T$DTAT] = @OutputDate
	
	DELETE FROM IES_DailyOutputPnl_SubOutput WHERE PJID IN(SELECT ID FROM IES_DailyOutputPnl WHERE OutputDate = @OutputDate)
	DELETE FROM IES_DailyOutputPnl_Output WHERE PJID IN(SELECT ID FROM IES_DailyOutputPnl WHERE OutputDate = @OutputDate)
	DELETE FROM IES_DailyOutputPnl WHERE OutputDate = @OutputDate
	
	DECLARE wip_cursor CURSOR FOR 
	SELECT t1.Building,t1.Project,t1.WOC,SUM(t1.Output) AS Output,t2.[Month], t2.YearWeek FROM IES_WIP_Source t1
		INNER JOIN IES_Calendar t2 ON t1.Building = t2.Building AND t1.OutputDate = t2.CalendarDate
		GROUP BY t1.Building,t1.Project,t1.WOC,t2.[Month],t2.YearWeek
		ORDER BY t1.Building,t1.Project
	OPEN wip_cursor

	FETCH NEXT FROM wip_cursor INTO @Building,@Project,@WOC,@Output,@Month,@YearWeek

	WHILE @@FETCH_STATUS = 0
		BEGIN
			DECLARE pbp_cursor CURSOR FOR 
				SELECT ID FROM IES_ProcessByPlant 
								WHERE Building = @Building 
								AND CHARINDEX(',' + @WOC + ',', ',' + BaanWorkCenter + ',') > 0
			OPEN pbp_cursor
			FETCH NEXT FROM pbp_cursor INTO @PBPID
			WHILE @@FETCH_STATUS = 0
				BEGIN
					IF @PBPID IS NOT NULL
						BEGIN
							IF NOT (ISNULL(@PJBuilding,'') = @Building AND ISNULL(@PjProject,'') = @Project)
								BEGIN
									INSERT INTO IES_DailyOutputPnl(Building, Project, OutputDate, [Month], YearWeek)
										VALUES(@Building,@Project,@OutputDate,@Month,@YearWeek)
									SELECT @PJID = @@IDENTITY
									SET @PJBuilding = @Building
									SET @PjProject = @Project
								END
							INSERT INTO IES_DailyOutputPnl_Output(PJID, PBPID, Output) VALUES(@PJID, @PBPID, @Output)
							INSERT INTO IES_DailyOutputPnl_SubOutput(PJID, PBPID, WorkCenter, Output) VALUES(@PJID, @PBPID, @WOC, @Output)
						END
					FETCH NEXT FROM pbp_cursor INTO @PBPID
				END
			
			CLOSE pbp_cursor
			DEALLOCATE pbp_cursor
				
			FETCH NEXT FROM wip_cursor INTO @Building,@Project,@WOC,@Output,@Month,@YearWeek
		END 
	CLOSE wip_cursor
	DEALLOCATE wip_cursor

GO
