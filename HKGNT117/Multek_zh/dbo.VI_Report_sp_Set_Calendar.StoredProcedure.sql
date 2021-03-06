USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[VI_Report_sp_Set_Calendar]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[VI_Report_sp_Set_Calendar]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here 
	
	UPDATE DataWarehouse.dbo.DW_DIM_Calender 
	SET FiscalPeriodFrom=(
								SELECT (SELECT MIN(b.CalenderDate) FROM DataWarehouse.dbo.DW_DIM_Calender  b WHERE b.Fiscalyear=a.FiscalYear AND b.FiscalPeriod=a.FiscalPeriod)
								FROM DataWarehouse.dbo.DW_DIM_Calender  a 
								WHERE a.CalenderDate=DataWarehouse.dbo.DW_DIM_Calender .CalenderDate
						)
	UPDATE DataWarehouse.dbo.DW_DIM_Calender 
	SET FiscalPeriodTo=(
								SELECT (SELECT MAX(b.CalenderDate) FROM DataWarehouse.dbo.DW_DIM_Calender b WHERE b.Fiscalyear=a.FiscalYear AND b.FiscalPeriod=a.FiscalPeriod)
								FROM DataWarehouse.dbo.DW_DIM_Calender a 
								WHERE a.CalenderDate=DataWarehouse.dbo.DW_DIM_Calender.CalenderDate
						)

	UPDATE DataWarehouse.dbo.DW_DIM_Calender
	SET FiscalYearFrom=(
								SELECT (SELECT MIN(b.CalenderDate) FROM DataWarehouse.dbo.DW_DIM_Calender b WHERE b.Fiscalyear=a.FiscalYear)
								FROM DataWarehouse.dbo.DW_DIM_Calender a 
								WHERE a.CalenderDate=DataWarehouse.dbo.DW_DIM_Calender.CalenderDate
						)
	UPDATE DataWarehouse.dbo.DW_DIM_Calender
	SET FiscalYearTo=(
								SELECT (SELECT MAX(b.CalenderDate) FROM DataWarehouse.dbo.DW_DIM_Calender b WHERE b.Fiscalyear=a.FiscalYear)
								FROM DataWarehouse.dbo.DW_DIM_Calender a 
								WHERE a.CalenderDate=DataWarehouse.dbo.DW_DIM_Calender.CalenderDate
						)
	
	UPDATE DataWarehouse.dbo.DW_DIM_Calender
	SET FiscalQuarterFrom=(
								SELECT (SELECT MIN(b.CalenderDate) FROM DataWarehouse.dbo.DW_DIM_Calender b WHERE b.Fiscalyear=a.FiscalYear AND b.FiscalQuarter=a.FiscalQuarter)
								FROM DataWarehouse.dbo.DW_DIM_Calender a 
								WHERE a.CalenderDate=DataWarehouse.dbo.DW_DIM_Calender.CalenderDate
						)

	UPDATE DataWarehouse.dbo.DW_DIM_Calender
	SET FiscalQuarterTo=(
								SELECT (SELECT MAX(b.CalenderDate) FROM DataWarehouse.dbo.DW_DIM_Calender b WHERE b.Fiscalyear=a.FiscalYear AND b.FiscalQuarter=a.FiscalQuarter)
								FROM DataWarehouse.dbo.DW_DIM_Calender a 
								WHERE a.CalenderDate=DataWarehouse.dbo.DW_DIM_Calender.CalenderDate
						)
	
	UPDATE DataWarehouse.dbo.DW_DIM_Calender
	SET FiscalWeekFrom=(
								SELECT (SELECT MIN(b.CalenderDate) FROM DataWarehouse.dbo.DW_DIM_Calender b WHERE b.Fiscalyear=a.FiscalYear AND b.FiscalWeek=a.FiscalWeek)
								FROM DataWarehouse.dbo.DW_DIM_Calender a 
								WHERE a.CalenderDate=DataWarehouse.dbo.DW_DIM_Calender.CalenderDate
						  )				
	UPDATE DataWarehouse.dbo.DW_DIM_Calender
	SET FiscalWeekTo=(
								SELECT (SELECT MAX(b.CalenderDate) FROM DataWarehouse.dbo.DW_DIM_Calender b WHERE b.Fiscalyear=a.FiscalYear AND b.FiscalWeek=a.FiscalWeek)
								FROM DataWarehouse.dbo.DW_DIM_Calender a 
								WHERE a.CalenderDate=DataWarehouse.dbo.DW_DIM_Calender.CalenderDate
						  )				


END

GO
