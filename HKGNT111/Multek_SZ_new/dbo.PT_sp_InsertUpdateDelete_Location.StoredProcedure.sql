USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[PT_sp_InsertUpdateDelete_Location]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[PT_sp_InsertUpdateDelete_Location]
	@AutoID INT=NULL,
	@Name VARCHAR(200)=NULL,
	@Alias VARCHAR(10)=NULL,
	@Enable BIT=NULL,
	@Operation VARCHAR(10)
AS

SET NOCOUNT ON

SET @Name=LTRIM(RTRIM(ISNULL(@Name,'')))

IF @Operation='Insert' OR @Operation='Update'
	BEGIN
		IF @Name=''
			BEGIN
				RAISERROR('Sorry, [Name] can not be empty!',16,1)
				RETURN
			END
		IF @Alias=''
			BEGIN
				RAISERROR('Sorry, [Alias] can not be empty!',16,1)
				RETURN
			END
		IF LEN(RTRIM(LTRIM(@Alias)))<>3
			BEGIN
				RAISERROR('Sorry, the length of [Alias] must be 3 !',16,1)
				RETURN
			END
	END
IF @Operation='Insert' 
	BEGIN
		INSERT INTO PT_Location (Name,Alias,Enable)
			VALUES(@Name,@Alias,@Enable)
	END
IF @Operation='Update' 
	BEGIN
		BEGIN TRAN
			UPDATE PT_Location
			SET Name=@Name,Enable=@Enable,Alias=@Alias
			WHERE AutoID=@AutoID
			
			UPDATE PT_Department
			SET Enable=@Enable
			WHERE LocationAutoID=@AutoID
		IF @@ERROR=0
			BEGIN
				COMMIT TRAN
			END
		ELSE
			BEGIN
				ROLLBACK TRAN
				RAISERROR('Sorry,updating is failure, please try again or contact IT !',16,1)
				RETURN
			END
	END
IF @Operation='Delete' 
	BEGIN
		IF EXISTS(SELECT * FROM PT_Department WHERE LocationAutoID=@AutoID)
			BEGIN
				RAISERROR('Sorry, you must delete its department first!',16,1)
				RETURN
			END
		DELETE PT_Location
		WHERE AutoID=@AutoID
	END
GO
