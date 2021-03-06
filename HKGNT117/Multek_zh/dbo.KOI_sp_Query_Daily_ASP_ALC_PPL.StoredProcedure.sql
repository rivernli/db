USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[KOI_sp_Query_Daily_ASP_ALC_PPL]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[KOI_sp_Query_Daily_ASP_ALC_PPL] 
	@ReportCode VARCHAR(20),
	@Date_s VARCHAR(10),
	@Date_e VARCHAR(10),
	@Plant NVARCHAR(50), 
	@Sale NVARCHAR(50) 
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @QueryString NVARCHAR(max) 
	SET @Plant=(CASE @Plant WHEN 'B2F' THEN '2F' ELSE @Plant END)

	IF @Plant='All'
			BEGIN
			set @QueryString=' WHERE T$DATE BETWEEN '+''''+@Date_s+''''+' AND '+''''+@Date_e+''''+' AND T$SOUR='+''''+@Sale+''''+' AND (T$PLNT=''B1'' OR T$PLNT=''2F'' OR T$PLNT=''B3'' OR T$PLNT=''B4'' OR T$PLNT=''B5'') '
			END
		ELSE 
			IF @Plant='Allexclude2F'
			BEGIN
				set @QueryString=' WHERE T$DATE BETWEEN '+''''+@Date_s+''''+' AND '+''''+@Date_e+''''+'  AND T$SOUR='+''''+@Sale+''''+' AND (T$PLNT=''B1'' OR T$PLNT=''B3'' OR T$PLNT=''B4'' OR T$PLNT=''B5'') '
			END
			ELSE
			BEGIN
				set @QueryString=' WHERE T$DATE BETWEEN '+''''+@Date_s+''''+' AND '+''''+@Date_e+''''+'  AND T$SOUR='+''''+@Sale+''''+' AND T$PLNT='+''''+@Plant+''''+' '
			END
	
	--FY
	IF @ReportCode='001'
	BEGIN	
		exec('select CONVERT(varchar(10),T$DATE,120) as  [Year],
		ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$LYER*T$AREA)/SUM(T$AREA)) END),0) AS ALC, 
		ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$AMNT)/SUM(T$AREA)) END),0) AS ASP, 		
		ISNULL((CASE convert(numeric(18,2),SUM(T$LYER*T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$AMNT)/SUM(T$LYER*T$AREA)) END),0) AS PPL 
		FROM TFSOLP112180 '+@QueryString+ ' GROUP BY T$DATE ' )
	END
	--Calender
	IF @ReportCode='002'
	BEGIN
		exec('select CONVERT(varchar(10),T$DATE,120) as  [Year],
		ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$LYER*T$AREA)/SUM(T$AREA)) END),0) AS ALC, 
		ISNULL((CASE convert(numeric(18,2),SUM(T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$AMNT)/SUM(T$AREA)) END),0) AS ASP, 		
		ISNULL((CASE convert(numeric(18,2),SUM(T$LYER*T$AREA)) WHEN 0 THEN 0 ELSE convert(numeric(18,2),SUM(T$AMNT)/SUM(T$LYER*T$AREA)) END),0) AS PPL 
		FROM TFSOLP112180'+@QueryString+ ' GROUP BY T$DATE ' )
	END
END





GO
