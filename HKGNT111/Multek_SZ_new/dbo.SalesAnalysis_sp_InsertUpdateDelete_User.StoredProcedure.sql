USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[SalesAnalysis_sp_InsertUpdateDelete_User]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SalesAnalysis_sp_InsertUpdateDelete_User]
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
		INSERT INTO SalesAnalysis_Users (UserID,Region,Account,BDM,Email,Administrator,Enable)
			VALUES(@UserID,@Domain,@Account,@BDM,@Email,@Administrator,@Enable)
	END
IF @Operation='Update' 
	BEGIN
		UPDATE SalesAnalysis_Users
		SET UserID=@UserID,Region=@Domain,Account=@Account,BDM=@BDM,Email=@Email,Administrator=@Administrator,Enable=@Enable
		WHERE AutoID=@AutoID
	END
IF @Operation='Delete' 
	BEGIN
		DELETE SalesAnalysis_Users
		WHERE AutoID=@AutoID
	END

IF @Operation='Insert' OR @Operation='Update'
	BEGIN
		--Initial user's menus
		INSERT INTO SalesAnalysis_Authority (UserID,MenuID)
		SELECT b.UserID,a.ID
		FROM SalesAnalysis_Menu a,SalesAnalysis_Users b
		WHERE a.ID+b.UserID NOT IN (
							SELECT MenuID+UserID
							FROM  SalesAnalysis_Authority
							   )

		DELETE SalesAnalysis_Authority
		WHERE MenuID NOT IN (
						SELECT ID
						FROM SalesAnalysis_Menu
					 )

		--Initial Administrator's authority
		UPDATE SalesAnalysis_Authority
		SET CanSee=1
		WHERE UserID IN
			(SELECT UserID FROM SalesAnalysis_Users WHERE Administrator=1)

		UPDATE SalesAnalysis_Authority
		SET CanSee=1
		WHERE MenuID IN ('00001')
	END
GO
