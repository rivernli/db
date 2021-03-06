USE [Multek_ZH]
GO
/****** Object:  UserDefinedFunction [dbo].[fun_VI_Reprot_Sum_by_Year_Site_Fiscal_Period]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create FUNCTION [dbo].[fun_VI_Reprot_Sum_by_Year_Site_Fiscal_Period]
(	
	@Year CHAR(4),
	@M1From VARCHAR(10)=NULL,
	@M1To VARCHAR(10)=NULL,
	@M2From VARCHAR(10)=NULL,
	@M2To VARCHAR(10)=NULL,
	@M3From VARCHAR(10)=NULL,
	@M3To VARCHAR(10)=NULL,
	@M4From VARCHAR(10)=NULL,
	@M4To VARCHAR(10)=NULL,
	@M5From VARCHAR(10)=NULL,
	@M5To VARCHAR(10)=NULL,
	@M6From VARCHAR(10)=NULL,
	@M6To VARCHAR(10)=NULL,
	@M7From VARCHAR(10)=NULL,
	@M7To VARCHAR(10)=NULL,
	@M8From VARCHAR(10)=NULL,
	@M8To VARCHAR(10)=NULL,
	@M9From VARCHAR(10)=NULL,
	@M9To VARCHAR(10)=NULL,
	@M10From VARCHAR(10)=NULL,
	@M10To VARCHAR(10)=NULL,
	@M11From VARCHAR(10)=NULL,
	@M11To VARCHAR(10)=NULL,
	@M12From VARCHAR(10)=NULL,
	@M12To VARCHAR(10)=NULL,
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
				WHERE CONVERT(VARCHAR(10),ShDate,120)>=@M1From
					  AND CONVERT(VARCHAR(10),ShDate,120)<=@M1To
					  AND Loc =@Site
					  --AND Plant LIKE '%'+RTRIM(ISNULL(@Plant,''))+'%'
			) AS M1,
			(
				SELECT ISNULL(SUM(ISNULL(ShDols,0)),0)
				FROM VI_Report_Shipped_All
				WHERE CONVERT(VARCHAR(10),ShDate,120)>=@M2From
					  AND CONVERT(VARCHAR(10),ShDate,120)<=@M2To
					  AND Loc =@Site
					  --AND Plant LIKE '%'+RTRIM(ISNULL(@Plant,''))+'%'
			)AS M2,
			(
				SELECT ISNULL(SUM(ISNULL(ShDols,0)),0)
				FROM VI_Report_Shipped_All
				WHERE CONVERT(VARCHAR(10),ShDate,120)>=@M3From
					  AND CONVERT(VARCHAR(10),ShDate,120)<=@M3To
					  AND Loc =@Site
					  --AND Plant LIKE '%'+RTRIM(ISNULL(@Plant,''))+'%'
			)AS M3,
			(
				SELECT ISNULL(SUM(ISNULL(ShDols,0)),0)
				FROM VI_Report_Shipped_All
				WHERE CONVERT(VARCHAR(10),ShDate,120)>=@M4From
					  AND CONVERT(VARCHAR(10),ShDate,120)<=@M4To
					  AND Loc =@Site
					  --AND Plant LIKE '%'+RTRIM(ISNULL(@Plant,''))+'%'
			)AS M4,
			(
				SELECT ISNULL(SUM(ISNULL(ShDols,0)),0)
				FROM VI_Report_Shipped_All
				WHERE CONVERT(VARCHAR(10),ShDate,120)>=@M5From
					  AND CONVERT(VARCHAR(10),ShDate,120)<=@M5To
					  AND Loc =@Site
					  --AND Plant LIKE '%'+RTRIM(ISNULL(@Plant,''))+'%'
			)AS M5,
			(
				SELECT ISNULL(SUM(ISNULL(ShDols,0)),0)
				FROM VI_Report_Shipped_All
				WHERE CONVERT(VARCHAR(10),ShDate,120)>=@M6From
					  AND CONVERT(VARCHAR(10),ShDate,120)<=@M6To
					  AND Loc =@Site
					  --AND Plant LIKE '%'+RTRIM(ISNULL(@Plant,''))+'%'
			)AS M6,
			(
				SELECT ISNULL(SUM(ISNULL(ShDols,0)),0)
				FROM VI_Report_Shipped_All
				WHERE CONVERT(VARCHAR(10),ShDate,120)>=@M7From
					  AND CONVERT(VARCHAR(10),ShDate,120)<=@M7To
					  AND Loc =@Site
					  --AND Plant LIKE '%'+RTRIM(ISNULL(@Plant,''))+'%'
			)AS M7,
			(
				SELECT ISNULL(SUM(ISNULL(ShDols,0)),0)
				FROM VI_Report_Shipped_All
				WHERE CONVERT(VARCHAR(10),ShDate,120)>=@M8From
					  AND CONVERT(VARCHAR(10),ShDate,120)<=@M8To
					  AND Loc =@Site
					  --AND Plant LIKE '%'+RTRIM(ISNULL(@Plant,''))+'%'
			)AS M8,
			(
				SELECT ISNULL(SUM(ISNULL(ShDols,0)),0)
				FROM VI_Report_Shipped_All
				WHERE CONVERT(VARCHAR(10),ShDate,120)>=@M9From
					  AND CONVERT(VARCHAR(10),ShDate,120)<=@M9To
					  AND Loc =@Site
					  --AND Plant LIKE '%'+RTRIM(ISNULL(@Plant,''))+'%'
			)AS M9,
			(
				SELECT ISNULL(SUM(ISNULL(ShDols,0)),0)
				FROM VI_Report_Shipped_All
				WHERE CONVERT(VARCHAR(10),ShDate,120)>=@M10From
					  AND CONVERT(VARCHAR(10),ShDate,120)<=@M10To
					  AND Loc =@Site
					  --AND Plant LIKE '%'+RTRIM(ISNULL(@Plant,''))+'%'
			)AS M10,
			(
				SELECT ISNULL(SUM(ISNULL(ShDols,0)),0)
				FROM VI_Report_Shipped_All
				WHERE CONVERT(VARCHAR(10),ShDate,120)>=@M11From
					  AND CONVERT(VARCHAR(10),ShDate,120)<=@M11To
					  AND Loc =@Site
					  --AND Plant LIKE '%'+RTRIM(ISNULL(@Plant,''))+'%'
			)AS M11,
			(
				SELECT ISNULL(SUM(ISNULL(ShDols,0)),0)
				FROM VI_Report_Shipped_All
				WHERE CONVERT(VARCHAR(10),ShDate,120)>=@M12From
					  AND CONVERT(VARCHAR(10),ShDate,120)<=@M12To
					  AND Loc =@Site
					  --AND Plant LIKE '%'+RTRIM(ISNULL(@Plant,''))+'%'
			) AS M12
)


GO
