USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[GlobalViewReport_sp_Query_Week]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GlobalViewReport_sp_Query_Week]
	-- Add the parameters for the stored procedure here
	@DateOption INT=0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	IF @DateOption=0
		BEGIN
			SELECT * 
			FROM (
					SELECT TOP 13 FiscalYear,FiscalWeek,'W'+(CASE WHEN FiscalWeek<10 THEN '0'+CONVERT(CHAR(1),FiscalWeek) ELSE CONVERT(CHAR(2),FiscalWeek) END)+'FY'+RIGHT(CONVERT(CHAR(4),FiscalYear),2) AS FiscalWeekDesc,FiscalWeekFrom,FiscalWeekTo
					FROM Calendar
					WHERE Calenderdate <= GETDATE()-1
					GROUP BY FiscalYear,FiscalWeek,FiscalWeekDesc,FiscalWeekFrom,FiscalWeekTo
					ORDER BY FiscalYear DESC,FiscalWeek DESC
				 ) a
			ORDER BY a.FiscalYear ,a.FiscalWeek
		END
	ELSE
		BEGIN
			SELECT *
			FROM (
					SELECT TOP 13 FiscalYear,FiscalWeek,'W'+(CASE WHEN FiscalWeek<10 THEN '0'+CONVERT(CHAR(1),FiscalWeek) ELSE CONVERT(CHAR(2),FiscalWeek) END)+'FY'+RIGHT(CONVERT(CHAR(4),FiscalYear),2) AS FiscalWeekDesc,FiscalWeekFrom,FiscalWeekTo
					FROM Calendar
					WHERE CONVERT(VARCHAR(4),FiscalYear)+(CASE WHEN FiscalWeek<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),FiscalWeek)<=
							(
								SELECT CONVERT(VARCHAR(4),FiscalYear)+(CASE WHEN FiscalWeek<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),FiscalWeek)
								FROM Calendar
								WHERE FiscalWeekTo=(
														SELECT DATEADD(DAY,-1,CONVERT(DATE,FiscalWeekFrom))
														FROM Calendar
														WHERE Calenderdate = CONVERT(VARCHAR(10),GETDATE(),120)
													)
								GROUP BY FiscalYear,FiscalWeek
							)
					GROUP BY FiscalYear,FiscalWeek,FiscalWeekDesc,FiscalWeekFrom,FiscalWeekTo
					ORDER BY FiscalYear DESC,FiscalWeek DESC
				 ) a
			ORDER BY a.FiscalYear ,a.FiscalWeek
		END

	/*
	IF @WeekNo=4
		BEGIN
			SELECT WeekNo,WeekDesc,
				   (CASE WHEN WeekNo-3>=1 THEN 'W'+(CASE WHEN WeekNo-3<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),WeekNo-3)+'FY'+RIGHT(CONVERT(CHAR(4),Year),2) ELSE 'W'+(CASE WHEN 52+(WeekNo-3)<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),52+(WeekNo-3))+'FY'+RIGHT(CONVERT(CHAR(4),Year-1),2) END)
						+'~' 
						+'W'+(CASE WHEN WeekNo<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),WeekNo)+'FY'+RIGHT(CONVERT(CHAR(4),Year),2)  AS WeekRange,
				    'W'+(CASE WHEN WeekNo<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),WeekNo)+'FY'+RIGHT(CONVERT(CHAR(4),Year),2)  AS WeekDisplay
						
			FROM (SELECT TOP 13 Year,WeekNo,'W'+(CASE WHEN WeekNo<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),WeekNo)+'FY'+RIGHT(CONVERT(CHAR(4),Year),2) AS WeekDESC FROM GlobalViewReport_B2B WHERE Year<>9999 GROUP BY YEAR,WeekNo ORDER BY YEAR DESC,WeekNo DESC) a ORDER BY YEAR asc,WeekNo ASC
		END
	IF @WeekNo=13
		BEGIN
			SELECT WeekNo,WeekDesc,
				   (CASE WHEN WeekNo-12>=1 THEN 'W'+(CASE WHEN WeekNo-12<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),WeekNo-12)+'FY'+RIGHT(CONVERT(CHAR(4),Year),2) ELSE 'W'+(CASE WHEN 52+(WeekNo-12)<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),52+(WeekNo-12))+'FY'+RIGHT(CONVERT(CHAR(4),Year-1),2) END)
						+'~' 
						+'W'+(CASE WHEN WeekNo<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),WeekNo)+'FY'+RIGHT(CONVERT(CHAR(4),Year),2)  AS WeekRange,
				    'W'+(CASE WHEN WeekNo<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),WeekNo)+'FY'+RIGHT(CONVERT(CHAR(4),Year),2)  AS WeekDisplay
			FROM (SELECT TOP 13 Year,WeekNo,'W'+(CASE WHEN WeekNo<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),WeekNo)+'FY'+RIGHT(CONVERT(CHAR(4),Year),2) AS WeekDESC FROM GlobalViewReport_B2B WHERE Year<>9999 GROUP BY YEAR,WeekNo ORDER BY YEAR DESC,WeekNo DESC) a ORDER BY YEAR asc,WeekNo ASC
		END
	*/
END
GO
