USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[GlobalViewReport_sp_Query_WeeklyIncoming_bak]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GlobalViewReport_sp_Query_WeeklyIncoming_bak]
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
					SELECT ISNULL(SUM(T$PB12),0) 
					FROM TFSOLP119180 b
					WHERE b.T$ODAT BETWEEN (CASE WHEN a.FiscalWeekFrom>CONVERT(VARCHAR(10),GETDATE(),120) THEN CONVERT(VARCHAR(10),GETDATE(),120) ELSE a.FiscalWeekFrom END) AND (CASE WHEN a.FiscalWeekTo>CONVERT(VARCHAR(10),GETDATE(),120) THEN CONVERT(VARCHAR(10),GETDATE(),120) ELSE a.FiscalWeekTo END)
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
					SELECT ISNULL(SUM(T$B2F),0) 
					FROM TFSOLP119180 b
					WHERE b.T$ODAT BETWEEN (CASE WHEN a.FiscalWeekFrom>CONVERT(VARCHAR(10),GETDATE(),120) THEN CONVERT(VARCHAR(10),GETDATE(),120) ELSE a.FiscalWeekFrom END) AND (CASE WHEN a.FiscalWeekTo>CONVERT(VARCHAR(10),GETDATE(),120) THEN CONVERT(VARCHAR(10),GETDATE(),120) ELSE a.FiscalWeekTo END)
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
					SELECT ISNULL(SUM(T$PB3),0) 
					FROM TFSOLP119180 b
					WHERE b.T$ODAT BETWEEN (CASE WHEN a.FiscalWeekFrom>CONVERT(VARCHAR(10),GETDATE(),120) THEN CONVERT(VARCHAR(10),GETDATE(),120) ELSE a.FiscalWeekFrom END) AND (CASE WHEN a.FiscalWeekTo>CONVERT(VARCHAR(10),GETDATE(),120) THEN CONVERT(VARCHAR(10),GETDATE(),120) ELSE a.FiscalWeekTo END)
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
					SELECT ISNULL(SUM(T$PB4),0) 
					FROM TFSOLP119180 b
					WHERE b.T$ODAT BETWEEN (CASE WHEN a.FiscalWeekFrom>CONVERT(VARCHAR(10),GETDATE(),120) THEN CONVERT(VARCHAR(10),GETDATE(),120) ELSE a.FiscalWeekFrom END) AND (CASE WHEN a.FiscalWeekTo>CONVERT(VARCHAR(10),GETDATE(),120) THEN CONVERT(VARCHAR(10),GETDATE(),120) ELSE a.FiscalWeekTo END)
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
					SELECT ISNULL(SUM(T$PB5),0) 
					FROM TFSOLP119180 b
					WHERE b.T$ODAT BETWEEN (CASE WHEN a.FiscalWeekFrom>CONVERT(VARCHAR(10),GETDATE(),120) THEN CONVERT(VARCHAR(10),GETDATE(),120) ELSE a.FiscalWeekFrom END) AND (CASE WHEN a.FiscalWeekTo>CONVERT(VARCHAR(10),GETDATE(),120) THEN CONVERT(VARCHAR(10),GETDATE(),120) ELSE a.FiscalWeekTo END)
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
					SELECT ISNULL(SUM(T$SUB1),0) 
					FROM TFSOLP119180 b
					WHERE b.T$ODAT BETWEEN (CASE WHEN a.FiscalWeekFrom>CONVERT(VARCHAR(10),GETDATE(),120) THEN CONVERT(VARCHAR(10),GETDATE(),120) ELSE a.FiscalWeekFrom END) AND (CASE WHEN a.FiscalWeekTo>CONVERT(VARCHAR(10),GETDATE(),120) THEN CONVERT(VARCHAR(10),GETDATE(),120) ELSE a.FiscalWeekTo END)
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
					SELECT ISNULL(SUM(T$SUB2),0) 
					FROM TFSOLP119180 b
					WHERE b.T$ODAT BETWEEN (CASE WHEN a.FiscalWeekFrom>CONVERT(VARCHAR(10),GETDATE(),120) THEN CONVERT(VARCHAR(10),GETDATE(),120) ELSE a.FiscalWeekFrom END) AND (CASE WHEN a.FiscalWeekTo>CONVERT(VARCHAR(10),GETDATE(),120) THEN CONVERT(VARCHAR(10),GETDATE(),120) ELSE a.FiscalWeekTo END)
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
					SELECT ISNULL(SUM(T$PB12),0)+
						  ISNULL(SUM(T$B2F),0)+
						  ISNULL(SUM(T$PB3),0)+
						  ISNULL(SUM(T$PB4),0)+
						  ISNULL(SUM(T$PB5),0)+
						  ISNULL(SUM(T$SUB1),0)+
						  ISNULL(SUM(T$SUB2),0)
					FROM TFSOLP119180 b
					WHERE b.T$ODAT BETWEEN (CASE WHEN a.FiscalWeekFrom>CONVERT(VARCHAR(10),GETDATE(),120) THEN CONVERT(VARCHAR(10),GETDATE(),120) ELSE a.FiscalWeekFrom END) AND (CASE WHEN a.FiscalWeekTo>CONVERT(VARCHAR(10),GETDATE(),120) THEN CONVERT(VARCHAR(10),GETDATE(),120) ELSE a.FiscalWeekTo END)
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
					SELECT ISNULL(SUM(T$PB12),0)+
						  --ISNULL(SUM(T$B2F),0)+
						  ISNULL(SUM(T$PB3),0)+
						  ISNULL(SUM(T$PB4),0)+
						  ISNULL(SUM(T$PB5),0)+
						  ISNULL(SUM(T$SUB1),0)+
						  ISNULL(SUM(T$SUB2),0)
					FROM TFSOLP119180 b
					WHERE b.T$ODAT BETWEEN (CASE WHEN a.FiscalWeekFrom>CONVERT(VARCHAR(10),GETDATE(),120) THEN CONVERT(VARCHAR(10),GETDATE(),120) ELSE a.FiscalWeekFrom END) AND (CASE WHEN a.FiscalWeekTo>CONVERT(VARCHAR(10),GETDATE(),120) THEN CONVERT(VARCHAR(10),GETDATE(),120) ELSE a.FiscalWeekTo END)
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
