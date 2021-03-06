USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MSS_CurrentFiscalPeriod]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_MSS_CurrentFiscalPeriod]
AS
BEGIN
	DECLARE @CurrentDay DATETIME
	SET @CurrentDay=CONVERT(DATETIME, CONVERT(varchar(100), getdate(), 112))
	SELECT @CurrentDay=CONVERT(DATETIME, CONVERT(varchar(100), [UpTime] , 112)) FROM [Multek_ZH].[dbo].[MSS_UpTime]
	
	SELECT [FiscalPeriod] FROM  [DataWarehouse].[dbo].[DW_DIM_Calender]
	WHERE CalenderDate=@CurrentDay
END

GO
