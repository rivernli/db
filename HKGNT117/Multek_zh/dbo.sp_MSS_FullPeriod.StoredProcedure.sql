USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MSS_FullPeriod]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_MSS_FullPeriod]
 @Value	VARCHAR(50)
AS
BEGIN
	DECLARE @CurrentDay DATETIME
	DECLARE @CurrentFiscalYear VARCHAR(4)
	DECLARE @CurrentFiscalPeriod VARCHAR(2)
	DECLARE @CurrentFiscal DATETIME
	SET @CurrentDay=CONVERT(DATETIME, CONVERT(varchar(100), getdate(), 112))
	SELECT @CurrentDay=CONVERT(DATETIME, CONVERT(varchar(100), [UpTime] , 112)) FROM [Multek_ZH].[dbo].[MSS_UpTime]
	
	SELECT @CurrentFiscalYear= substring([FiscalYearDesc],3,4),@CurrentFiscalPeriod=CONVERT(VARCHAR,FiscalPeriod) FROM  [DataWarehouse].[dbo].[DW_DIM_Calender]
	WHERE CalenderDate=@CurrentDay
	SELECT @CurrentFiscal=CONVERT(DATETIME,@CurrentFiscalYear+'-'+@CurrentFiscalPeriod+'-01')
	
	IF @Value ='ALL'
	BEGIN
		SELECT 'ALL'
	END
	ELSE IF @Value = 'current'
	BEGIN
		SELECT dbo.fun_Get_Full_Period_Name(@CurrentFiscalYear, @CurrentFiscalPeriod)
	END
	ELSE IF @Value = 'next'
	BEGIN
		SELECT @CurrentFiscalYear= substring([FiscalYearDesc],3,4),@CurrentFiscalPeriod=CONVERT(VARCHAR,FiscalPeriod)  FROM  [DataWarehouse].[dbo].[DW_DIM_Calender] WHERE  DATEDIFF(MONTH,@CurrentFiscal, CONVERT(DATETIME, substring([FiscalYearDesc],3,4)+'-'+CONVERT(nvarchar(10),[FiscalPeriod])+'-01'))=1
		SELECT dbo.fun_Get_Full_Period_Name(@CurrentFiscalYear, @CurrentFiscalPeriod)
	END
	ELSE IF @Value = 'third'
	BEGIN
		SELECT @CurrentFiscalYear= substring([FiscalYearDesc],3,4),@CurrentFiscalPeriod=CONVERT(VARCHAR,FiscalPeriod)  FROM  [DataWarehouse].[dbo].[DW_DIM_Calender] WHERE  DATEDIFF(MONTH,@CurrentFiscal, CONVERT(DATETIME, substring([FiscalYearDesc],3,4)+'-'+CONVERT(nvarchar(10),[FiscalPeriod])+'-01'))=2
		SELECT dbo.fun_Get_Full_Period_Name(@CurrentFiscalYear, @CurrentFiscalPeriod)
	END
	ELSE
	BEGIN
		SELECT 'Future'
	END
		
END

GO
