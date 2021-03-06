USE [ASPState]
GO
/****** Object:  StoredProcedure [dbo].[TempResetTimeout]    Script Date: 11/06/2014 15:58:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[TempResetTimeout]
            @id     tSessionId
        AS
            UPDATE [tempdb].dbo.ASPStateTempSessions
            SET Expires = DATEADD(n, Timeout, GETUTCDATE())
            WHERE SessionId = @id
            RETURN 0
GO
