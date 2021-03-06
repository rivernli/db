USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[IES_sp_Update_WorkingDay]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IES_sp_Update_WorkingDay] 	
		@ID INT,
		@WorkingDay INT=NULL
AS
	UPDATE IES_Calendar 
		SET IES_Calendar.WorkingDay = @WorkingDay
	FROM IES_Calendar INNER JOIN IES_Calendar t 
		ON IES_Calendar.[Year] = t.[Year] 
			AND IES_Calendar.[YearWeek] =t.[YearWeek] 
			AND IES_Calendar.[Building] = t.[Building] 
		WHERE t.ID = @ID

GO
