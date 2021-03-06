USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_INitial_Data]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DistributionReport_sp_INitial_Data]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @SQLString VARCHAR(MAX)
    -- Insert statements for procedure here
    
	UPDATE TFSOLP107180
	SET T$DESC=dbo.DistributionReport_fun_Valid_SQL_String(T$DESC),T$CSGS=dbo.DistributionReport_fun_Valid_SQL_String(T$CSGS)
	UPDATE TFSOLP106180
	SET T$DESC=dbo.DistributionReport_fun_Valid_SQL_String(T$DESC),T$CSGS=dbo.DistributionReport_fun_Valid_SQL_String(T$CSGS)
	UPDATE TFSOLP105180
	SET T$DESC=dbo.DistributionReport_fun_Valid_SQL_String(T$DESC),T$CSGS=dbo.DistributionReport_fun_Valid_SQL_String(T$CSGS)
	UPDATE TFSOLP104180
	SET T$DESC=dbo.DistributionReport_fun_Valid_SQL_String(T$DESC),T$CSGS=dbo.DistributionReport_fun_Valid_SQL_String(T$CSGS)
    
    /*
	TRUNCATE TABLE Calendar
	INSERT INTO Calendar (calenderDate,calenderYear,calenderMonth,calenderquarter,calenderWeek,enWeek,enMonth,FiscalYear,FiscalYearDesc,FiscalPeriod,FiscalQuarter)
	SELECT * FROM HKGNT117.ce3p1179.dbo.Calender
	
	UPDATE Calendar
	SET FiscalPeriodFrom=(
								SELECT (SELECT MIN(b.CalenderDate) FROM Calendar b WHERE b.Fiscalyear=a.FiscalYear AND b.FiscalPeriod=a.FiscalPeriod)
								FROM Calendar a 
								WHERE a.CalenderDate=Calendar.CalenderDate
						)
	UPDATE Calendar
	SET FiscalPeriodTo=(
								SELECT (SELECT MAX(b.CalenderDate) FROM Calendar b WHERE b.Fiscalyear=a.FiscalYear AND b.FiscalPeriod=a.FiscalPeriod)
								FROM Calendar a 
								WHERE a.CalenderDate=Calendar.CalenderDate
						)

	UPDATE Calendar
	SET FiscalYearFrom=(
								SELECT (SELECT MIN(b.CalenderDate) FROM Calendar b WHERE b.Fiscalyear=a.FiscalYear)
								FROM Calendar a 
								WHERE a.CalenderDate=Calendar.CalenderDate
						)
	UPDATE Calendar
	SET FiscalYearTo=(
								SELECT (SELECT MAX(b.CalenderDate) FROM Calendar b WHERE b.Fiscalyear=a.FiscalYear)
								FROM Calendar a 
								WHERE a.CalenderDate=Calendar.CalenderDate
						)
	
	UPDATE Calendar
	SET FiscalQuarterFrom=(
								SELECT (SELECT MIN(b.CalenderDate) FROM Calendar b WHERE b.Fiscalyear=a.FiscalYear AND b.FiscalQuarter=a.FiscalQuarter)
								FROM Calendar a 
								WHERE a.CalenderDate=Calendar.CalenderDate
						)
	UPDATE Calendar
	SET FiscalQuarterTo=(
								SELECT (SELECT MAX(b.CalenderDate) FROM Calendar b WHERE b.Fiscalyear=a.FiscalYear AND b.FiscalQuarter=a.FiscalQuarter)
								FROM Calendar a 
								WHERE a.CalenderDate=Calendar.CalenderDate
						)
	*/					
		
		/****** Script for SelectTopNRows command from SSMS  ******/
	DELETE TFSOLP106180
	WHERE T$COTP='SL8'
  
	UPDATE TFSOLP104180 
	SET T$CCTY=LTRIM(RTRIM(T$CCTY))
	UPDATE TFSOLP105180 
	SET T$CCTY=LTRIM(RTRIM(T$CCTY))
	UPDATE TFSOLP106180 
	SET T$CCTY=LTRIM(RTRIM(T$CCTY))
	UPDATE TFSOLP107180 
	SET T$CCTY=LTRIM(RTRIM(T$CCTY))
					
	INSERT INTO DistributionReport_Country(Code,Name) 
	SELECT LTRIM(RTRIM(T$CCTY)) ,T$DSCA FROM TTCMCS010180 WHERE LTRIM(RTRIM(T$CCTY)) NOT IN (SELECT LTRIM(RTRIM(Code)) FROM DistributionReport_Country)

	UPDATE DistributionReport_Country
	SET Name=b.T$DSCA
	FROM DistributionReport_Country a,TTCMCS010180 b
	WHERE a.Code=b.T$CCTY
	
	UPDATE DistributionReport_Country
	SET Name='TaiWan'
	WHERE Code='TW'			
	
	INSERT INTO Technics(Code,Name) 
	SELECT Code,Attribute FROM HKGNT117.DataWarehouse.dbo.DW_DIM_ProductNature WHERE Code NOT IN (SELECT Code FROM Technics)

	INSERT INTO ttiitm001180
	SELECT t$item,t$dsca 
	FROM HKGNT117.FactoryLoading.dbo.ttiitm001180
	WHERE t$item NOT IN (SELECT t$item FROM ttiitm001180)
		AND t$item IS NOT NULL
		
	DELETE TFSOLP105180 WHERE T$COTP='CNR'
	
END
GO
