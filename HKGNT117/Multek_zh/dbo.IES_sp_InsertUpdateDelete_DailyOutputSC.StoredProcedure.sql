USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[IES_sp_InsertUpdateDelete_DailyOutputSC]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[IES_sp_InsertUpdateDelete_DailyOutputSC] 	
		@ID INT=NULL,
		@Building VARCHAR(50)=NULL,
		@Project VARCHAR(50)=NULL,
		@OutputDate DATETIME=NULL,
		@Operation VARCHAR(10)
AS

DECLARE @Month INT
DECLARE @YearWeek INT
		
IF @Operation='Insert' 
	BEGIN
		SELECT @Month = [Month], @YearWeek = YearWeek FROM IES_Calendar WHERE CalendarDate = @OutputDate
		INSERT INTO IES_DailyOutputSC(Building, Project, OutputDate, [Month], YearWeek)
		VALUES(@Building, @Project, @OutputDate, @Month, @YearWeek)
	RETURN @@IDENTITY 
	END

IF @Operation='Update' 
	BEGIN
		SELECT @Month = [Month], @YearWeek = YearWeek FROM IES_Calendar WHERE CalendarDate = @OutputDate
		UPDATE IES_DailyOutputSC 
			SET Building=@Building, Project=@Project, OutputDate=@OutputDate, [Month]=@Month, @YearWeek=YearWeek
		WHERE ID=@ID 	
	RETURN @ID 
	END
IF @Operation='Delete' 
	BEGIN
		DELETE FROM IES_DailyOutputSC_SubOutput WHERE PJID = @ID
		DELETE FROM IES_DailyOutputSC WHERE ID=@ID 	
	END




GO
