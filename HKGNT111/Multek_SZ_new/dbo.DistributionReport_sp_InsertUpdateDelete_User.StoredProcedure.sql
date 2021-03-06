USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[DistributionReport_sp_InsertUpdateDelete_User]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DistributionReport_sp_InsertUpdateDelete_User]
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
		INSERT INTO DistributionReport_Users (UserID,Region,Account,BDM,Email,Administrator,Enable)
			VALUES(@UserID,@Domain,@Account,@BDM,@Email,@Administrator,@Enable)
	END
IF @Operation='Update' 
	BEGIN
		DECLARE @OldAccount VARCHAR(100),@NewAccount VARCHAR(100)
		SET @OldAccount=(SELECT Region+'\'+Account FROM DistributionReport_Users WHERE AutoID=@AutoID)
		SET @NewAccount=@Domain+'\'+@Account

		UPDATE DistributionReport_Users
		SET UserID=@UserID,Region=@Domain,Account=@Account,BDM=@BDM,Email=@Email,Administrator=@Administrator,Enable=@Enable
		WHERE AutoID=@AutoID
		
		EXECUTE sp_Automatically_Update_User_Information @OldAccount,@NewAccount
		
	END
IF @Operation='Delete' 
	BEGIN
		DELETE DistributionReport_Users
		WHERE AutoID=@AutoID
	END

IF @Operation='Insert' OR @Operation='Update'
	BEGIN
		--Initial user's menus
		INSERT INTO DistributionReport_Authority (UserID,MenuID)
		SELECT b.UserID,a.ID
		FROM DistributionReport_Menu a,DistributionReport_Users b
		WHERE a.ID+b.UserID NOT IN (
							SELECT MenuID+UserID
							FROM  DistributionReport_Authority
							   )

		DELETE DistributionReport_Authority
		WHERE MenuID NOT IN (
						SELECT ID
						FROM DistributionReport_Menu
					 )

		--Initial Administrator's authority
		UPDATE DistributionReport_Authority
		SET CanSee=1
		WHERE UserID IN
			(SELECT UserID FROM DistributionReport_Users WHERE Administrator=1)

		UPDATE DistributionReport_Authority
		SET CanSee=1
		WHERE MenuID IN ('00001')
		
		--EXECUTE DistributionReport_sp_Update_User_Customer_Role
	END
GO
