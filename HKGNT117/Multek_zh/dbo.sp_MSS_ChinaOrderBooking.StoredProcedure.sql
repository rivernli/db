USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_MSS_ChinaOrderBooking]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 


CREATE  procedure [dbo].[sp_MSS_ChinaOrderBooking]

as
begin
	
	SELECT  
		[Period]
		,[Description]
		,[B1]
		,[B2F]
		,[B3]
		,[B4]
		,[B5]
		,[VVI]
		,[Overall]
	FROM [Multek_ZH].[dbo].[MSS_ChinaOrderBooking]


	
END









GO
