USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[KOI_sp_Query_Yearly_Number_of_Projects]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 
CREATE PROCEDURE [dbo].[KOI_sp_Query_Yearly_Number_of_Projects] 
	@ReportCode VARCHAR(3), 
	@Year_s VARCHAR(4),
	@Year_e VARCHAR(4),
	@Plant NVARCHAR(50),
	@Sale NVARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON;
	IF @ReportCode='001'
	select 'FY'+[Year] as [Year] ,Over1000Sqft,To501_1000Sqft,To301_500Sqft,To101_300Sqft,To100Sqft,Total 
	from KOI_Yearly_Number_of_Projects 
	WHERE ReportCode=@ReportCode AND [Year] BETWEEN @Year_s AND @Year_e AND Plant=@Plant AND Sale=@Sale 
	ELSE
	select [Year],Over1000Sqft,To501_1000Sqft,To301_500Sqft,To101_300Sqft,To100Sqft,Total 
	from KOI_Yearly_Number_of_Projects 
	WHERE ReportCode=@ReportCode AND [Year] BETWEEN @Year_s AND @Year_e AND Plant=@Plant AND Sale=@Sale 

END

 
GO
