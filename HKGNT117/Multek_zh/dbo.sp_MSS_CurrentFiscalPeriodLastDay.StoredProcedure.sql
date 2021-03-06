USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MSS_CurrentFiscalPeriodLastDay]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_MSS_CurrentFiscalPeriodLastDay]
AS
BEGIN
	DECLARE @CurrentDay DATETIME
	DECLARE @CurrentFiscalYear VARCHAR(4)
	DECLARE @CurrentFiscalPeriod VARCHAR(2)

	SET @CurrentDay=CONVERT(DATETIME, CONVERT(varchar(100), getdate(), 112))
	SELECT @CurrentDay=CONVERT(DATETIME, CONVERT(varchar(100), [UpTime] , 112)) FROM [Multek_ZH].[dbo].[MSS_UpTime]
	
	SELECT @CurrentFiscalYear=substring([FiscalYearDesc],3,4),@CurrentFiscalPeriod=CONVERT(VARCHAR,FiscalPeriod) FROM  [DataWarehouse].[dbo].[DW_DIM_Calender]
	WHERE CalenderDate=@CurrentDay
	SELECT TOP(1) CalenderDate FROM  [DataWarehouse].[dbo].[DW_DIM_Calender]
	WHERE [FiscalYearDesc]='FY'+@CurrentFiscalYear AND FiscalPeriod=@CurrentFiscalPeriod
	ORDER BY CalenderDate DESC
	
END

GO
