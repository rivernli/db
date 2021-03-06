USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[GlobalViewReport_sp_Query_WeeklyIncoming]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GlobalViewReport_sp_Query_WeeklyIncoming]
	-- Add the parameters for the stored procedure here
	@Plant VARCHAR(50),
	@Quarter INT=NULL,
	@Year INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
    -- Insert statements for procedure here
		SET @Quarter=ISNULL(@Quarter,1)
    	IF @Plant='B1'
		BEGIN
			SELECT 'W'+(CASE WHEN a.FiscalWeek<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),a.FiscalWeek)+'FY'+RIGHT(CONVERT(VARCHAR(4),@Year),2) AS WeekDesc,
				CONVERT(VARCHAR(10),a.FiscalWeekFrom,120)+' - '+CONVERT(VARCHAR(10),a.FiscalWeekTo,120) AS WeekRange,
				(
					SELECT ISNULL(SUM(b.T$MAMT),0)
					FROM TFSOLP121180 b
					WHERE T$DESC ='Order Intake'
						AND T$PLNT='P2'
						AND b.T$TRDT BETWEEN (CASE WHEN a.FiscalWeekFrom>CONVERT(VARCHAR(10),GETDATE(),120) THEN CONVERT(VARCHAR(10),GETDATE(),120) ELSE a.FiscalWeekFrom END) AND (CASE WHEN a.FiscalWeekTo>CONVERT(VARCHAR(10),GETDATE(),120) THEN CONVERT(VARCHAR(10),GETDATE(),120) ELSE a.FiscalWeekTo END)
				)AS Amount
			FROM Calendar a
			WHERE a.FiscalYear=@Year
				AND a.FiscalQuarter=@Quarter
				AND a.FiscalWeek<(CASE WHEN @Year=2012 AND @Quarter=3 THEN 40 ELSE a.FiscalWeek+1 END)
			GROUP BY a.FiscalWeek,a.FiscalWeekFrom,a.FiscalWeekTo
			ORDER BY a.FiscalWeek
		END
	IF @Plant='B2F'
		BEGIN
			SELECT 'W'+(CASE WHEN a.FiscalWeek<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),a.FiscalWeek)+'FY'+RIGHT(CONVERT(VARCHAR(4),@Year),2) AS WeekDesc,
				CONVERT(VARCHAR(10),a.FiscalWeekFrom,120)+' - '+CONVERT(VARCHAR(10),a.FiscalWeekTo,120) AS WeekRange,
				(
					SELECT ISNULL(SUM(b.T$MAMT),0)
					FROM TFSOLP121180 b
					WHERE T$DESC ='Order Intake'
						AND T$PLNT='2F'
						AND b.T$TRDT BETWEEN (CASE WHEN a.FiscalWeekFrom>CONVERT(VARCHAR(10),GETDATE(),120) THEN CONVERT(VARCHAR(10),GETDATE(),120) ELSE a.FiscalWeekFrom END) AND (CASE WHEN a.FiscalWeekTo>CONVERT(VARCHAR(10),GETDATE(),120) THEN CONVERT(VARCHAR(10),GETDATE(),120) ELSE a.FiscalWeekTo END)
				)AS Amount
			FROM Calendar a
			WHERE a.FiscalYear=@Year
				AND a.FiscalQuarter=@Quarter
				AND a.FiscalWeek<(CASE WHEN @Year=2012 AND @Quarter=3 THEN 40 ELSE a.FiscalWeek+1 END)
			GROUP BY a.FiscalWeek,a.FiscalWeekFrom,a.FiscalWeekTo
			ORDER BY a.FiscalWeek

		END
	IF @Plant='B3'
		BEGIN
			SELECT 'W'+(CASE WHEN a.FiscalWeek<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),a.FiscalWeek)+'FY'+RIGHT(CONVERT(VARCHAR(4),@Year),2) AS WeekDesc,
				CONVERT(VARCHAR(10),a.FiscalWeekFrom,120)+' - '+CONVERT(VARCHAR(10),a.FiscalWeekTo,120) AS WeekRange,
				(
					SELECT ISNULL(SUM(b.T$MAMT),0)
					FROM TFSOLP121180 b
					WHERE T$DESC ='Order Intake'
						AND T$PLNT='B3'
						AND b.T$TRDT BETWEEN (CASE WHEN a.FiscalWeekFrom>CONVERT(VARCHAR(10),GETDATE(),120) THEN CONVERT(VARCHAR(10),GETDATE(),120) ELSE a.FiscalWeekFrom END) AND (CASE WHEN a.FiscalWeekTo>CONVERT(VARCHAR(10),GETDATE(),120) THEN CONVERT(VARCHAR(10),GETDATE(),120) ELSE a.FiscalWeekTo END)
				)AS Amount
			FROM Calendar a
			WHERE a.FiscalYear=@Year
				AND a.FiscalQuarter=@Quarter
				AND a.FiscalWeek<(CASE WHEN @Year=2012 AND @Quarter=3 THEN 40 ELSE a.FiscalWeek+1 END)
			GROUP BY a.FiscalWeek,a.FiscalWeekFrom,a.FiscalWeekTo
			ORDER BY a.FiscalWeek

		END
	IF @Plant='B4'
		BEGIN
			SELECT 'W'+(CASE WHEN a.FiscalWeek<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),a.FiscalWeek)+'FY'+RIGHT(CONVERT(VARCHAR(4),@Year),2) AS WeekDesc,
				CONVERT(VARCHAR(10),a.FiscalWeekFrom,120)+' - '+CONVERT(VARCHAR(10),a.FiscalWeekTo,120) AS WeekRange,
				(
					SELECT ISNULL(SUM(b.T$MAMT),0)
					FROM TFSOLP121180 b
					WHERE T$DESC ='Order Intake'
						AND T$PLNT='B4'
						AND b.T$TRDT BETWEEN (CASE WHEN a.FiscalWeekFrom>CONVERT(VARCHAR(10),GETDATE(),120) THEN CONVERT(VARCHAR(10),GETDATE(),120) ELSE a.FiscalWeekFrom END) AND (CASE WHEN a.FiscalWeekTo>CONVERT(VARCHAR(10),GETDATE(),120) THEN CONVERT(VARCHAR(10),GETDATE(),120) ELSE a.FiscalWeekTo END)
				)AS Amount
			FROM Calendar a
			WHERE a.FiscalYear=@Year
				AND a.FiscalQuarter=@Quarter
				AND a.FiscalWeek<(CASE WHEN @Year=2012 AND @Quarter=3 THEN 40 ELSE a.FiscalWeek+1 END)
			GROUP BY a.FiscalWeek,a.FiscalWeekFrom,a.FiscalWeekTo
			ORDER BY a.FiscalWeek

		END
	IF @Plant='B5'
		BEGIN
			SELECT 'W'+(CASE WHEN a.FiscalWeek<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),a.FiscalWeek)+'FY'+RIGHT(CONVERT(VARCHAR(4),@Year),2) AS WeekDesc,
				CONVERT(VARCHAR(10),a.FiscalWeekFrom,120)+' - '+CONVERT(VARCHAR(10),a.FiscalWeekTo,120) AS WeekRange,
				(
					SELECT ISNULL(SUM(b.T$MAMT),0)
					FROM TFSOLP121180 b
					WHERE T$DESC ='Order Intake'
						AND T$PLNT='B5'
						AND b.T$TRDT BETWEEN (CASE WHEN a.FiscalWeekFrom>CONVERT(VARCHAR(10),GETDATE(),120) THEN CONVERT(VARCHAR(10),GETDATE(),120) ELSE a.FiscalWeekFrom END) AND (CASE WHEN a.FiscalWeekTo>CONVERT(VARCHAR(10),GETDATE(),120) THEN CONVERT(VARCHAR(10),GETDATE(),120) ELSE a.FiscalWeekTo END)
				)AS Amount
			FROM Calendar a
			WHERE a.FiscalYear=@Year
				AND a.FiscalQuarter=@Quarter
				AND a.FiscalWeek<(CASE WHEN @Year=2012 AND @Quarter=3 THEN 40 ELSE a.FiscalWeek+1 END)
			GROUP BY a.FiscalWeek,a.FiscalWeekFrom,a.FiscalWeekTo
			ORDER BY a.FiscalWeek

		END
	IF @Plant='VVI'
		BEGIN
			SELECT 'W'+(CASE WHEN a.FiscalWeek<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),a.FiscalWeek)+'FY'+RIGHT(CONVERT(VARCHAR(4),@Year),2) AS WeekDesc,
				CONVERT(VARCHAR(10),a.FiscalWeekFrom,120)+' - '+CONVERT(VARCHAR(10),a.FiscalWeekTo,120) AS WeekRange,
				(
					SELECT ISNULL(SUM(b.T$MAMT),0)
					FROM TFSOLP121180 b
					WHERE T$DESC ='Order Intake'
						AND T$PLNT='HK'
						AND T$COTP IN ('SLT','CLT')
						AND b.T$TRDT BETWEEN (CASE WHEN a.FiscalWeekFrom>CONVERT(VARCHAR(10),GETDATE(),120) THEN CONVERT(VARCHAR(10),GETDATE(),120) ELSE a.FiscalWeekFrom END) AND (CASE WHEN a.FiscalWeekTo>CONVERT(VARCHAR(10),GETDATE(),120) THEN CONVERT(VARCHAR(10),GETDATE(),120) ELSE a.FiscalWeekTo END)
				)AS Amount
			FROM Calendar a
			WHERE a.FiscalYear=@Year
				AND a.FiscalQuarter=@Quarter
				AND a.FiscalWeek<(CASE WHEN @Year=2012 AND @Quarter=3 THEN 40 ELSE a.FiscalWeek+1 END)
			GROUP BY a.FiscalWeek,a.FiscalWeekFrom,a.FiscalWeekTo
			ORDER BY a.FiscalWeek

		END
	IF @Plant='SUB'
		BEGIN
			SELECT 'W'+(CASE WHEN a.FiscalWeek<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),a.FiscalWeek)+'FY'+RIGHT(CONVERT(VARCHAR(4),@Year),2) AS WeekDesc,
				CONVERT(VARCHAR(10),a.FiscalWeekFrom,120)+' - '+CONVERT(VARCHAR(10),a.FiscalWeekTo,120) AS WeekRange,
				(
					SELECT ISNULL(SUM(b.T$MAMT),0)
					FROM TFSOLP121180 b
					WHERE T$DESC ='Order Intake'
						AND T$PLNT='HK'
						AND T$COTP IN ('SLS','CNG','BFS')
						AND b.T$TRDT BETWEEN (CASE WHEN a.FiscalWeekFrom>CONVERT(VARCHAR(10),GETDATE(),120) THEN CONVERT(VARCHAR(10),GETDATE(),120) ELSE a.FiscalWeekFrom END) AND (CASE WHEN a.FiscalWeekTo>CONVERT(VARCHAR(10),GETDATE(),120) THEN CONVERT(VARCHAR(10),GETDATE(),120) ELSE a.FiscalWeekTo END)
				)AS Amount
			FROM Calendar a
			WHERE a.FiscalYear=@Year
				AND a.FiscalQuarter=@Quarter
				AND a.FiscalWeek<(CASE WHEN @Year=2012 AND @Quarter=3 THEN 40 ELSE a.FiscalWeek+1 END)
			GROUP BY a.FiscalWeek,a.FiscalWeekFrom,a.FiscalWeekTo
			ORDER BY a.FiscalWeek

		END
	IF @Plant='Total'
		BEGIN
			SELECT 'W'+(CASE WHEN a.FiscalWeek<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),a.FiscalWeek)+'FY'+RIGHT(CONVERT(VARCHAR(4),@Year),2) AS WeekDesc,
				CONVERT(VARCHAR(10),a.FiscalWeekFrom,120)+' - '+CONVERT(VARCHAR(10),a.FiscalWeekTo,120) AS WeekRange,
				(
					SELECT ISNULL(SUM(b.T$MAMT),0)
					FROM TFSOLP121180 b
					WHERE T$DESC ='Order Intake'
						--AND T$PLNT='HK'
						--AND T$COTP IN ('SLS','CNG','BFS')
						AND b.T$TRDT BETWEEN (CASE WHEN a.FiscalWeekFrom>CONVERT(VARCHAR(10),GETDATE(),120) THEN CONVERT(VARCHAR(10),GETDATE(),120) ELSE a.FiscalWeekFrom END) AND (CASE WHEN a.FiscalWeekTo>CONVERT(VARCHAR(10),GETDATE(),120) THEN CONVERT(VARCHAR(10),GETDATE(),120) ELSE a.FiscalWeekTo END)
				)AS Amount
			FROM Calendar a
			WHERE a.FiscalYear=@Year
				AND a.FiscalQuarter=@Quarter
				AND a.FiscalWeek<(CASE WHEN @Year=2012 AND @Quarter=3 THEN 40 ELSE a.FiscalWeek+1 END)
			GROUP BY a.FiscalWeek,a.FiscalWeekFrom,a.FiscalWeekTo
			ORDER BY a.FiscalWeek
					
		END
	IF @Plant='ZhuHaiEXB2F'
		BEGIN
			SELECT 'W'+(CASE WHEN a.FiscalWeek<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),a.FiscalWeek)+'FY'+RIGHT(CONVERT(VARCHAR(4),@Year),2) AS WeekDesc,
				CONVERT(VARCHAR(10),a.FiscalWeekFrom,120)+' - '+CONVERT(VARCHAR(10),a.FiscalWeekTo,120) AS WeekRange,
				(
					SELECT ISNULL(SUM(b.T$MAMT),0)
					FROM TFSOLP121180 b
					WHERE T$DESC ='Order Intake'
						AND T$PLNT<>'2F'
						AND b.T$TRDT BETWEEN (CASE WHEN a.FiscalWeekFrom>CONVERT(VARCHAR(10),GETDATE(),120) THEN CONVERT(VARCHAR(10),GETDATE(),120) ELSE a.FiscalWeekFrom END) AND (CASE WHEN a.FiscalWeekTo>CONVERT(VARCHAR(10),GETDATE(),120) THEN CONVERT(VARCHAR(10),GETDATE(),120) ELSE a.FiscalWeekTo END)
				)AS Amount
			FROM Calendar a
			WHERE a.FiscalYear=@Year
				AND a.FiscalQuarter=@Quarter
				AND a.FiscalWeek<(CASE WHEN @Year=2012 AND @Quarter=3 THEN 40 ELSE a.FiscalWeek+1 END)
			GROUP BY a.FiscalWeek,a.FiscalWeekFrom,a.FiscalWeekTo
			ORDER BY a.FiscalWeek
					
		END
END
GO
