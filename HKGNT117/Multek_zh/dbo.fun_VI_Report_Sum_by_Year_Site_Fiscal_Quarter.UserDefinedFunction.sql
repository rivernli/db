USE [Multek_ZH]
GO
/****** Object:  UserDefinedFunction [dbo].[fun_VI_Report_Sum_by_Year_Site_Fiscal_Quarter]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create FUNCTION [dbo].[fun_VI_Report_Sum_by_Year_Site_Fiscal_Quarter]
(	
	@Year CHAR(4),
	@Q1From VARCHAR(10)=NULL,
	@Q1To VARCHAR(10)=NULL,
	@Q2From VARCHAR(10)=NULL,
	@Q2To VARCHAR(10)=NULL,
	@Q3From VARCHAR(10)=NULL,
	@Q3To VARCHAR(10)=NULL,
	@Q4From VARCHAR(10)=NULL,
	@Q4To VARCHAR(10)=NULL,
	@Site VARCHAR(50)=NULL,
	@Plant VARCHAR(50)=NULL
)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	SELECT (
				SELECT ISNULL(SUM(ISNULL(ShDols,0)),0)
				FROM VI_Report_Shipped_All 
				WHERE CONVERT(VARCHAR(10),ShDate,120)>=@Q1From
					  AND CONVERT(VARCHAR(10),ShDate,120)<=@Q1To
					  AND Loc =@Site
					  --AND Plant LIKE '%'+RTRIM(ISNULL(@Plant,''))+'%'
			) AS M1,
			(
				SELECT ISNULL(SUM(ISNULL(ShDols,0)),0)
				FROM VI_Report_Shipped_All
				WHERE CONVERT(VARCHAR(10),ShDate,120)>=@Q2From
					  AND CONVERT(VARCHAR(10),ShDate,120)<=@Q2To
					  AND Loc =@Site
					  --AND Plant LIKE '%'+RTRIM(ISNULL(@Plant,''))+'%'
			)AS M2,
			(
				SELECT ISNULL(SUM(ISNULL(ShDols,0)),0)
				FROM VI_Report_Shipped_All
				WHERE CONVERT(VARCHAR(10),ShDate,120)>=@Q3From
					  AND CONVERT(VARCHAR(10),ShDate,120)<=@Q3To
					  AND Loc =@Site
					  --AND Plant LIKE '%'+RTRIM(ISNULL(@Plant,''))+'%'
			)AS M3,
			(
				SELECT ISNULL(SUM(ISNULL(ShDols,0)),0)
				FROM VI_Report_Shipped_All
				WHERE CONVERT(VARCHAR(10),ShDate,120)>=@Q4From
					  AND CONVERT(VARCHAR(10),ShDate,120)<=@Q4To
					  AND Loc =@Site
					  --AND Plant LIKE '%'+RTRIM(ISNULL(@Plant,''))+'%'
			)AS M4,
			(
				0
			)AS M5,
			(
				0
			)AS M6,
			(
				0
			)AS M7,
			(
				0
			)AS M8,
			(
				0
			)AS M9,
			(
				0
			)AS M10,
			(
				0
			)AS M11,
			(
				0
			) AS M12
)


GO
