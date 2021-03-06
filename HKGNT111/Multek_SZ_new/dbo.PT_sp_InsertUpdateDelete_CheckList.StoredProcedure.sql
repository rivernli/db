USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[PT_sp_InsertUpdateDelete_CheckList]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[PT_sp_InsertUpdateDelete_CheckList]
	@AutoID INT=NULL,
	@Name VARCHAR(200)=NULL,
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
	END
IF @Operation='Insert' 
	BEGIN
		INSERT INTO PT_CheckList (Name,Enable)
			VALUES(@Name,@Enable)
	END
IF @Operation='Update' 
	BEGIN
		UPDATE PT_CheckList
		SET Name=@Name,Enable=@Enable
		WHERE AutoID=@AutoID
	END
IF @Operation='Delete' 
	BEGIN
		DELETE PT_CheckList
		WHERE AutoID=@AutoID
	END
GO
