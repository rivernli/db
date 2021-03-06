USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[GlobalViewReport_sp_Automatically_Process_B2B]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GlobalViewReport_sp_Automatically_Process_B2B]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    DECLARE @FiscalYear VARCHAR(4),@FiscalWeek INT,@FiscalWeekDesc VARCHAR(50),@FiscalWeekFrom DATE,@FiscalWeekTo DATE,@ReportCode VARCHAR(3),@Plant VARCHAR(10),@Amount NUMERIC(18,2),@SQLString VARCHAR(MAX),@AmountFGOut NUMERIC(19,2)
    DECLARE TOPWeek_C CURSOR FOR
	SELECT TOP 28 FiscalYear,FiscalWeek,'W'+(CASE WHEN FiscalWeek<10 THEN '0'+CONVERT(CHAR(1),FiscalWeek) ELSE CONVERT(CHAR(2),FiscalWeek) END)+'FY'+RIGHT(CONVERT(CHAR(4),FiscalYear),2) AS FiscalWeekDesc,FiscalWeekFrom,FiscalWeekTo
	FROM Calendar
	WHERE Calenderdate <= GETDATE()-1
	GROUP BY FiscalYear,FiscalWeek,FiscalWeekDesc,FiscalWeekFrom,FiscalWeekTo
	ORDER BY FiscalYear DESC,FiscalWeekTo DESC

	OPEN TOPWeek_C
	FETCH NEXT FROM TOPWeek_C INTO @Fiscalyear,@FiscalWeek,@FiscalWeekDesc,@FiscalWeekFrom,@FiscalWeekTo
	
	WHILE @@FETCH_STATUS=0
		BEGIN
			SET @ReportCode='003' --13WEEKS
			IF NOT EXISTS(SELECT * FROM GlobalViewReport_B2B WHERE ReportCode=@ReportCode AND Year=@Fiscalyear AND WeekNo=@FiscalWeek)
				BEGIN
					INSERT INTO GlobalViewReport_B2B VALUES(@Fiscalyear,@FiscalWeek,@FiscalWeekDesc,@FiscalWeekFrom,@FiscalWeekTo,@ReportCode,0,0,0,0,0,0,0,0)
				END
			SET @ReportCode='004' --4WEEKS
			IF NOT EXISTS(SELECT * FROM GlobalViewReport_B2B WHERE ReportCode=@ReportCode AND Year=@Fiscalyear AND WeekNo=@FiscalWeek )
				BEGIN
					INSERT INTO GlobalViewReport_B2B VALUES(@Fiscalyear,@FiscalWeek,@FiscalWeekDesc,@FiscalWeekFrom,@FiscalWeekTo,@ReportCode,0,0,0,0,0,0,0,0)
				END			
			FETCH NEXT FROM TOPWeek_C INTO @FiscalYear,@FiscalWeek,@FiscalWeekDesc,@FiscalWeekFrom,@FiscalWeekTo
		END
	CLOSE TOPWeek_C
	DEALLOCATE TOPWeek_C
	
	UPDATE GlobalViewReport_B2B
	SET B1=dbo.GlobalViewReport_fun_Get_B2B_Rolling('B1',
														(
															SELECT TOP 1 c.WeekFrom FROM (SELECT TOP 4 b.Year,b.WeekNo,b.WeekFrom FROM GlobalViewReport_B2B b WHERE b.ReportCode='004' AND CONVERT(VARCHAR(10),b.Year)+(CASE WHEN b.WeekNo<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),b.WeekNo)<=CONVERT(VARCHAR(10),a.Year)+(CASE WHEN a.WeekNo<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),a.WeekNo) ORDER BY b.YEAR DESC,b.WEEKNO DESC) C ORDER BY C.YEAR ASC,c.WeekNo ASC
														),
															CASE WHEN a.WeekTo>=GETDATE()-1 THEN GETDATE()-1 ELSE a.WeekTo END
													),
	   B2F=dbo.GlobalViewReport_fun_Get_B2B_Rolling('B2F',
														(
															SELECT TOP 1 c.WeekFrom FROM (SELECT TOP 4 b.Year,b.WeekNo,b.WeekFrom FROM GlobalViewReport_B2B b WHERE b.ReportCode='004' AND CONVERT(VARCHAR(10),b.Year)+(CASE WHEN b.WeekNo<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),b.WeekNo)<=CONVERT(VARCHAR(10),a.Year)+(CASE WHEN a.WeekNo<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),a.WeekNo) ORDER BY b.YEAR DESC,b.WEEKNO DESC) C ORDER BY C.YEAR ASC,c.WeekNo ASC
														),
															CASE WHEN a.WeekTo>=GETDATE()-1 THEN GETDATE()-1 ELSE a.WeekTo END
													),
	   B3=dbo.GlobalViewReport_fun_Get_B2B_Rolling('B3',
														(
															SELECT TOP 1 c.WeekFrom FROM (SELECT TOP 4 b.Year,b.WeekNo,b.WeekFrom FROM GlobalViewReport_B2B b WHERE b.ReportCode='004' AND CONVERT(VARCHAR(10),b.Year)+(CASE WHEN b.WeekNo<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),b.WeekNo)<=CONVERT(VARCHAR(10),a.Year)+(CASE WHEN a.WeekNo<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),a.WeekNo) ORDER BY b.YEAR DESC,b.WEEKNO DESC) C ORDER BY C.YEAR ASC,c.WeekNo ASC
														),
															CASE WHEN a.WeekTo>=GETDATE()-1 THEN GETDATE()-1 ELSE a.WeekTo END
													),
	   B4=dbo.GlobalViewReport_fun_Get_B2B_Rolling('B4',
														(
															SELECT TOP 1 c.WeekFrom FROM (SELECT TOP 4 b.Year,b.WeekNo,b.WeekFrom FROM GlobalViewReport_B2B b WHERE b.ReportCode='004' AND CONVERT(VARCHAR(10),b.Year)+(CASE WHEN b.WeekNo<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),b.WeekNo)<=CONVERT(VARCHAR(10),a.Year)+(CASE WHEN a.WeekNo<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),a.WeekNo) ORDER BY b.YEAR DESC,b.WEEKNO DESC) C ORDER BY C.YEAR ASC,c.WeekNo ASC
														),
															CASE WHEN a.WeekTo>=GETDATE()-1 THEN GETDATE()-1 ELSE a.WeekTo END
													),
	   B5=dbo.GlobalViewReport_fun_Get_B2B_Rolling('B5',
														(
															SELECT TOP 1 c.WeekFrom FROM (SELECT TOP 4 b.Year,b.WeekNo,b.WeekFrom FROM GlobalViewReport_B2B b WHERE b.ReportCode='004' AND CONVERT(VARCHAR(10),b.Year)+(CASE WHEN b.WeekNo<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),b.WeekNo)<=CONVERT(VARCHAR(10),a.Year)+(CASE WHEN a.WeekNo<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),a.WeekNo) ORDER BY b.YEAR DESC,b.WEEKNO DESC) C ORDER BY C.YEAR ASC,c.WeekNo ASC
														),
															CASE WHEN a.WeekTo>=GETDATE()-1 THEN GETDATE()-1 ELSE a.WeekTo END
													),
	  VVI=dbo.GlobalViewReport_fun_Get_B2B_Rolling('VVI',
														(
															SELECT TOP 1 c.WeekFrom FROM (SELECT TOP 4 b.Year,b.WeekNo,b.WeekFrom FROM GlobalViewReport_B2B b WHERE b.ReportCode='004' AND CONVERT(VARCHAR(10),b.Year)+(CASE WHEN b.WeekNo<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),b.WeekNo)<=CONVERT(VARCHAR(10),a.Year)+(CASE WHEN a.WeekNo<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),a.WeekNo) ORDER BY b.YEAR DESC,b.WEEKNO DESC) C ORDER BY C.YEAR ASC,c.WeekNo ASC
														),
															CASE WHEN a.WeekTo>=GETDATE()-1 THEN GETDATE()-1 ELSE a.WeekTo END
													),
	   TotalNotB2F=dbo.GlobalViewReport_fun_Get_B2B_Rolling('TotalNotB2F',
														(
															SELECT TOP 1 c.WeekFrom FROM (SELECT TOP 4 b.Year,b.WeekNo,b.WeekFrom FROM GlobalViewReport_B2B b WHERE b.ReportCode='004' AND CONVERT(VARCHAR(10),b.Year)+(CASE WHEN b.WeekNo<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),b.WeekNo)<=CONVERT(VARCHAR(10),a.Year)+(CASE WHEN a.WeekNo<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),a.WeekNo) ORDER BY b.YEAR DESC,b.WEEKNO DESC) C ORDER BY C.YEAR ASC,c.WeekNo ASC
														),
															CASE WHEN a.WeekTo>=GETDATE()-1 THEN GETDATE()-1 ELSE a.WeekTo END
													),
	   Total=dbo.GlobalViewReport_fun_Get_B2B_Rolling('Total',
														(
															SELECT TOP 1 c.WeekFrom FROM (SELECT TOP 4 b.Year,b.WeekNo,b.WeekFrom FROM GlobalViewReport_B2B b WHERE b.ReportCode='004' AND CONVERT(VARCHAR(10),b.Year)+(CASE WHEN b.WeekNo<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),b.WeekNo)<=CONVERT(VARCHAR(10),a.Year)+(CASE WHEN a.WeekNo<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),a.WeekNo) ORDER BY b.YEAR DESC,b.WEEKNO DESC) C ORDER BY C.YEAR ASC,c.WeekNo ASC
														),
															CASE WHEN a.WeekTo>=GETDATE()-1 THEN GETDATE()-1 ELSE a.WeekTo END
													)													
	FROM GlobalViewReport_B2B a
	WHERE a.ReportCode='004' 

	UPDATE GlobalViewReport_B2B
	SET B1=dbo.GlobalViewReport_fun_Get_B2B_Rolling('B1',
														(
															SELECT TOP 1 c.WeekFrom FROM (SELECT TOP 13 b.Year,b.WeekNo,b.WeekFrom FROM GlobalViewReport_B2B b WHERE b.ReportCode='003' AND CONVERT(VARCHAR(10),b.Year)+(CASE WHEN b.WeekNo<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),b.WeekNo)<=CONVERT(VARCHAR(10),a.Year)+(CASE WHEN a.WeekNo<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),a.WeekNo) ORDER BY b.YEAR DESC,b.WEEKNO DESC) C ORDER BY C.YEAR ASC,c.WeekNo ASC
														),
															CASE WHEN a.WeekTo>=GETDATE()-1 THEN GETDATE()-1 ELSE a.WeekTo END
													),
	   B2F=dbo.GlobalViewReport_fun_Get_B2B_Rolling('B2F',
														(
															SELECT TOP 1 c.WeekFrom FROM (SELECT TOP 13 b.Year,b.WeekNo,b.WeekFrom FROM GlobalViewReport_B2B b WHERE b.ReportCode='003' AND CONVERT(VARCHAR(10),b.Year)+(CASE WHEN b.WeekNo<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),b.WeekNo)<=CONVERT(VARCHAR(10),a.Year)+(CASE WHEN a.WeekNo<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),a.WeekNo) ORDER BY b.YEAR DESC,b.WEEKNO DESC) C ORDER BY C.YEAR ASC,c.WeekNo ASC
														),
															CASE WHEN a.WeekTo>=GETDATE()-1 THEN GETDATE()-1 ELSE a.WeekTo END
													),
	   B3=dbo.GlobalViewReport_fun_Get_B2B_Rolling('B3',
														(
															SELECT TOP 1 c.WeekFrom FROM (SELECT TOP 13 b.Year,b.WeekNo,b.WeekFrom FROM GlobalViewReport_B2B b WHERE b.ReportCode='003' AND CONVERT(VARCHAR(10),b.Year)+(CASE WHEN b.WeekNo<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),b.WeekNo)<=CONVERT(VARCHAR(10),a.Year)+(CASE WHEN a.WeekNo<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),a.WeekNo) ORDER BY b.YEAR DESC,b.WEEKNO DESC) C ORDER BY C.YEAR ASC,c.WeekNo ASC
														),
															CASE WHEN a.WeekTo>=GETDATE()-1 THEN GETDATE()-1 ELSE a.WeekTo END
													),
	   B4=dbo.GlobalViewReport_fun_Get_B2B_Rolling('B4',
														(
															SELECT TOP 1 c.WeekFrom FROM (SELECT TOP 13 b.Year,b.WeekNo,b.WeekFrom FROM GlobalViewReport_B2B b WHERE b.ReportCode='003' AND CONVERT(VARCHAR(10),b.Year)+(CASE WHEN b.WeekNo<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),b.WeekNo)<=CONVERT(VARCHAR(10),a.Year)+(CASE WHEN a.WeekNo<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),a.WeekNo) ORDER BY b.YEAR DESC,b.WEEKNO DESC) C ORDER BY C.YEAR ASC,c.WeekNo ASC
														),
															CASE WHEN a.WeekTo>=GETDATE()-1 THEN GETDATE()-1 ELSE a.WeekTo END
													),
	   B5=dbo.GlobalViewReport_fun_Get_B2B_Rolling('B5',
														(
															SELECT TOP 1 c.WeekFrom FROM (SELECT TOP 13 b.Year,b.WeekNo,b.WeekFrom FROM GlobalViewReport_B2B b WHERE b.ReportCode='003' AND CONVERT(VARCHAR(10),b.Year)+(CASE WHEN b.WeekNo<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),b.WeekNo)<=CONVERT(VARCHAR(10),a.Year)+(CASE WHEN a.WeekNo<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),a.WeekNo) ORDER BY b.YEAR DESC,b.WEEKNO DESC) C ORDER BY C.YEAR ASC,c.WeekNo ASC
														),
															CASE WHEN a.WeekTo>=GETDATE()-1 THEN GETDATE()-1 ELSE a.WeekTo END
													),
	  VVI=dbo.GlobalViewReport_fun_Get_B2B_Rolling('VVI',
														(
															SELECT TOP 1 c.WeekFrom FROM (SELECT TOP 13 b.Year,b.WeekNo,b.WeekFrom FROM GlobalViewReport_B2B b WHERE b.ReportCode='003' AND CONVERT(VARCHAR(10),b.Year)+(CASE WHEN b.WeekNo<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),b.WeekNo)<=CONVERT(VARCHAR(10),a.Year)+(CASE WHEN a.WeekNo<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),a.WeekNo) ORDER BY b.YEAR DESC,b.WEEKNO DESC) C ORDER BY C.YEAR ASC,c.WeekNo ASC
														),
															CASE WHEN a.WeekTo>=GETDATE()-1 THEN GETDATE()-1 ELSE a.WeekTo END
													),
	   TotalNotB2F=dbo.GlobalViewReport_fun_Get_B2B_Rolling('TotalNotB2F',
														(
															SELECT TOP 1 c.WeekFrom FROM (SELECT TOP 13 b.Year,b.WeekNo,b.WeekFrom FROM GlobalViewReport_B2B b WHERE b.ReportCode='003' AND CONVERT(VARCHAR(10),b.Year)+(CASE WHEN b.WeekNo<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),b.WeekNo)<=CONVERT(VARCHAR(10),a.Year)+(CASE WHEN a.WeekNo<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),a.WeekNo) ORDER BY b.YEAR DESC,b.WEEKNO DESC) C ORDER BY C.YEAR ASC,c.WeekNo ASC
														),
															CASE WHEN a.WeekTo>=GETDATE()-1 THEN GETDATE()-1 ELSE a.WeekTo END
													),
	   Total=dbo.GlobalViewReport_fun_Get_B2B_Rolling('Total',
														(
															SELECT TOP 1 c.WeekFrom FROM (SELECT TOP 13 b.Year,b.WeekNo,b.WeekFrom FROM GlobalViewReport_B2B b WHERE b.ReportCode='003' AND CONVERT(VARCHAR(10),b.Year)+(CASE WHEN b.WeekNo<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),b.WeekNo)<=CONVERT(VARCHAR(10),a.Year)+(CASE WHEN a.WeekNo<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),a.WeekNo) ORDER BY b.YEAR DESC,b.WEEKNO DESC) C ORDER BY C.YEAR ASC,c.WeekNo ASC
														),
															CASE WHEN a.WeekTo>=GETDATE()-1 THEN GETDATE()-1 ELSE a.WeekTo END
													)
	FROM GlobalViewReport_B2B a
	WHERE a.ReportCode='003' 
END
GO
