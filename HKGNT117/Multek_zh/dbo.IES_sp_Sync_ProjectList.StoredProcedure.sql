USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[IES_sp_Sync_ProjectList]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[IES_sp_Sync_ProjectList] 	
AS
	INSERT INTO IES_PJDatabase(PID, Building, Project) SELECT DISTINCT 0, Building, Project 
		FROM IES_ByMSSCalc t1 WHERE NOT EXISTS (
			SELECT * FROM IES_PJDatabase t2 WHERE t1.Building = t2.Building AND t1.Project = t2.Project)
				ORDER BY Project
				
	INSERT INTO IES_PJDatabase(PID, Building, Project) SELECT DISTINCT 0, Building, Project 
		FROM IES_ByMPSCalc t1 WHERE NOT EXISTS (
			SELECT * FROM IES_PJDatabase t2 WHERE t1.Building = t2.Building AND t1.Project = t2.Project)
				ORDER BY Project
				
	INSERT INTO IES_PJDatabase(PID, Building, Project) SELECT DISTINCT 0, Building, Project 
		FROM IES_ByWOCalc t1 WHERE NOT EXISTS (
			SELECT * FROM IES_PJDatabase t2 WHERE t1.Building = t2.Building AND t1.Project = t2.Project)
				ORDER BY Project

	INSERT INTO IES_PJDatabase(PID, Building, Project) SELECT DISTINCT 0, Building, LEFT(Project, 8) 
		FROM IES_DailyOutputPnl t1 WHERE NOT EXISTS (
			SELECT * FROM IES_PJDatabase t2 WHERE t1.Building = t2.Building AND LEFT(t1.Project, 8) = t2.Project)
				ORDER BY LEFT(Project, 8)
	
	DELETE FROM IES_Yield WHERE ryie = 0

	UPDATE IES_Yield SET plnt = CASE plnt WHEN 'P1' THEN 'B1' 
	WHEN 'P2' THEN 'B1' 
	WHEN '12' THEN 'B3' 
	WHEN '2F' THEN 'B2F' ELSE plnt END
	
	UPDATE IES_project_Map_tech SET T$PLNT = CASE T$PLNT WHEN 'P1' THEN 'B1' 
	WHEN 'P2' THEN 'B1' 
	WHEN '12' THEN 'B3' 
	WHEN '2F' THEN 'B2F' ELSE T$PLNT END
	
	TRUNCATE TABLE IES_PJList_Source
	INSERT INTO IES_PJList_Source(Building, Project, SubProject, ProjectWV, Unit, Sqft)
	SELECT PLANT,LTRIM(RTRIM(T$ICOD)),T$PITM,LTRIM(RTRIM(T$PRJ1)),T$PSPL,T$SQPL FROM HKGNT117.Multek_zh.dbo.Multek_IE_ME_ProjectList
	
	UPDATE IES_PJDatabase SET ProjectWV = 
		(SELECT MAX(ProjectWV) FROM IES_PJList_Source WHERE IES_PJList_Source.Project = IES_PJDatabase.Project AND IES_PJDatabase.Building = IES_PJList_Source.Building)
		WHERE PID = 0

	UPDATE t1 SET t1.ProjectWV = t2.ProjectWV + RIGHT(t1.Project, 3)
	FROM IES_PJDataBase t1 INNER JOIN IES_PJDataBase t2 ON t1.PID = t2.ID
	WHERE t1.PID <> 0 AND LEFT(ISNULL(t1.ProjectWV, ''), 10) <> t2.ProjectWV
	
	INSERT INTO IES_AttrRateByProdType(Building, PCType)
	SELECT DISTINCT LTRIM(RTRIM(T$PLNT)) AS T$PLNT, LTRIM(RTRIM(T$TECH)) AS T$TECH 
		FROM IES_project_Map_tech t1
		WHERE T$TECH <> '' AND NOT EXISTS
		(
			SELECT * FROM IES_AttrRateByProdType t2 WHERE t1.T$PLNT = t2.Building AND t1.T$TECH = t2.PCType
		)
		ORDER BY T$PLNT, T$TECH

	UPDATE IES_PJDatabase SET Yield = NULL WHERE PID = 0

	UPDATE IES_PJDatabase SET BaanYield = (SELECT ryie FROM IES_Yield WHERE plnt = Building AND Project = pitm AND ryie <> 1) WHERE PID = 0

	UPDATE IES_PJDatabase SET Yield = CASE WHEN AdjustYield > 0  THEN AdjustYield ELSE ISNULL(BaanYield, Yield) END WHERE PID = 0

	UPDATE t0 SET t0.Yield = (1-t2.AttritionRate) FROM IES_PJDatabase t0 
		INNER JOIN IES_project_Map_tech t1 ON t0.Building = t1.T$PLNT AND t0.Project = t1.T$PJNO
		INNER JOIN IES_AttrRateByProdType t2 ON t1.T$PLNT = t2.Building AND t1.T$TECH = t2.PCType
		WHERE t0.Yield IS NULL AND t0.PID = 0

	UPDATE IES_PJDatabase SET Yield = 1 WHERE Yield IS NULL AND PID = 0

	DECLARE @ID INT
	DECLARE @Building VARCHAR(10)
	DECLARE @Project VARCHAR(50)
	
	DECLARE pjdatabase_cursor CURSOR FOR 
	SELECT ID,Building,Project FROM IES_PJDatabase WHERE PID = 0
	OPEN pjdatabase_cursor

	FETCH NEXT FROM pjdatabase_cursor INTO @ID,@Building,@Project

	WHILE @@FETCH_STATUS = 0
		BEGIN

			EXEC IES_sp_Update_ProjectUSY @ID,@Building,@Project
			FETCH NEXT FROM pjdatabase_cursor INTO @ID,@Building,@Project
		END 
	CLOSE pjdatabase_cursor
	DEALLOCATE pjdatabase_cursor


GO
