USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[KOI_sp_Query_Yearly_ASP_ALC_PPL]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[KOI_sp_Query_Yearly_ASP_ALC_PPL] 
	@ReportCode VARCHAR(3), 
	@Year_s VARCHAR(4),
	@Year_e VARCHAR(4),
	@Plant NVARCHAR(50),
	@Sale NVARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON;
	IF @ReportCode='001'	
		select 'FY'+[Year] as [Year],ISNULL(SUM(ALC),0) AS ALC,ISNULL(SUM(ASP),0) AS ASP,ISNULL(SUM(PPL),0) AS PPL from KOI_Yearly_ASP_ALC_PPL  
		WHERE ReportCode=@ReportCode AND [Year] BETWEEN @Year_s AND @Year_e AND Plant=@Plant AND Sale=@Sale 
		 GROUP BY [Year]
	ELSE 
		select [Year],ISNULL(SUM(ALC),0) AS ALC,ISNULL(SUM(ASP),0) AS ASP,ISNULL(SUM(PPL),0) AS PPL from KOI_Yearly_ASP_ALC_PPL  
		WHERE ReportCode=@ReportCode AND [Year] BETWEEN @Year_s AND @Year_e AND Plant=@Plant AND Sale=@Sale 
		 GROUP BY [Year]

END











GO
