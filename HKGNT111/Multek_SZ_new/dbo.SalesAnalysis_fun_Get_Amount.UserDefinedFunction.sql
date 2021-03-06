USE [Multek_SZ_New]
GO
/****** Object:  UserDefinedFunction [dbo].[SalesAnalysis_fun_Get_Amount]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[SalesAnalysis_fun_Get_Amount]
(
	-- Add the parameters for the function here
	@Type VARCHAR(50),
	@Site VARCHAR(10),
	@Plant VARCHAR(10),
	@DateFrom DATETIME,
	@DateTo DATETIME
)
RETURNS BIGINT
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ReturnValue NUMERIC(18,0)

	SET @Site=LTRIM(RTRIM(@Site))
	SET @Plant=(CASE WHEN @Plant='ZhuHai' THEN '' ELSE @Plant END)
	SET @Plant='%'+(CASE @Plant WHEN 'B1' THEN 'P2' WHEN 'B2F' THEN '2F' WHEN 'VVI' THEN 'HK' ELSE @Plant END)+'%'

	-- Add the T-SQL statements to compute the return value here
	IF @Type='PlantSales'
		BEGIN
				SET @ReturnValue=ISNULL((
									SELECT SUM(SHDols) 
									FROM ShipmentReport_Shipped_All 
									WHERE Loc=@Site
										AND Plant LIKE @Plant
										AND Plant <>  'HK'
										AND SOType ='SLS'
										AND BaanItemNum NOT LIKE 'TTC%'
										AND SHDate BETWEEN @DateFrom AND @DateTo
								 ),0)+
								 ISNULL((
									SELECT SUM(SHDols) 
									FROM ShipmentReport_Shipped_All 
									WHERE Loc=@Site
										AND Plant LIKE @Plant
										AND Plant <>  'HK'
										AND SOType ='CNG'
										AND BaanItemNum NOT LIKE 'TTC%'
										AND SHDate BETWEEN @DateFrom AND @DateTo
								 ),0)+
								 ISNULL((
									SELECT SUM(SHDols) 
									FROM ShipmentReport_Shipped_All 
									WHERE Loc=@Site
										AND Plant LIKE @Plant
										AND Plant <>  'HK'
										AND SOType ='BFS'
										AND BaanItemNum NOT LIKE 'TTC%'
										AND SHDate BETWEEN @DateFrom AND @DateTo
								 ),0)+
								 ISNULL((
									SELECT SUM(SHDols) 
									FROM ShipmentReport_Shipped_All 
									WHERE Loc=@Site
										AND Plant LIKE @Plant
										AND Plant <>  'HK'
										AND SOType ='CRE'
										AND BaanItemNum NOT LIKE 'TTC%'
										AND SHDate BETWEEN @DateFrom AND @DateTo
								 ),0)
		END
	IF @Type='VVI'
		BEGIN
				/*
				SET @ReturnValue=ISNULL((
									SELECT SUM(SHDols) 
									FROM ShipmentReport_Shipped_All 
									WHERE Loc=@Site
										AND Plant LIKE @Plant
										AND SOType ='SLT'
										AND BaanItemNum NOT LIKE 'TTC%'
										AND SHDate BETWEEN @DateFrom AND @DateTo
								 ),0)
								 +
								 ISNULL((
									SELECT SUM(SHDols)
									FROM ShipmentReport_Shipped_All 
									WHERE Loc=@Site
										AND Plant LIKE @Plant
										AND SOType ='CLT'
										AND BaanItemNum NOT LIKE 'TTC%'
										AND SHDate BETWEEN @DateFrom AND @DateTo
								 ),0)
				*/
				
				SET @ReturnValue=ISNULL((
									SELECT SUM(SHDols) 
									FROM ShipmentReport_Shipped_All 
									WHERE Loc=@Site
										AND Plant ='HK'
										--AND SOType ='SLT'
										AND BaanItemNum NOT LIKE 'TTC%'
										AND SHDate BETWEEN @DateFrom AND @DateTo
								 ),0)
				IF @Plant<>'%%'
					BEGIN
						SET @ReturnValue=0
					END
		END
	IF @Type='SAMPLE'
		BEGIN
				SET @ReturnValue=(
									SELECT SUM(SHDols) 
									FROM ShipmentReport_Shipped_All 
									WHERE Loc=@Site
										AND Plant LIKE @Plant
										AND Plant <>  'HK'
										AND SOType ='SMP'
										AND BaanItemNum NOT LIKE 'TTC%'
										AND SHDate BETWEEN @DateFrom AND @DateTo
								 )
		END
	IF @Type='Tooling'
		BEGIN
				SET @ReturnValue=(
									SELECT SUM(SHDols) 
									FROM ShipmentReport_Shipped_All 
									WHERE Loc=@Site
										AND Plant LIKE @Plant
										AND Plant <>  'HK'
										AND BaanItemNum LIKE 'TTC%'
										AND SHDate BETWEEN @DateFrom AND @DateTo
								 )				
								/*
								(
									SELECT SUM(SHDols) 
									FROM ShipmentReport_Shipped_All 
									WHERE Loc=@Site
										AND Plant LIKE @Plant
										AND SOType ='SLS'
										AND SHDate BETWEEN @DateFrom AND @DateTo
								 )+
								 (
									SELECT SUM(SHDols) 
									FROM ShipmentReport_Shipped_All 
									WHERE Loc=@Site
										AND Plant LIKE @Plant
										AND SOType ='CNG'
										AND SHDate BETWEEN @DateFrom AND @DateTo
								 )+
								 (
									SELECT SUM(SHDols) 
									FROM ShipmentReport_Shipped_All 
									WHERE Loc=@Site
										AND Plant LIKE @Plant
										AND SOType ='BFS'
										AND SHDate BETWEEN @DateFrom AND @DateTo
								 )+
								 (
									SELECT SUM(SHDols) 
									FROM ShipmentReport_Shipped_All 
									WHERE Loc=@Site
										AND Plant LIKE @Plant
										AND SOType ='SLT'
										AND SHDate BETWEEN @DateFrom AND @DateTo
								 )+
								 (
									SELECT SUM(SHDols) 
									FROM ShipmentReport_Shipped_All 
									WHERE Loc=@Site
										AND Plant LIKE @Plant
										AND SOType ='CLT'
										AND SHDate BETWEEN @DateFrom AND @DateTo
								 )
								 */
		END
	IF @Type='RMA'
		BEGIN
				SET @ReturnValue=0
								/*
								(
									SELECT SUM(T$AMNT) 
									FROM TFSOLP109180 
									WHERE T$PLNT LIKE @Plant 
										AND T$DATE BETWEEN @DateFrom AND @DateTo
								 )
								 */
		END
	IF @Type='OtherSales'
		BEGIN
				SET @ReturnValue=ISNULL((
									SELECT SUM(SHDols) 
									FROM ShipmentReport_Shipped_All 
									WHERE Loc=@Site
										AND Plant LIKE @Plant
										AND Plant <>  'HK'
										AND SOType ='RPL'
										AND BaanItemNum NOT LIKE 'TTC%'
										AND SHDate BETWEEN @DateFrom AND @DateTo
								 ),0)+
								 ISNULL((
									SELECT SUM(SHDols) 
									FROM ShipmentReport_Shipped_All 
									WHERE Loc=@Site
										AND Plant LIKE @Plant
										AND Plant <>  'HK'
										AND SOType ='CNR'
										AND BaanItemNum NOT LIKE 'TTC%'
										AND SHDate BETWEEN @DateFrom AND @DateTo
								 ),0)+
								 ISNULL((
									SELECT SUM(SHDols) 
									FROM ShipmentReport_Shipped_All 
									WHERE Loc=@Site
										AND Plant LIKE @Plant
										AND Plant <>  'HK'
										AND SOType ='ICC'
										AND BaanItemNum NOT LIKE 'TTC%'
										AND SHDate BETWEEN @DateFrom AND @DateTo
								 ),0)+
								 ISNULL((
									SELECT SUM(SHDols) 
									FROM ShipmentReport_Shipped_All 
									WHERE Loc=@Site
										AND Plant LIKE @Plant
										AND Plant <>  'HK'
										AND SOType ='ICD'
										AND BaanItemNum NOT LIKE 'TTC%'
										AND SHDate BETWEEN @DateFrom AND @DateTo
								 ),0)+
								 /*
								 (
									SELECT SUM(SHDols) 
									FROM ShipmentReport_Shipped_All 
									WHERE Loc=@Site
										AND Plant LIKE @Plant
										AND SOType ='CRN'
										AND BaanItemNum NOT LIKE 'TTC%'
										AND SHDate BETWEEN @DateFrom AND @DateTo
								 )+
								 */
								 ISNULL((
									SELECT SUM(SHDols) 
									FROM ShipmentReport_Shipped_All 
									WHERE Loc=@Site
										AND Plant LIKE @Plant
										AND Plant <>  'HK'
										AND SOType ='CRR'
										AND BaanItemNum NOT LIKE 'TTC%'
										AND SHDate BETWEEN @DateFrom AND @DateTo
								 ),0)+
								 ISNULL((
									SELECT SUM(SHDols) 
									FROM ShipmentReport_Shipped_All 
									WHERE Loc=@Site
										AND Plant LIKE @Plant
										AND Plant <>  'HK'
										AND SOType ='PAC'
										AND BaanItemNum NOT LIKE 'TTC%'
										AND SHDate BETWEEN @DateFrom AND @DateTo
								 ),0)
		END
	IF @Type='JVM'
		BEGIN
				SET @ReturnValue=0
								/*
								(
									SELECT SUM(SHDols) 
									FROM ShipmentReport_Shipped_All 
									WHERE Loc=@Site
										AND Plant LIKE @Plant
										AND SOType ='JVM'
										AND SHDate BETWEEN @DateFrom AND @DateTo
								 )
								 */
		END
	IF @Type='SCRAP'
		BEGIN
				SET @ReturnValue=0
								/*
								(
									SELECT SUM(SHDols) 
									FROM ShipmentReport_Shipped_All 
									WHERE Loc=@Site
										AND Plant LIKE @Plant
										AND SOType ='SCRAP'
										AND SHDate BETWEEN @DateFrom AND @DateTo
								 )
								*/
		END
	-- Return the result of the function
	RETURN ISNULL(@ReturnValue,0)

END
GO
