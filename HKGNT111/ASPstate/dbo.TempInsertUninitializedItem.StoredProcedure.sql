USE [ASPState]
GO
/****** Object:  StoredProcedure [dbo].[TempInsertUninitializedItem]    Script Date: 11/06/2014 15:58:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[TempInsertUninitializedItem]
            @id         tSessionId,
            @itemShort  tSessionItemShort,
            @timeout    int
        AS    

            DECLARE @now AS datetime
            DECLARE @nowLocal AS datetime
            
            SET @now = GETUTCDATE()
            SET @nowLocal = GETDATE()

            INSERT [tempdb].dbo.ASPStateTempSessions 
                (SessionId, 
                 SessionItemShort, 
                 Timeout, 
                 Expires, 
                 Locked, 
                 LockDate,
                 LockDateLocal,
                 LockCookie,
                 Flags) 
            VALUES 
                (@id, 
                 @itemShort, 
                 @timeout, 
                 DATEADD(n, @timeout, @now), 
                 0, 
                 @now,
                 @nowLocal,
                 1,
                 1)

            RETURN 0
GO
