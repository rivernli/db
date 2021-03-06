USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[QualityReport_sp_InsertUpdateDelete_User]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[QualityReport_sp_InsertUpdateDelete_User]
	@AutoID INT=NULL,
	@Domain VARCHAR(50)=NULL,
	@Account VARCHAR(50)=NULL,
	@BDM VARCHAR(50)=NULL,
	@Email VARCHAR(100)=NULL,
	@Administrator BIT=NULL,
	@Enable BIT=NULL,
	@Operation VARCHAR(10)
AS

SET NOCOUNT ON

DECLARE @UserID VARCHAR(50) 

SET @Domain=LTRIM(RTRIM(@Domain))
SET @Account=LTRIM(RTRIM(@Account))
SET @BDM=LTRIM(RTRIM(@BDM))
SET @Email=LTRIM(RTRIM(@Email))

IF @Operation='Insert' OR @Operation='Update'
	BEGIN
		IF @Domain IS NULL OR @Domain=''
			BEGIN
				RAISERROR('Sorry, [domain] can not be empty!',16,1)
				RETURN
			END
		IF @Account IS NULL OR @Account=''
			BEGIN
				RAISERROR('Sorry, [account] can not be empty!',16,1)
				RETURN
			END
		IF @BDM IS NULL OR @BDM=''
			BEGIN
				RAISERROR('Sorry, [name] can not be empty!',16,1)
				RETURN
			END
		IF @Email IS NULL OR @Email=''
			BEGIN
				RAISERROR('Sorry, [Eamil] can not be empty!',16,1)
				RETURN
			END
		SET @UserID=@Domain+'\'+@Account
	END
IF @Operation='Insert' 
	BEGIN
		INSERT INTO QualityReport_Users (UserID,Region,Account,BDM,Email,Administrator,Enable)
			VALUES(@UserID,@Domain,@Account,@BDM,@Email,@Administrator,@Enable)
	END
IF @Operation='Update' 
	BEGIN
		UPDATE QualityReport_Users
		SET UserID=@UserID,Region=@Domain,Account=@Account,BDM=@BDM,Email=@Email,Administrator=@Administrator,Enable=@Enable
		WHERE AutoID=@AutoID
		
		DECLARE @OldAccount VARCHAR(100),@NewAccount VARCHAR(100)
		SET @OldAccount=(SELECT Region+'\'+Account FROM QualityReport_Users WHERE AutoID=@AutoID)
		SET @NewAccount=@Domain+'\'+@Account
		EXECUTE sp_Automatically_Update_User_Information @OldAccount,@NewAccount

	END
IF @Operation='Delete' 
	BEGIN
		DELETE QualityReport_Users
		WHERE AutoID=@AutoID
	END

IF @Operation='Insert' OR @Operation='Update'
	BEGIN
		--Initial user's menus
		INSERT INTO QualityReport_Authority (UserID,MenuID)
		SELECT b.UserID,a.ID
		FROM QualityReport_Menu a,QualityReport_Users b
		WHERE a.ID+b.UserID NOT IN (
							SELECT MenuID+UserID
							FROM  QualityReport_Authority
							   )

		DELETE QualityReport_Authority
		WHERE MenuID NOT IN (
						SELECT ID
						FROM QualityReport_Menu
					 )

		--Initial Administrator's authority
		UPDATE QualityReport_Authority
		SET CanSee=1
		WHERE UserID IN
			(SELECT UserID FROM QualityReport_Users WHERE Administrator=1)

		UPDATE QualityReport_Authority
		SET CanSee=1
		WHERE MenuID IN ('00001')
	END
GO
