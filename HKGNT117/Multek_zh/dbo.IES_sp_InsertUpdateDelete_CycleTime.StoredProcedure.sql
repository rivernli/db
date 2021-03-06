USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[IES_sp_InsertUpdateDelete_CycleTime]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IES_sp_InsertUpdateDelete_CycleTime] 	
		@PJID INT=NULL,
		@PID INT=NULL,
		@PBPID INT=NULL,
		@CycleTime DECIMAL(18, 4)
AS
	DELETE FROM IES_PJDatabase_CycleTime WHERE PJID = @PJID AND PBPID=@PBPID
	DELETE FROM IES_PJDatabase_SubCycleTime WHERE PJID = @PJID AND PBPID=@PBPID
	
    IF NOT EXISTS(SELECT * FROM IES_PJDatabase_CycleTime WHERE PJID = @PID AND PBPID = @PBPID) 
		INSERT INTO IES_PJDatabase_CycleTime(PJID, PBPID, CycleTime) VALUES(@PID, @PBPID, 0)
                                    
    INSERT INTO IES_PJDatabase_CycleTime(PJID, PBPID, CycleTime) VALUES(@PJID, @PBPID, @CycleTime)
    
    --IF @CycleTime > 0
		UPDATE IES_PJDatabase_CycleTime SET CycleTime = 
			(SELECT SUM(CycleTime) FROM IES_PJDatabase_CycleTime t1 
				INNER JOIN IES_PJDatabase t2 ON t1.PJID = t2.ID 
				WHERE t1.PBPID = @PBPID AND t2.PID = @PID) 
		WHERE PJID = @PID AND PBPID = @PBPID


GO
