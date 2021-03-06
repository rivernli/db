USE [ASPState]
GO
/****** Object:  StoredProcedure [dbo].[TempRemoveStateItem]    Script Date: 11/06/2014 15:58:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[TempRemoveStateItem]
        @id     tSessionId,
        @lockCookie int
    AS
        DELETE [tempdb].dbo.ASPStateTempSessions
        WHERE SessionId = @id AND LockCookie = @lockCookie
        RETURN 0
GO
