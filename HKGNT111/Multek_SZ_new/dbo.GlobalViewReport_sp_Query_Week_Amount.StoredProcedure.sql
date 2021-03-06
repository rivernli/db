USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[GlobalViewReport_sp_Query_Week_Amount]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GlobalViewReport_sp_Query_Week_Amount]
	-- Add the parameters for the stored procedure here
	@ReportCode VARCHAR(3),
	@DateOption INT=0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF @DateOption=0
		BEGIN
			SELECT TOP 13 *
			FROM GlobalViewReport_B2B
			WHERE ReportCode=@ReportCode
			ORDER BY Year DESC,WeekNo DESC
		END
	ELSE
		BEGIN
			SELECT TOP 13 *
			FROM GlobalViewReport_B2B
			WHERE CONVERT(VARCHAR(4),Year)+(CASE WHEN WeekNo<10 THEN '0' ELSE '' END)+CONVERT(VARCHAR(2),WeekNo)<=
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
				AND ReportCode=@ReportCode
			ORDER BY Year DESC,WeekNo DESC
		END 
END
GO
