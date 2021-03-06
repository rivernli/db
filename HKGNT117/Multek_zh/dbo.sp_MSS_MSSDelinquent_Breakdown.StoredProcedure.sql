USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MSS_MSSDelinquent_Breakdown]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 


CREATE  procedure [dbo].[sp_MSS_MSSDelinquent_Breakdown]
	@OEM	VARCHAR(100)
	,@Plant  VARCHAR(50)
as
begin
	
	IF @Plant='B2F'
		SET @Plant='2F'
	IF @Plant='VVI+SUB'
		SET @Plant='HK'
	
	--CurrentDate
	DECLARE @CurrentDay DATETIME
	SELECT @CurrentDay=CONVERT(DATETIME, CONVERT(varchar(100), [UpTime] , 112)) FROM [Multek_ZH].[dbo].[MSS_UpTime]

	IF @Plant='Overall'
	BEGIN
		SELECT 
			[Project]
			,[Plant]
			,[Amount]
		FROM  [MSS_Delinquent]
		WHERE [T$JDAT]= @CurrentDay
			AND [OEM]=@OEM
	END
	ELSE
	BEGIN
		SELECT 
			[Project]
			,[Plant]
			,[Amount]
		FROM  [MSS_Delinquent]
		WHERE [T$JDAT]= @CurrentDay
			AND [OEM]=@OEM
			AND [Plant]=@Plant
	END
	
	
	
	
END









GO
