USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Cancellation_sp_InsertUpdateDelete_User]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Cancellation_sp_InsertUpdateDelete_User]
	@AutoID INT=NULL,
	@Domain VARCHAR(50)=NULL,
	@Account VARCHAR(50)=NULL,
	@BDM VARCHAR(50)=NULL,
	@Email VARCHAR(100)=NULL,
	@Administrator BIT=NULL,
	@Enable BIT=NULL,
	@Department NVARCHAR(50),
	@Jobtitle	NVARCHAR(50),
	@Tel		NVARCHAR(50),
	@Mobile		NVARCHAR(50),
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
				RAISERROR('Sorry, [Name] can not be empty!',16,1)
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
		INSERT INTO Cancellation_Users (UserID,Region,Account,BDM,Email,Administrator,Enable,hideFrLog,department,jobTitle,tel,Mobile)
			VALUES(@UserID,@Domain,@Account,@BDM,@Email,@Administrator,@Enable,0,@Department,@Jobtitle,@Tel,@Mobile	)
	END
IF @Operation='Update' 
	BEGIN
		--UPDATE Cost_Sheet_Query_Users
		--SET UserID=@UserID,Region=@Domain,Account=@Account,BDM=@BDM,Email=@Email,Administrator=@Administrator,Enable=@Enable,department=@Department,jobTitle=@Jobtitle,tel=@Tel,Mobile=@Mobile
		--WHERE AutoID=@AutoID
		UPDATE Cancellation_Users
		SET Administrator=@Administrator,Enable=@Enable
		WHERE UserID=@UserID
	END
IF @Operation='Delete' 
	BEGIN
		DELETE Cancellation_Users
		WHERE AutoID=@AutoID
		--WHERE UserID=@UserID
	END

--IF @Operation='Insert' OR @Operation='Update'
--	BEGIN
--		--Initial user's menus
--		INSERT INTO EXR2_Authority (UserID,MenuID)
--		SELECT b.UserID,a.ID
--		FROM EXR2_Menu a,EXR2_Users b
--		WHERE a.ID+b.UserID NOT IN (
--							SELECT MenuID+UserID
--							FROM  EXR2_Authority
--							   )
--
--		DELETE EXR2_Authority
--		WHERE MenuID NOT IN (
--						SELECT ID
--						FROM EXR2_Menu
--					 )
--
--		--Initial Administrator's authority
--		UPDATE EXR2_Authority
--		SET CanSee=1
--		WHERE UserID IN
--			(SELECT UserID FROM EXR2_Users WHERE Administrator=1)
--
--		UPDATE EXR2_Authority
--		SET CanSee=1
--		WHERE MenuID IN ('00001')
--	END



GO
