USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MSS_MSSBreakdown_Order]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 


CREATE  procedure [dbo].[sp_MSS_MSSBreakdown_Order]
	@Plant	VARCHAR(10)
	,@Order	VARCHAR(50)
	,@FiscalYear	VARCHAR(50)
	,@FiscalPeriod	VARCHAR(10)
as
begin
	--CurrentDate
	DECLARE @CurrentDay DATETIME
	SELECT @CurrentDay=CONVERT(DATETIME, CONVERT(varchar(100), [UpTime] , 112)) FROM [Multek_ZH].[dbo].[MSS_UpTime]
	

	IF @FiscalYear='After Period'
	BEGIN
		IF @Plant='ALL'
		BEGIN
			IF @Order = 'VMI'
				SELECT [Plant]
				  ,[Project]
				  ,[OEM]
				  ,[CustomerPart]
				  ,[Quantity]
				  ,[Sqft]
				FROM [Multek_ZH].[dbo].[MSS_MSSBreakdown]
				WHERE [T$JDAT]= @CurrentDay  
					AND [OrderType] IN ('CNG', 'CLT')
					AND [T$PDAT_FiscalYear] IS NULL
			ELSE IF @Order='Total'
				SELECT [Plant]
				  ,[Project]
				  ,[OEM]
				  ,[CustomerPart]
				  ,[Quantity]
				  ,[Sqft]
				FROM [Multek_ZH].[dbo].[MSS_MSSBreakdown]
				WHERE [T$JDAT]= @CurrentDay 
					AND [T$PDAT_FiscalYear] IS NULL
			ELSE IF @Order = 'PO'
				SELECT [Plant]
				  ,[Project]
				  ,[OEM]
				  ,[CustomerPart]
				  ,[Quantity]
				  ,[Sqft]
				FROM [Multek_ZH].[dbo].[MSS_MSSBreakdown]
				WHERE [T$JDAT]= @CurrentDay  
					AND [OrderType] IN ('SLS', 'SLT', 'BFS')
					AND [T$PDAT_FiscalYear] IS NULL
					
		END
		ELSE
		BEGIN
			IF @Order = 'VMI'
				SELECT [Plant]
				  ,[Project]
				  ,[OEM]
				  ,[CustomerPart]
				  ,[Quantity]
				  ,[Sqft]
				FROM [Multek_ZH].[dbo].[MSS_MSSBreakdown]
				WHERE [T$JDAT]= @CurrentDay  
					AND [Plant]=@Plant 
					AND [OrderType] IN ('CNG', 'CLT')
					AND [T$PDAT_FiscalYear] IS NULL
			ELSE IF @Order='Total'
				SELECT [Plant]
				  ,[Project]
				  ,[OEM]
				  ,[CustomerPart]
				  ,[Quantity]
				  ,[Sqft]
				FROM [Multek_ZH].[dbo].[MSS_MSSBreakdown]
				WHERE [T$JDAT]= @CurrentDay  
					AND [Plant]=@Plant 
					AND [T$PDAT_FiscalYear] IS NULL
			ELSE IF @Order = 'PO'
				SELECT [Plant]
				  ,[Project]
				  ,[OEM]
				  ,[CustomerPart]
				  ,[Quantity]
				  ,[Sqft]
				FROM [Multek_ZH].[dbo].[MSS_MSSBreakdown]
				WHERE [T$JDAT]= @CurrentDay  
					AND [Plant]=@Plant 
					AND [OrderType] IN ('SLS', 'SLT', 'BFS')
					AND [T$PDAT_FiscalYear] IS NULL
		END
	END
	--'After Period' END
	
	ELSE IF @FiscalYear='Buffer Order' 
	BEGIN
		IF @Plant='ALL'
		BEGIN
			IF @Order = 'VMI'
				SELECT [Plant]
				  ,[Project]
				  ,[OEM]
				  ,[CustomerPart]
				  ,[Quantity]
				  ,[Sqft]
				FROM [Multek_ZH].[dbo].[MSS_MSSBreakdown]
				WHERE [T$JDAT]= @CurrentDay  
					AND [OrderType] IN ('CNG', 'CLT')
					AND [T$PDAT_FiscalYear] = '2099' AND [T$PDAT_FiscalPeriod] = 1
			ELSE IF @Order='Total'
				SELECT [Plant]
				  ,[Project]
				  ,[OEM]
				  ,[CustomerPart]
				  ,[Quantity]
				  ,[Sqft]
				FROM [Multek_ZH].[dbo].[MSS_MSSBreakdown]
				WHERE [T$JDAT]= @CurrentDay  
					AND [T$PDAT_FiscalYear] = '2099' AND [T$PDAT_FiscalPeriod] = 1
			ELSE IF @Order = 'PO'
				SELECT [Plant]
				  ,[Project]
				  ,[OEM]
				  ,[CustomerPart]
				  ,[Quantity]
				  ,[Sqft]
				FROM [Multek_ZH].[dbo].[MSS_MSSBreakdown]
				WHERE [T$JDAT]= @CurrentDay  
					AND [OrderType] IN ('SLS', 'SLT', 'BFS')
					AND [T$PDAT_FiscalYear] = '2099' AND [T$PDAT_FiscalPeriod] = 1
		END
		ELSE
		BEGIN
			IF @Order = 'VMI'
				SELECT [Plant]
				  ,[Project]
				  ,[OEM]
				  ,[CustomerPart]
				  ,[Quantity]
				  ,[Sqft]
				FROM [Multek_ZH].[dbo].[MSS_MSSBreakdown]
				WHERE [T$JDAT]= @CurrentDay  
					AND [Plant]=@Plant 
					AND [OrderType] IN ('CNG', 'CLT')
					AND [T$PDAT_FiscalYear] = '2099' AND [T$PDAT_FiscalPeriod] = 1
			ELSE IF @Order='Total'
				SELECT [Plant]
				  ,[Project]
				  ,[OEM]
				  ,[CustomerPart]
				  ,[Quantity]
				  ,[Sqft]
				FROM [Multek_ZH].[dbo].[MSS_MSSBreakdown]
				WHERE [T$JDAT]= @CurrentDay  
					AND [Plant]=@Plant 
					AND [T$PDAT_FiscalYear] = '2099' AND [T$PDAT_FiscalPeriod] = 1
			ELSE IF @Order = 'PO'
				SELECT [Plant]
				  ,[Project]
				  ,[OEM]
				  ,[CustomerPart]
				  ,[Quantity]
				  ,[Sqft]
				FROM [Multek_ZH].[dbo].[MSS_MSSBreakdown]
				WHERE [T$JDAT]= @CurrentDay  
					AND [Plant]=@Plant 
					AND [OrderType] IN ('SLS', 'SLT', 'BFS')
					AND [T$PDAT_FiscalYear] = '2099' AND [T$PDAT_FiscalPeriod] = 1
		END
	END
	--'Buffer Order' END
	
	ELSE IF @FiscalYear ='Overall' 
	BEGIN
		IF @Plant='ALL'
		BEGIN
			IF @Order = 'VMI'
				SELECT [Plant]
				  ,[Project]
				  ,[OEM]
				  ,[CustomerPart]
				  ,[Quantity]
				  ,[Sqft]
				FROM [Multek_ZH].[dbo].[MSS_MSSBreakdown]
				WHERE [T$JDAT]= @CurrentDay  
					AND [OrderType] IN ('CNG', 'CLT')
			ELSE IF @Order='Total'
				SELECT [Plant]
				  ,[Project]
				  ,[OEM]
				  ,[CustomerPart]
				  ,[Quantity]
				  ,[Sqft]
				FROM [Multek_ZH].[dbo].[MSS_MSSBreakdown]
				WHERE [T$JDAT]= @CurrentDay  
			ELSE IF @Order = 'PO'
				SELECT [Plant]
				  ,[Project]
				  ,[OEM]
				  ,[CustomerPart]
				  ,[Quantity]
				  ,[Sqft]
				FROM [Multek_ZH].[dbo].[MSS_MSSBreakdown]
				WHERE [T$JDAT]= @CurrentDay  
					AND [OrderType] IN ('SLS', 'SLT', 'BFS')
		END
		ELSE
		BEGIN
			IF @Order = 'VMI'
				SELECT [Plant]
				  ,[Project]
				  ,[OEM]
				  ,[CustomerPart]
				  ,[Quantity]
				  ,[Sqft]
				FROM [Multek_ZH].[dbo].[MSS_MSSBreakdown]
				WHERE [T$JDAT]= @CurrentDay  
					AND [Plant]=@Plant 
					AND [OrderType] IN ('CNG', 'CLT')
			ELSE IF @Order='Total'
				SELECT [Plant]
				  ,[Project]
				  ,[OEM]
				  ,[CustomerPart]
				  ,[Quantity]
				  ,[Sqft]
				FROM [Multek_ZH].[dbo].[MSS_MSSBreakdown]
				WHERE [T$JDAT]= @CurrentDay  
					AND [Plant]=@Plant 
			ELSE IF @Order = 'PO'
				SELECT [Plant]
				  ,[Project]
				  ,[OEM]
				  ,[CustomerPart]
				  ,[Quantity]
				  ,[Sqft]
				FROM [Multek_ZH].[dbo].[MSS_MSSBreakdown]
				WHERE [T$JDAT]= @CurrentDay  
					AND [Plant]=@Plant 
					AND [OrderType] IN ('SLS', 'SLT', 'BFS')
		END
	END
	--'Overall'  END
	
	ELSE 
	BEGIN
		IF @Plant='ALL'
		BEGIN
			IF @Order = 'VMI'
				SELECT [Plant]
				  ,[Project]
				  ,[OEM]
				  ,[CustomerPart]
				  ,[Quantity]
				  ,[Sqft]
				FROM [Multek_ZH].[dbo].[MSS_MSSBreakdown]
				WHERE [T$JDAT]= @CurrentDay  
					AND [OrderType] IN ('CNG', 'CLT')
					AND [T$PDAT_FiscalYear]=@FiscalYear
					AND [T$PDAT_FiscalPeriod]=@FiscalPeriod
			ELSE IF @Order='Total'
				SELECT [Plant]
				  ,[Project]
				  ,[OEM]
				  ,[CustomerPart]
				  ,[Quantity]
				  ,[Sqft]
				FROM [Multek_ZH].[dbo].[MSS_MSSBreakdown]
				WHERE [T$JDAT]= @CurrentDay  
					AND [T$PDAT_FiscalYear]=@FiscalYear
					AND [T$PDAT_FiscalPeriod]=@FiscalPeriod
			ELSE IF @Order = 'PO'
				SELECT [Plant]
				  ,[Project]
				  ,[OEM]
				  ,[CustomerPart]
				  ,[Quantity]
				  ,[Sqft]
				FROM [Multek_ZH].[dbo].[MSS_MSSBreakdown]
				WHERE [T$JDAT]= @CurrentDay  
					AND [OrderType] IN ('SLS', 'SLT', 'BFS')
					AND [T$PDAT_FiscalYear]=@FiscalYear
					AND [T$PDAT_FiscalPeriod]=@FiscalPeriod
		END
		ELSE
		BEGIN
			IF @Order = 'VMI'
				SELECT [Plant]
				  ,[Project]
				  ,[OEM]
				  ,[CustomerPart]
				  ,[Quantity]
				  ,[Sqft]
				FROM [Multek_ZH].[dbo].[MSS_MSSBreakdown]
				WHERE [T$JDAT]= @CurrentDay  
					AND [Plant]=@Plant 
					AND [OrderType] IN ('CNG', 'CLT')
					AND [T$PDAT_FiscalYear]=@FiscalYear
					AND [T$PDAT_FiscalPeriod]=@FiscalPeriod
			ELSE IF @Order='Total'
				SELECT [Plant]
				  ,[Project]
				  ,[OEM]
				  ,[CustomerPart]
				  ,[Quantity]
				  ,[Sqft]
				FROM [Multek_ZH].[dbo].[MSS_MSSBreakdown]
				WHERE [T$JDAT]= @CurrentDay  
					AND [Plant]=@Plant 
					AND [T$PDAT_FiscalYear]=@FiscalYear
					AND [T$PDAT_FiscalPeriod]=@FiscalPeriod
			ELSE IF @Order = 'PO'
				SELECT [Plant]
				  ,[Project]
				  ,[OEM]
				  ,[CustomerPart]
				  ,[Quantity]
				  ,[Sqft]
				FROM [Multek_ZH].[dbo].[MSS_MSSBreakdown]
				WHERE [T$JDAT]= @CurrentDay  
					AND [Plant]=@Plant 
					AND [OrderType] IN ('SLS', 'SLT', 'BFS')
					AND [T$PDAT_FiscalYear]=@FiscalYear
					AND [T$PDAT_FiscalPeriod]=@FiscalPeriod
		END
	END
	
	
	
	

	
END









GO
