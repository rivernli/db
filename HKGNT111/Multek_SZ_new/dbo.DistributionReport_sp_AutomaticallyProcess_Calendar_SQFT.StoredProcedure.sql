USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_AutomaticallyProcess_Calendar_SQFT]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DistributionReport_sp_AutomaticallyProcess_Calendar_SQFT]
	-- Add the parameters for the stored procedure here
	@Type VARCHAR(10),
	@CalculateMonth INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SET NOCOUNT ON;

    DECLARE @Year CHAR(4),@i INT,@j INT,@k INT,@SQLString VARCHAR(MAX),@Color VARCHAR(50),@DateFrom DATETIME,@DateTo DATETIME ,@NowMonth INT,
			@Amount BIGINT,@Site VARCHAR(50),@Plant VARCHAR(50),@Lay INT,@Customer VARCHAR(500),@OEM VARCHAR(500),@ReportCode CHAR(3)
	DECLARE @Lays TABLE (AutoID INT IDENTITY(1,1),Lay INT) 

	IF NOT EXISTS(SELECT * FROM DistributionReport_FushionChart_Color WHERE ReportCode=1 AND Year=@Year)
		BEGIN 
			INSERT INTO DistributionReport_FushionChart_Color(ReportCode,Year)
				VALUES(1,@Year)
		END
	DELETE DistributionReport_FushionChart_Color
	WHERE Year<=@Year-5
		AND ReportCode=1

	SET @Year=(	SELECT MAX(Year) FROM DistributionReport_FushionChart_Color	WHERE ReportCode=1  )
	UPDATE DistributionReport_FushionChart_Color
	SET Color='3399FF'
	WHERE ReportCode=1
		AND Year=@Year
	SET @i=1
	WHILE @i<4
		BEGIN
			SET @Year=(SELECT MAX(Year)	FROM DistributionReport_FushionChart_Color WHERE ReportCode=1 AND Year<@Year )
			UPDATE DistributionReport_FushionChart_Color
			SET Color=(CASE WHEN @i=1 THEN '00FF00' WHEN @i=2 THEN '00FFFF' WHEN @i=3 THEN 'FF00FF' ELSE 'FFFF00' END )
			WHERE ReportCode=1
				AND Year=@Year
			SET @i=@i+1
		END

	--We calculate only two calendar months
	--SET @SQLString=''
	SET @i=1
	WHILE @i<=@CalculateMonth
		BEGIN
			SET @NowMonth=DATEPART(MONTH,DATEADD(MONTH,-@i+1,GETDATE()))
			SET @DateFrom=CONVERT(VARCHAR(7),DATEADD(MONTH,-@i+1,GETDATE()),120)+'-01'
			SET @DateTo=CONVERT(DATETIME,CONVERT(VARCHAR(7),DATEADD(MONTH,-@i+2,GETDATE()),120)+'-01')-1
			SET @Year=CONVERT(CHAR(4),DATEADD(MONTH,-@i+1,GETDATE()),120)
			SET @DateFrom=(CASE WHEN @DateFrom>=GETDATE()-1 THEN CONVERT(VARCHAR(10),GETDATE()-1,120) ELSE @DateFrom END)

			-- ReportCode:001 Process HubIn Monthly Calendar Trend  Code:0001
			SET @Site='Chi'
			SET @Plant='P2'
			SET @ReportCode='001'
			SET @Amount=dbo.DistributionReport_fun_Get_SQFT('Calendar',@Type,@Site,@Plant,@DateFrom,@DateTo,NULL)
			SET @SQLString=dbo.DistributionReport_fun_Get_Calendar_SQFT_SQL_String(@Year,@NowMonth,@Type,@Site,@Plant,@ReportCode,@Amount)
			EXECUTE (@SQLString)
			SET @Plant='2F'
			SET @Amount=dbo.DistributionReport_fun_Get_SQFT('Calendar',@Type,@Site,@Plant,@DateFrom,@DateTo,NULL)
			SET @SQLString=dbo.DistributionReport_fun_Get_Calendar_SQFT_SQL_String(@Year,@NowMonth,@Type,@Site,@Plant,@ReportCode,@Amount)
			EXECUTE (@SQLString)
			SET @Plant='B3'
			SET @Amount=dbo.DistributionReport_fun_Get_SQFT('Calendar',@Type,@Site,@Plant,@DateFrom,@DateTo,NULL)
			SET @SQLString=dbo.DistributionReport_fun_Get_Calendar_SQFT_SQL_String(@Year,@NowMonth,@Type,@Site,@Plant,@ReportCode,@Amount)
			EXECUTE (@SQLString)
			SET @Plant='B4'
			SET @Amount=dbo.DistributionReport_fun_Get_SQFT('Calendar',@Type,@Site,@Plant,@DateFrom,@DateTo,NULL)
			SET @SQLString=dbo.DistributionReport_fun_Get_Calendar_SQFT_SQL_String(@Year,@NowMonth,@Type,@Site,@Plant,@ReportCode,@Amount)
			EXECUTE (@SQLString)
			SET @Plant='B5'
			SET @Amount=dbo.DistributionReport_fun_Get_SQFT('Calendar',@Type,@Site,@Plant,@DateFrom,@DateTo,NULL)
			SET @SQLString=dbo.DistributionReport_fun_Get_Calendar_SQFT_SQL_String(@Year,@NowMonth,@Type,@Site,@Plant,@ReportCode,@Amount)
			EXECUTE (@SQLString)
			SET @Plant='HK'
			SET @Amount=dbo.DistributionReport_fun_Get_SQFT('Calendar',@Type,@Site,@Plant,@DateFrom,@DateTo,NULL)
			SET @SQLString=dbo.DistributionReport_fun_Get_Calendar_SQFT_SQL_String(@Year,@NowMonth,@Type,@Site,@Plant,@ReportCode,@Amount)
			EXECUTE (@SQLString)
			SET @Plant=''
			SET @Amount=dbo.DistributionReport_fun_Get_SQFT('Calendar',@Type,@Site,@Plant,@DateFrom,@DateTo,NULL)
			SET @SQLString=dbo.DistributionReport_fun_Get_Calendar_SQFT_SQL_String(@Year,@NowMonth,@Type,@Site,@Plant,@ReportCode,@Amount)
			EXECUTE (@SQLString)
			SET @i=@i+1	
		END

END
GO
