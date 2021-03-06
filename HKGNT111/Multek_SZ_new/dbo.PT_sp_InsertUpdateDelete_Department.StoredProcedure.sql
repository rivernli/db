USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[PT_sp_InsertUpdateDelete_Department]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[PT_sp_InsertUpdateDelete_Department]
	@LocationAutoID INT=NULL,
	@AutoID INT=NULL,
	@Name VARCHAR(50)=NULL,
	@Distribution VARCHAR(200)=NULL,
	@Enable BIT=NULL,
	@CreatePT BIT=NULL,
	@Operation VARCHAR(10)
AS

SET NOCOUNT ON

SET @Name=LTRIM(RTRIM(ISNULL(@Name,'')))
SET @Distribution=LTRIM(RTRIM(ISNULL(@Distribution,'')))

IF @Operation='Insert' OR @Operation='Update'
	BEGIN
		IF @LocationAutoID IS NULL OR @LocationAutoID=0
			BEGIN
				RAISERROR('Sorry, [Site] can not be empty!',16,1)
				RETURN
			END
		IF @Name=''
			BEGIN
				RAISERROR('Sorry, [Name] can not be empty!',16,1)
				RETURN
			END
		IF (SELECT ISNULL(Enable,0) FROM PT_Location WHERE AutoID=@LocationAutoID)=0
			BEGIN
				SET @Enable=0
			END
	END
IF @Operation='Insert' 
	BEGIN
		BEGIN TRAN
		INSERT INTO PT_Department (LocationAutoID,Name,Distribution,Enable,CreatePT)
			VALUES(@LocationAutoID,@Name,@Distribution,@Enable,@CreatePT)
		INSERT INTO PT_Department_checklist(DepartmentAutoID,CheckListAutoID)
		SELECT @@IDENTITY,AutoID FROM PT_CheckList
	IF @@ERROR=0
		BEGIN
			COMMIT TRAN
		END
	ELSE
		BEGIN
			ROLLBACK TRAN
		END

	END
IF @Operation='Update' 
	BEGIN
		IF @Enable=0 AND EXISTS(SELECT * FROM PT_Order WHERE (TransferingDepartmentAutoID=@AutoID OR ReceivingDepartmentAutoID=@AutoID) AND Closed=0)
			BEGIN
				RAISERROR('Sorry, you can not disable the department for it has unclosed order !',16,1)
				RETURN
			END
		UPDATE PT_Department
		SET LocationAutoID=@LocationAutoID,Name=@Name,Enable=@Enable,Distribution=@Distribution,CreatePT=@CreatePT
		WHERE AutoID=@AutoID
	END
IF @Operation='Delete' 
	BEGIN
		IF EXISTS(SELECT * FROM PT_Order WHERE (TransferingDepartmentAutoID=@AutoID OR ReceivingDepartmentAutoID=@AutoID) AND Closed=0)
			BEGIN
				RAISERROR('Sorry, you can not delete the department for it has unclosed order !',16,1)
				RETURN
			END
		DELETE PT_Department
		WHERE AutoID=@AutoID
	END
GO
