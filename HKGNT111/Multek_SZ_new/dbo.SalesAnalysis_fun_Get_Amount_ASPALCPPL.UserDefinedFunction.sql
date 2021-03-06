USE [Multek_SZ_New]
GO
/****** Object:  UserDefinedFunction [dbo].[SalesAnalysis_fun_Get_Amount_ASPALCPPL]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[SalesAnalysis_fun_Get_Amount_ASPALCPPL]
(
	-- Add the parameters for the function here
	@Type VARCHAR(50),
	@Site VARCHAR(10),
	@Plant VARCHAR(10),
	@DateFrom DATETIME,
	@DateTo DATETIME
)
RETURNS NUMERIC(18,4)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Amount1 NUMERIC(18,4),@Amount2 NUMERIC(18,4),@ReturnValue NUMERIC(18,2)

	SET @Site=LTRIM(RTRIM(@Site))
	SET @Plant=(CASE WHEN @Plant='ZhuHai' THEN '' ELSE @Plant END)
	SET @Plant='%'+(CASE @Plant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN 'B12' WHEN 'VVI' THEN 'HK' ELSE @Plant END)+'%'

	-- Add the T-SQL statements to compute the return value here
	IF @Type='ASP'
		BEGIN
				SET @Amount1 =ISNULL((
									SELECT SUM(SHDols) 
									FROM ShipmentReport_Shipped_All 
									WHERE Loc=@Site
										AND Plant LIKE @Plant
										AND SOType ='SLS'
										AND BaanItemNum NOT LIKE 'TTC%'
										AND SHDate BETWEEN @DateFrom AND @DateTo
								 ),0)+
								 ISNULL((
									SELECT SUM(SHDols) 
									FROM ShipmentReport_Shipped_All 
									WHERE Loc=@Site
										AND Plant LIKE @Plant
										AND SOType ='CNG'
										AND BaanItemNum NOT LIKE 'TTC%'
										AND SHDate BETWEEN @DateFrom AND @DateTo
								 ),0)+
								 ISNULL((
									SELECT SUM(SHDols) 
									FROM ShipmentReport_Shipped_All 
									WHERE Loc=@Site
										AND Plant LIKE @Plant
										AND SOType ='BFS'
										AND BaanItemNum NOT LIKE 'TTC%'
										AND SHDate BETWEEN @DateFrom AND @DateTo
								 ),0)+
								 ISNULL((
									SELECT SUM(SHDols) 
									FROM ShipmentReport_Shipped_All 
									WHERE Loc=@Site
										AND Plant LIKE @Plant
										AND SOType ='CRE'
										AND BaanItemNum NOT LIKE 'TTC%'
										AND SHDate BETWEEN @DateFrom AND @DateTo
								 ),0)
				SET @Amount2 =ISNULL((
									SELECT SUM(Area)
									FROM ShipmentReport_Shipped_All 
									WHERE Loc=@Site
										AND Plant LIKE @Plant
										AND SOType ='SLS'
										AND BaanItemNum NOT LIKE 'TTC%'
										AND SHDate BETWEEN @DateFrom AND @DateTo
								 ),0)+
								 ISNULL((
									SELECT SUM(Area)
									FROM ShipmentReport_Shipped_All 
									WHERE Loc=@Site
										AND Plant LIKE @Plant
										AND SOType ='CNG'
										AND BaanItemNum NOT LIKE 'TTC%'
										AND SHDate BETWEEN @DateFrom AND @DateTo
								 ),0)+
								 ISNULL((
									SELECT SUM(Area)
									FROM ShipmentReport_Shipped_All 
									WHERE Loc=@Site
										AND Plant LIKE @Plant
										AND SOType ='BFS'
										AND BaanItemNum NOT LIKE 'TTC%'
										AND SHDate BETWEEN @DateFrom AND @DateTo
								 ),0)+
								 ISNULL((
									SELECT SUM(SHDols) 
									FROM ShipmentReport_Shipped_All 
									WHERE Loc=@Site
										AND Plant LIKE @Plant
										AND SOType ='CRE'
										AND BaanItemNum NOT LIKE 'TTC%'
										AND SHDate BETWEEN @DateFrom AND @DateTo
								 ),0)
				IF @Amount2<>0
					BEGIN
						SET @ReturnValue=@Amount1/@Amount2*1.0000
					END
		END
	IF @Type='ALC'
		BEGIN
				SET @Amount1 =ISNULL((
									SELECT SUM(Lays*Area)
									FROM ShipmentReport_Shipped_All 
									WHERE Loc=@Site
										AND Plant LIKE @Plant
										AND SOType ='SLS'
										AND BaanItemNum NOT LIKE 'TTC%'
										AND SHDate BETWEEN @DateFrom AND @DateTo
								 ),0)+
								 ISNULL((
									SELECT SUM(Lays*Area)
									FROM ShipmentReport_Shipped_All 
									WHERE Loc=@Site
										AND Plant LIKE @Plant
										AND SOType ='CNG'
										AND BaanItemNum NOT LIKE 'TTC%'
										AND SHDate BETWEEN @DateFrom AND @DateTo
								 ),0)+
								 ISNULL((
									SELECT SUM(Lays*Area)
									FROM ShipmentReport_Shipped_All 
									WHERE Loc=@Site
										AND Plant LIKE @Plant
										AND SOType ='BFS'
										AND BaanItemNum NOT LIKE 'TTC%'
										AND SHDate BETWEEN @DateFrom AND @DateTo
								 ),0)+
								 ISNULL((
									SELECT SUM(SHDols) 
									FROM ShipmentReport_Shipped_All 
									WHERE Loc=@Site
										AND Plant LIKE @Plant
										AND SOType ='CRE'
										AND BaanItemNum NOT LIKE 'TTC%'
										AND SHDate BETWEEN @DateFrom AND @DateTo
								 ),0)
				SET @Amount2 =ISNULL((
									SELECT SUM(Area)
									FROM ShipmentReport_Shipped_All 
									WHERE Loc=@Site
										AND Plant LIKE @Plant
										AND SOType ='SLS'
										AND BaanItemNum NOT LIKE 'TTC%'
										AND SHDate BETWEEN @DateFrom AND @DateTo
								 ),0)+
								 ISNULL((
									SELECT SUM(Area)
									FROM ShipmentReport_Shipped_All 
									WHERE Loc=@Site
										AND Plant LIKE @Plant
										AND SOType ='CNG'
										AND BaanItemNum NOT LIKE 'TTC%'
										AND SHDate BETWEEN @DateFrom AND @DateTo
								 ),0)+
								 ISNULL((
									SELECT SUM(Area)
									FROM ShipmentReport_Shipped_All 
									WHERE Loc=@Site
										AND Plant LIKE @Plant
										AND SOType ='BFS'
										AND BaanItemNum NOT LIKE 'TTC%'
										AND SHDate BETWEEN @DateFrom AND @DateTo
								 ),0)+
								 ISNULL((
									SELECT SUM(SHDols) 
									FROM ShipmentReport_Shipped_All 
									WHERE Loc=@Site
										AND Plant LIKE @Plant
										AND SOType ='CRE'
										AND BaanItemNum NOT LIKE 'TTC%'
										AND SHDate BETWEEN @DateFrom AND @DateTo
								 ),0)
				IF @Amount2<>0
					BEGIN
						SET @ReturnValue=@Amount1/@Amount2*1.0000
					END
		END

	-- Return the result of the function
	RETURN ISNULL(@ReturnValue,0)

END
GO
