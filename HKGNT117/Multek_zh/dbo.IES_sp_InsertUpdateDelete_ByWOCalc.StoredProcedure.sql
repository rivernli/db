USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[IES_sp_InsertUpdateDelete_ByWOCalc]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IES_sp_InsertUpdateDelete_ByWOCalc] 	
		@ID INT=NULL,
		@Building VARCHAR(50)=NULL,
		@Project VARCHAR(50)=NULL,
		@Customer VARCHAR(200)=NULL,
		@CalendarDate DATETIME=NULL,
		@BookingQty DECIMAL(18, 2)=NULL,
		@BacklogSqFt DECIMAL(18, 2)=NULL,
		@ProductionType VARCHAR(50)=NULL,
		@Operation VARCHAR(10)=NULL
AS

DECLARE @Year INT
DECLARE @Month INT
DECLARE @YearWeek INT

IF @Operation='Insert' 
	BEGIN
			SELECT @Year = Year(CalendarDate), @Month = [Month], @YearWeek = YearWeek FROM IES_Calendar WHERE CalendarDate = @CalendarDate
		INSERT INTO IES_ByWoCalc(Building, Project, Customer, CalendarDate, BookingQty, BacklogSqFt, Year, Month, YearWeek,ProductionType)
		VALUES(@Building, @Project, @Customer, @CalendarDate, @BookingQty, @BacklogSqFt, @Year, @Month, @YearWeek,@ProductionType)
		RETURN @@IDENTITY 
	END

IF @Operation='Update' 
	BEGIN
		SELECT @Year = Year(CalendarDate), @Month = [Month], @YearWeek = YearWeek FROM IES_Calendar WHERE CalendarDate = @CalendarDate
		UPDATE IES_ByWoCalc
		SET Building=@Building, Project=@Project, Customer=@Customer, CalendarDate=@CalendarDate, BookingQty=@BookingQty, BacklogSqFt=@BacklogSqFt, Year=@Year, Month=@Month, YearWeek=@YearWeek, ProductionType=@ProductionType
		WHERE ID=@ID
		RETURN @ID 
	END
IF @Operation='Delete' 
	BEGIN
		DELETE FROM IES_ByWoCalc WHERE ID=@ID
		RETURN @ID
	END

GO
