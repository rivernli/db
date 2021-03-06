USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[IES_Reset_TotalCycleTime]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[IES_Reset_TotalCycleTime]
AS
	DELETE FROM IES_PJDatabase_SubCycleTime WHERE PJID IN
	(
		SELECT ID FROM IES_PJDatabase WHERE PID = 0
	)

	INSERT INTO IES_PJDatabase_SubCycleTime(PJID, PBPID, WorkCenter, CycleTime)
	SELECT T2.PID, PBPID, WorkCenter, SUM(CycleTime) FROM IES_PJDatabase_SubCycleTime T1
	INNER JOIN IES_PJDatabase T2 ON T1.PJID = T2.ID WHERE T2.PID <> 0
	GROUP BY T2.PID, PBPID, WorkCenter

	TRUNCATE TABLE IES_PJDatabase_CycleTime

	INSERT INTO IES_PJDatabase_CycleTime(PJID, PBPID, CycleTime)
	SELECT PJID, PBPID, SUM(CycleTime) FROM IES_PJDatabase_SubCycleTime T1
	GROUP BY PJID, PBPID

GO
