USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[KOI_sp_Query_Periodly_DPPM_By_Unit]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[KOI_sp_Query_Periodly_DPPM_By_Unit] 
	@ReportCode VARCHAR(3), 
	@Year_s VARCHAR(10),
	@Year_e VARCHAR(10),
	@Plant NVARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON;
	if @ReportCode='001' 
	select 'FY'+[Year]+'.'+CONVERT(VARCHAR,right(100+Period,2)) as [Year],
	ISNULL(SUM(Unit),0) AS Unit from KOI_Periodly_DPPM_By_Unit 
	WHERE ReportCode=@ReportCode AND CONVERT(VARCHAR,[Year])+right(100+Period,2) BETWEEN @Year_s AND @Year_e AND Plant=@Plant 
	 GROUP BY [Year],Period 
	else
	select [Year]+'.'+CONVERT(VARCHAR,right(100+Period,2)) as [Year],
	ISNULL(SUM(Unit),0) AS Unit from KOI_Periodly_DPPM_By_Unit 
	WHERE ReportCode=@ReportCode AND CONVERT(VARCHAR,[Year])+right(100+Period,2) BETWEEN @Year_s AND @Year_e AND Plant=@Plant 
	 GROUP BY [Year],Period 

END
GO
