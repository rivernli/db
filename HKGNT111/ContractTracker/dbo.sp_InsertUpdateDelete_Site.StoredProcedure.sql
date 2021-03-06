USE [ContractTracker]
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertUpdateDelete_Site]    Script Date: 11/06/2014 15:55:54 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_InsertUpdateDelete_Site]
	@AutoID INT=NULL,
	@Name VARCHAR(200),
	@Operation VARCHAR(10)
AS

SET NOCOUNT ON

SET @Name=LTRIM(RTRIM(@Name))
IF @Operation='Insert' OR @Operation='Update'
	BEGIN
		IF @Name IS NULL OR @Name=''
			BEGIN
				RAISERROR('Sorry, name can not be empty!',16,1)
				RETURN
			END
	END
IF @Operation='Insert' 
	BEGIN
		INSERT INTO Site (Name)
			VALUES(@Name)
	END
IF @Operation='Update' 
	BEGIN
		UPDATE Site
		SET Name=@Name
		WHERE AutoID=@AutoID
	END
IF @Operation='Delete' 
	BEGIN
		DELETE Site
		WHERE AutoID=@AutoID
	END
GO
