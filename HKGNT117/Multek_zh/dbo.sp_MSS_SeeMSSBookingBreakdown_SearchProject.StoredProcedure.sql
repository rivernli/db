USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MSS_SeeMSSBookingBreakdown_SearchProject]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 


CREATE  procedure [dbo].[sp_MSS_SeeMSSBookingBreakdown_SearchProject]
	@Value	VARCHAR(50)
as
begin
	--CurrentDate
	DECLARE @CurrentDay DATETIME
	SELECT @CurrentDay=CONVERT(DATETIME, CONVERT(varchar(100), [UpTime] , 112)) FROM [Multek_ZH].[dbo].[MSS_UpTime]


	
	SELECT 
		[Project]
	FROM [MSS_MSSBreakdown]
	WHERE [T$JDAT]=@CurrentDay
			AND( [Project4Char] = @Value 
			OR [OEM] = @Value )
	GROUP BY [Project]	
	ORDER BY [Project]

	
END









GO
