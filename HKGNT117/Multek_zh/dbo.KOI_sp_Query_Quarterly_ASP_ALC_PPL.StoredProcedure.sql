USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[KOI_sp_Query_Quarterly_ASP_ALC_PPL]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[KOI_sp_Query_Quarterly_ASP_ALC_PPL] 
	@ReportCode VARCHAR(3),
	@Year_s VARCHAR(10),
	@Year_e VARCHAR(10),
	@Plant NVARCHAR(50),
	@Sale NVARCHAR(50) 
AS
BEGIN
	SET NOCOUNT ON;
	IF @ReportCode='001'
		select 'FY'+[Year]+'.'+CONVERT(VARCHAR,right(100+Quarter,2)) as [Year],ISNULL(SUM(ALC),0) AS ALC,ISNULL(SUM(ASP),0) AS ASP,ISNULL(SUM(PPL),0) AS PPL 
		from KOI_Quarterly_ASP_ALC_PPL  
		WHERE ReportCode=@ReportCode AND CONVERT(VARCHAR,[Year])+right(100+Quarter,2) BETWEEN @Year_s AND @Year_e AND Plant=@Plant AND Sale=@Sale 
		GROUP BY [Year],Quarter 
	ELSE 
		select [Year]+'.'+CONVERT(VARCHAR,right(100+Quarter,2)) as [Year],ISNULL(SUM(ALC),0) AS ALC,ISNULL(SUM(ASP),0) AS ASP,ISNULL(SUM(PPL),0) AS PPL 
		from KOI_Quarterly_ASP_ALC_PPL  
		WHERE ReportCode=@ReportCode AND CONVERT(VARCHAR,[Year])+right(100+Quarter,2) BETWEEN @Year_s AND @Year_e AND Plant=@Plant AND Sale=@Sale 
		GROUP BY [Year],Quarter 
END











GO
