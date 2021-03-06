USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MSS_SeeMSSBookingBreakdown_Search]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 


CREATE  procedure [dbo].[sp_MSS_SeeMSSBookingBreakdown_Search]
	@Value	VARCHAR(50)
as
begin
	SET @Value=@Value+'%'
	--CurrentFiscalDate
	DECLARE @CurrentDay DATETIME
	DECLARE @CurrentFiscalYear VARCHAR(4)
	DECLARE @CurrentFiscalPeriod VARCHAR(2)
	SELECT @CurrentDay=CONVERT(DATETIME, CONVERT(varchar(100), [UpTime] , 112)) FROM [Multek_ZH].[dbo].[MSS_UpTime]
	SELECT @CurrentFiscalYear= substring([FiscalYearDesc],3,4),@CurrentFiscalPeriod=CONVERT(VARCHAR,FiscalPeriod) FROM  [DataWarehouse].[dbo].[DW_DIM_Calender]
	WHERE CalenderDate=@CurrentDay

	SELECT TOP 10
		[Project4Char] AS [Value]
	FROM (
		SELECT TOP 10
			[Project4Char]
		FROM [MSS_MSSBreakdown]
		WHERE [T$JDAT]=@CurrentDay
				AND ([T$PDAT_FiscalYear] > @CurrentFiscalYear
					OR([T$PDAT_FiscalYear] = @CurrentFiscalYear AND [T$PDAT_FiscalPeriod] >= @CurrentFiscalPeriod)
					AND [T$PDAT_FiscalYear] != 2099	)
				AND [Project4Char] LIKE @Value
		GROUP BY [Project4Char]	
				
		UNION  ALL
		
		SELECT TOP 10
			[OEM] 
		FROM [MSS_MSSBreakdown]
		WHERE [T$JDAT]=@CurrentDay
				AND ([T$PDAT_FiscalYear] > @CurrentFiscalYear
					OR([T$PDAT_FiscalYear] = @CurrentFiscalYear AND [T$PDAT_FiscalPeriod] >= @CurrentFiscalPeriod)
					AND [T$PDAT_FiscalYear] != 2099	)
				AND [OEM] LIKE @Value
		GROUP BY [OEM]
	)AS T
	ORDER BY [Value]

	
END









GO
