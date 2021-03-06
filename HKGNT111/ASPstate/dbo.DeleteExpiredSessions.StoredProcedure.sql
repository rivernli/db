USE [ASPState]
GO
/****** Object:  StoredProcedure [dbo].[DeleteExpiredSessions]    Script Date: 11/06/2014 15:58:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DeleteExpiredSessions]
        AS
            DECLARE @now datetime
            SET @now = GETUTCDATE()

            DELETE [tempdb].dbo.ASPStateTempSessions
            WHERE Expires < @now

            RETURN 0
GO
