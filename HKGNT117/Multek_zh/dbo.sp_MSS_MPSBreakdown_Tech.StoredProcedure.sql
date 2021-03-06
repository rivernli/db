USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MSS_MPSBreakdown_Tech]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 


CREATE  procedure [dbo].[sp_MSS_MPSBreakdown_Tech]
	@Plant	VARCHAR(10)
	,@Tech	VARCHAR(50)
	,@FiscalYear	VARCHAR(50)
	,@FiscalPeriod	VARCHAR(10)
as
begin
	--CurrentDate
	DECLARE @CurrentDay DATETIME
	SET @CurrentDay=CONVERT(DATETIME, CONVERT(varchar(100), getdate(), 112))
	SELECT @CurrentDay=CONVERT(DATETIME, CONVERT(varchar(100), [UpTime] , 112)) FROM [Multek_ZH].[dbo].[MSS_UpTime]
	
	IF @Tech='NULL'
		SET @Tech = NULL

	IF @FiscalYear='After Period'
	BEGIN
		IF @Plant='ALL'
		BEGIN
			IF @Tech='Total'
				SELECT [Plant]
				  ,[Project]
				  ,[OEM]
				  ,[CustomerPart]
				  ,[Quantity]
				  ,[Sqft]
				FROM [Multek_ZH].[dbo].[MSS_MPSBreakdown]
				WHERE [T$JDAT]= @CurrentDay 
					AND [T$WODT_FiscalYear] IS NULL
			ELSE
				SELECT [Plant]
				  ,[Project]
				  ,[OEM]
				  ,[CustomerPart]
				  ,[Quantity]
				  ,[Sqft]
				FROM [Multek_ZH].[dbo].[MSS_MPSBreakdown]
				WHERE [T$JDAT]= @CurrentDay  
					AND [Technology]=@Tech
					AND [T$WODT_FiscalYear] IS NULL
					
		END
		ELSE
		BEGIN
			IF @Tech='Total'
				SELECT [Plant]
				  ,[Project]
				  ,[OEM]
				  ,[CustomerPart]
				  ,[Quantity]
				  ,[Sqft]
				FROM [Multek_ZH].[dbo].[MSS_MPSBreakdown]
				WHERE [T$JDAT]= @CurrentDay  
					AND [Plant]=@Plant 
					AND [T$WODT_FiscalYear] IS NULL
			ELSE
				SELECT [Plant]
				  ,[Project]
				  ,[OEM]
				  ,[CustomerPart]
				  ,[Quantity]
				  ,[Sqft]
				FROM [Multek_ZH].[dbo].[MSS_MPSBreakdown]
				WHERE [T$JDAT]= @CurrentDay  
					AND [Plant]=@Plant 
					AND [Technology]=@Tech
					AND [T$WODT_FiscalYear] IS NULL
		END
	END
	--'After Period' END
	
	ELSE IF @FiscalYear='Buffer Order' 
	BEGIN
		IF @Plant='ALL'
		BEGIN
			IF @Tech='Total'
				SELECT [Plant]
				  ,[Project]
				  ,[OEM]
				  ,[CustomerPart]
				  ,[Quantity]
				  ,[Sqft]
				FROM [Multek_ZH].[dbo].[MSS_MPSBreakdown]
				WHERE [T$JDAT]= @CurrentDay  
					AND [T$WODT_FiscalYear] = '2099' AND [T$WODT_FiscalPeriod] = 1
			ELSE
				SELECT [Plant]
				  ,[Project]
				  ,[OEM]
				  ,[CustomerPart]
				  ,[Quantity]
				  ,[Sqft]
				FROM [Multek_ZH].[dbo].[MSS_MPSBreakdown]
				WHERE [T$JDAT]= @CurrentDay  
					AND [Technology]=@Tech
					AND [T$WODT_FiscalYear] = '2099' AND [T$WODT_FiscalPeriod] = 1
		END
		ELSE
		BEGIN
			IF @Tech='Total'
				SELECT [Plant]
				  ,[Project]
				  ,[OEM]
				  ,[CustomerPart]
				  ,[Quantity]
				  ,[Sqft]
				FROM [Multek_ZH].[dbo].[MSS_MPSBreakdown]
				WHERE [T$JDAT]= @CurrentDay  
					AND [Plant]=@Plant 
					AND [T$WODT_FiscalYear] = '2099' AND [T$WODT_FiscalPeriod] = 1
			ELSE
				SELECT [Plant]
				  ,[Project]
				  ,[OEM]
				  ,[CustomerPart]
				  ,[Quantity]
				  ,[Sqft]
				FROM [Multek_ZH].[dbo].[MSS_MPSBreakdown]
				WHERE [T$JDAT]= @CurrentDay  
					AND [Plant]=@Plant 
					AND [Technology]=@Tech
					AND [T$WODT_FiscalYear] = '2099' AND [T$WODT_FiscalPeriod] = 1
		END
	END
	--'Buffer Order' END
	
	ELSE IF @FiscalYear ='Overall' 
	BEGIN
		IF @Plant='ALL'
		BEGIN
			IF @Tech='Total'
				SELECT [Plant]
				  ,[Project]
				  ,[OEM]
				  ,[CustomerPart]
				  ,[Quantity]
				  ,[Sqft]
				FROM [Multek_ZH].[dbo].[MSS_MPSBreakdown]
				WHERE [T$JDAT]= @CurrentDay  
			ELSE
				SELECT [Plant]
				  ,[Project]
				  ,[OEM]
				  ,[CustomerPart]
				  ,[Quantity]
				  ,[Sqft]
				FROM [Multek_ZH].[dbo].[MSS_MPSBreakdown]
				WHERE [T$JDAT]= @CurrentDay  
					AND [Technology]=@Tech
		END
		ELSE
		BEGIN
			IF @Tech='Total'
				SELECT [Plant]
				  ,[Project]
				  ,[OEM]
				  ,[CustomerPart]
				  ,[Quantity]
				  ,[Sqft]
				FROM [Multek_ZH].[dbo].[MSS_MPSBreakdown]
				WHERE [T$JDAT]= @CurrentDay  
					AND [Plant]=@Plant 
			ELSE
				SELECT [Plant]
				  ,[Project]
				  ,[OEM]
				  ,[CustomerPart]
				  ,[Quantity]
				  ,[Sqft]
				FROM [Multek_ZH].[dbo].[MSS_MPSBreakdown]
				WHERE [T$JDAT]= @CurrentDay  
					AND [Plant]=@Plant 
					AND [Technology]=@Tech
		END
	END
	--'Overall'  END
	
	ELSE 
	BEGIN
		IF @Plant='ALL'
		BEGIN
			IF @Tech='Total'
				SELECT [Plant]
				  ,[Project]
				  ,[OEM]
				  ,[CustomerPart]
				  ,[Quantity]
				  ,[Sqft]
				FROM [Multek_ZH].[dbo].[MSS_MPSBreakdown]
				WHERE [T$JDAT]= @CurrentDay  
					AND [T$WODT_FiscalYear]=@FiscalYear
					AND [T$WODT_FiscalPeriod]=@FiscalPeriod
			ELSE
				SELECT [Plant]
				  ,[Project]
				  ,[OEM]
				  ,[CustomerPart]
				  ,[Quantity]
				  ,[Sqft]
				FROM [Multek_ZH].[dbo].[MSS_MPSBreakdown]
				WHERE [T$JDAT]= @CurrentDay  
					AND [Technology]=@Tech
					AND [T$WODT_FiscalYear]=@FiscalYear
					AND [T$WODT_FiscalPeriod]=@FiscalPeriod
		END
		ELSE
		BEGIN
			IF @Tech='Total'
				SELECT [Plant]
				  ,[Project]
				  ,[OEM]
				  ,[CustomerPart]
				  ,[Quantity]
				  ,[Sqft]
				FROM [Multek_ZH].[dbo].[MSS_MPSBreakdown]
				WHERE [T$JDAT]= @CurrentDay  
					AND [Plant]=@Plant 
					AND [T$WODT_FiscalYear]=@FiscalYear
					AND [T$WODT_FiscalPeriod]=@FiscalPeriod
			ELSE
				SELECT [Plant]
				  ,[Project]
				  ,[OEM]
				  ,[CustomerPart]
				  ,[Quantity]
				  ,[Sqft]
				FROM [Multek_ZH].[dbo].[MSS_MPSBreakdown]
				WHERE [T$JDAT]= @CurrentDay  
					AND [Plant]=@Plant 
					AND [Technology]=@Tech
					AND [T$WODT_FiscalYear]=@FiscalYear
					AND [T$WODT_FiscalPeriod]=@FiscalPeriod
		END
	END
	
	
	
	

	
END









GO
