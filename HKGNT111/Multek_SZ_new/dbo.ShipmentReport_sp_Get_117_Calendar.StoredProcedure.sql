USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[ShipmentReport_sp_Get_117_Calendar]    Script Date: 11/06/2014 15:47:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ShipmentReport_sp_Get_117_Calendar]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	TRUNCATE TABLE Calendar
	INSERT INTO Calendar (calenderDate,calenderYear,calenderMonth,calenderquarter,calenderWeek,enWeek,enMonth,FiscalYear,FiscalYearDesc,FiscalPeriod,FiscalQuarter,FiscalWeek,FiscalWeekDesc)
	SELECT calenderDate,calenderYear,calenderMonth,calenderquarter,calenderWeek,enWeek,enMonth,FiscalYear,FiscalYearDesc,FiscalPeriod,FiscalQuarter,FiscalWeek,FiscalWeekDesc FROM HKGNT117.DataWarehouse.dbo.DW_DIM_Calender

	UPDATE Calendar
    SET FiscalYear=RIGHT(FiscalYearDesc,4)
	
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
		
	UPDATE Calendar
	SET FiscalWeekFrom=(
								SELECT (SELECT MIN(b.CalenderDate) FROM Calendar b WHERE b.Fiscalyear=a.FiscalYear AND b.FiscalWeek=a.FiscalWeek)
								FROM Calendar a 
								WHERE a.CalenderDate=Calendar.CalenderDate
						  )				
	UPDATE Calendar
	SET FiscalWeekTo=(
								SELECT (SELECT MAX(b.CalenderDate) FROM Calendar b WHERE b.Fiscalyear=a.FiscalYear AND b.FiscalWeek=a.FiscalWeek)
								FROM Calendar a 
								WHERE a.CalenderDate=Calendar.CalenderDate
						  )				
	--DBCC SHRINKFILE (N'TestDB_Log' , 0)

END
GO
