USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[IES_sp_UpdateProjectCycleTime]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IES_sp_UpdateProjectCycleTime] 	
		@PJID INT=NULL
AS

	DELETE FROM IES_PJDatabase_CycleTime WHERE PJID = @PJID
	DELETE FROM IES_PJDatabase_SubCycleTime WHERE PJID = @PJID
	INSERT INTO IES_PJDatabase_CycleTime(PJID, PBPID, CycleTime)
		SELECT @PJID, PBPID, SUM(CycleTime) CycleTime FROM IES_PJDatabase_CycleTime 
			WHERE PJID IN (SELECT ID FROM IES_PJDatabase WHERE PID = @PJID) GROUP BY PBPID
	INSERT INTO IES_PJDatabase_SubCycleTime(PJID, PBPID, WorkCenter, CycleTime)
		SELECT @PJID, PBPID, WorkCenter, SUM(CycleTime) CycleTime FROM IES_PJDatabase_SubCycleTime 
			WHERE PJID IN (SELECT ID FROM IES_PJDatabase WHERE PID = @PJID) GROUP BY PBPID, WorkCenter

GO
