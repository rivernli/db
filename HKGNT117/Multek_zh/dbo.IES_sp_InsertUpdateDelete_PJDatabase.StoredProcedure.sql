USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[IES_sp_InsertUpdateDelete_PJDatabase]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IES_sp_InsertUpdateDelete_PJDatabase] 	
		@ID INT=NULL,
		@PID INT=NULL,
		@Building VARCHAR(50)=NULL,
		@Project VARCHAR(50)=NULL,
		@Type INT=NULL,
		@Unit DECIMAL(18,4)=NULL,
		@Sqft DECIMAL(18,4)=NULL,
		@AdjustYield DECIMAL(18,4)=NULL,
		@Operation VARCHAR(10)
AS

IF @Operation='Insert' 
	BEGIN
		INSERT INTO IES_PJDatabase(PID, Building, Project, Unit, Sqft, AdjustYield)
		VALUES(@PID, @Building, @Project, @Unit, @Sqft, @AdjustYield)
	RETURN @@IDENTITY 
	END

IF @Operation='Update' 
	BEGIN
		UPDATE IES_PJDatabase
		SET PID=@PID, Building=@Building, Project=@Project, Unit=@Unit, Sqft=@Sqft, AdjustYield=@AdjustYield
		WHERE ID=@ID 	
	RETURN @ID 
	END
IF @Operation='Delete' 
	BEGIN
		DELETE FROM IES_PJDatabase_CycleTime WHERE PJID IN(SELECT ID FROM IES_PJDatabase WHERE PID = @ID)
		DELETE FROM IES_PJDatabase_SubCycleTime WHERE PJID IN(SELECT ID FROM IES_PJDatabase WHERE PID = @ID)
		DELETE FROM IES_PJDatabase WHERE PID = @ID
		DELETE FROM IES_PJDatabase_CycleTime WHERE PJID = @ID
		DELETE FROM IES_PJDatabase_SubCycleTime WHERE PJID = @ID
		DELETE FROM IES_PJDatabase WHERE ID=@ID 	
	END

GO
