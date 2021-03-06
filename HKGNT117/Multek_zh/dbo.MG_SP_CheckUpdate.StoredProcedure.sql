USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[MG_SP_CheckUpdate]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[MG_SP_CheckUpdate] 

AS
BEGIN
	DECLARE @mi INT
	SELECT @mi = MAX(DATEDIFF(mi, UpdataTime, GETDATE())) FROM SS_Server
	IF @mi > 30
		BEGIN
			EXEC MG_SP_Send_Mail @To='Arno.Feng@hk.multek.com', @Subject='117_SS_Stoped', @Body='117_SS_Stoped'
			exec xp_cmdshell 'Net Stop ServerSurveillanceService'
			exec xp_cmdshell 'Net Start ServerSurveillanceService'
		END
END
GO
