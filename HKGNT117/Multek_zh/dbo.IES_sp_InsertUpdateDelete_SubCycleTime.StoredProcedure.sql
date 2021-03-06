USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[IES_sp_InsertUpdateDelete_SubCycleTime]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

    
    
CREATE PROCEDURE [dbo].[IES_sp_InsertUpdateDelete_SubCycleTime] 	
		@PJID INT=NULL,
		@PID INT=NULL,
		@PBPID INT=NULL,
		@WorkCenter VARCHAR(20),
		@CycleTime DECIMAL(18, 4)
AS
	INSERT INTO IES_PJDatabase_SubCycleTime(PJID, PBPID, WorkCenter, CycleTime) VALUES(@PJID, @PBPID, @WorkCenter, @CycleTime)
	
    IF NOT EXISTS(SELECT * FROM IES_PJDatabase_SubCycleTime WHERE PJID = @PID AND PBPID = @PBPID AND WorkCenter = @WorkCenter) 
		INSERT INTO IES_PJDatabase_SubCycleTime(PJID, PBPID, WorkCenter, CycleTime) VALUES(@PID, @PBPID, @WorkCenter, 0)
		
    --INSERT INTO IES_PJDatabase_CycleTime(PJID, PBPID, CycleTime) VALUES(@PJID, @PBPID, @CycleTime)
	
	--IF @CycleTime > 0
		UPDATE IES_PJDatabase_SubCycleTime SET CycleTime = 
			(SELECT SUM(t1.CycleTime) FROM IES_PJDatabase_SubCycleTime t1
				INNER JOIN IES_PJDatabase t2 ON t1.PJID = t2.ID
				WHERE t1.PBPID = @PBPID AND t1.WorkCenter = @WorkCenter AND t2.PID = @PID)
		WHERE PJID = @PID AND PBPID = @PBPID AND WorkCenter = @WorkCenter


GO
