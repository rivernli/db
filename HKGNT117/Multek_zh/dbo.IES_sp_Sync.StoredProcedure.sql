USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[IES_sp_Sync]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[IES_sp_Sync] 	
AS
	DELETE FROM dbo.IES_DailyOutputPnl_SubOutput WHERE PJID IN(
		SELECT ID FROM dbo.IES_DailyOutputPnl WHERE OutputDate < DATEADD(year, -1, getdate())
	)

	DELETE FROM dbo.IES_DailyOutputPnl_Output WHERE PJID IN(
		SELECT ID FROM dbo.IES_DailyOutputPnl WHERE OutputDate < DATEADD(year, -1, getdate())
	)

	DELETE FROM dbo.IES_DailyOutputPnl WHERE OutputDate < DATEADD(year, -1, getdate())
	
	DELETE FROM dbo.IES_DailyOutputSC_SubOutput WHERE PJID IN(
		SELECT ID FROM dbo.IES_DailyOutputSC WHERE OutputDate < DATEADD(year, -1, getdate())
	)

	DELETE FROM dbo.IES_DailyOutputSC WHERE OutputDate < DATEADD(year, -1, getdate())

	EXEC [IES_sp_Sync_WO_Calc]
	EXEC [IES_sp_Sync_MPS_Calc]
	EXEC [IES_sp_Sync_MSS_Calc]
	EXEC [IES_sp_CalcWeeklyLoading]

	DECLARE @MailBody VARCHAR(MAX)
	SET @MailBody = ''

	IF NOT EXISTS(SELECT * FROM IES_ByWoCalc) 
		SET @MailBody = @MailBody + '<br>Can not find any WO Data(Multek_IE_WO_BACKLOG,TFSCPP253180,TTCMCS044180,TFIATT006180,TTIITM001180)'
	IF NOT EXISTS(SELECT * FROM IES_ByMPSCalc) 
		SET @MailBody = @MailBody + '<br>Can not find any MPS Data(TFSOLP125180)'
	IF NOT EXISTS(SELECT * FROM IES_ByMSSCalc) 
		SET @MailBody = @MailBody + '<br>Can not find any MSS Data(TFSOLP122180)'

	INSERT INTO IES_DailyOutputEmpty SELECT CONVERT(VARCHAR(10), DATEADD(d, -1, GETDATE()), 101)

	DECLARE @OutputDate DATETIME
	DECLARE @SourceCount INT
	DECLARE doe_cursor CURSOR FOR 
		SELECT ImportData FROM IES_DailyOutputEmpty
	OPEN doe_cursor

	FETCH NEXT FROM doe_cursor INTO @OutputDate

	WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @SourceCount = COUNT(*) FROM [HKGNT117].[Multek_ZH].[dbo].[TFSOLP130180] WHERE [T$DTAT] = @OutputDate

			IF @SourceCount > 0
				BEGIN
					EXEC [IES_sp_Sync_WIP] @OutputDate
					DELETE FROM IES_DailyOutputEmpty WHERE ImportData = @OutputDate
				END
			ELSE 
				BEGIN
					IF NOT EXISTS(SELECT * FROM IES_DailyOutputEmpty WHERE ImportData = @OutputDate)
						INSERT INTO IES_DailyOutputEmpty SELECT @OutputDate
					SET @MailBody = @MailBody + '<br>Can not find any WIP Data on ' + CONVERT(VARCHAR(12), DATEADD(d, -1, GETDATE()), 101) + '(TFSOLP130180)'
				END
			FETCH NEXT FROM doe_cursor INTO @OutputDate
		END 
	CLOSE doe_cursor
	DEALLOCATE doe_cursor

	IF @MailBody <> ''
		EXEC MG_SP_Send_Mail @To='Arno.Feng@hk.multek.com',@Subject='IESys Sync Error', @Body=@MailBody

	EXEC [IES_sp_Sync_ProjectList]
	EXEC [IES_sp_Sync_IES_FlowData]
	EXEC [IES_sp_Sync_PPS]
	EXEC [IES_sp_Sync_HC]


GO
