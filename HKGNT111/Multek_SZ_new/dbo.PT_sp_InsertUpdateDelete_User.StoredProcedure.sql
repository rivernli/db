USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[PT_sp_InsertUpdateDelete_User]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[PT_sp_InsertUpdateDelete_User]
	@AutoID INT=NULL,
	@Department INT=NULL,
	@Domain VARCHAR(50)=NULL,
	@Account VARCHAR(50)=NULL,
	@BDM VARCHAR(50)=NULL,
	@Email VARCHAR(100)=NULL,
	@Phone VARCHAR(100)=NULL,
	@Position VARCHAR(100)=NULL,
	@Administrator BIT=NULL,
	@Enable BIT=NULL,
	@SiteOwner BIT=NULL,
	@Operation VARCHAR(10)=NULL,
	@OperatorUserID VARCHAR(50)=NULL
AS

SET NOCOUNT ON

DECLARE @UserID VARCHAR(50) ,@OldUserID VARCHAR(50)

SET @Domain=LTRIM(RTRIM(@Domain))
SET @Account=LTRIM(RTRIM(@Account))
SET @BDM=LTRIM(RTRIM(@BDM))
SET @Email=LTRIM(RTRIM(@Email))
SET @Email=REPLACE(@Email,' ','')

IF @Operation='Insert' OR @Operation='Update'
	BEGIN
		IF @Department IS NULL OR @Department=0
			BEGIN
				RAISERROR('Sorry,[department] can not be empty!',16,1)
				RETURN
			END

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
		IF CHARINDEX('@',@Email)=0 OR CHARINDEX('.COM',@Email)=0
			BEGIN
				RAISERROR('Sorry, [Eamil] is invalid!',16,1)
				RETURN
			END
		
		SET @UserID=@Domain+'\'+@Account
	END
IF @Operation='Insert' 
	BEGIN
		INSERT INTO PT_Users (DepartmentAutoID,UserID,Region,Account,BDM,Email,Administrator,Enable,SiteOwner,Phone,Position)
						VALUES(@Department,@UserID,@Domain,@Account,@BDM,@Email,@Administrator,@Enable,@SiteOwner,@Phone,@Position)
	END
IF @Operation='Update' 
	BEGIN
		IF @Domain<>(SELECT Region FROM PT_Users WHERE AutoID=@AutoID ) OR @Account<>(SELECT Account FROM PT_Users WHERE AutoID=@AutoID )
			BEGIN
				SET @OldUserID=(SELECT UserID FROM PT_Users WHERE AutoID=@AutoID )
				IF EXISTS(
							SELECT * 
							FROM PT_Order 
							WHERE TransferingSiteOwnerUserID=@OldUserID
								OR ReceivingSiteOwnerUserID=@OldUserID
								OR CreatedUserID=@OldUserID
								OR DeletedUserID=@OldUserID
								OR LastUpdatedUserID=@OldUserID
						 )
					BEGIN
						UPDATE PT_Order 
						SET TransferingSiteOwnerUserID=@UserID
						WHERE TransferingSiteOwnerUserID=@OldUserID
						UPDATE PT_Order 
						SET ReceivingSiteOwnerUserID=@UserID
						WHERE ReceivingSiteOwnerUserID=@OldUserID
						UPDATE PT_Order 
						SET CreatedUserID=@UserID
						WHERE CreatedUserID=@OldUserID
						UPDATE PT_Order 
						SET DeletedUserID=@UserID
						WHERE DeletedUserID=@OldUserID
						UPDATE PT_Order 
						SET LastUpdatedUserID=@UserID
						WHERE LastUpdatedUserID=@OldUserID
						--RAISERROR('Sorry,you can not update the users domain or account for he has some orders !',16,1)
						--RETURN
					END

				UPDATE PT_Order_CheckList_Comment
				SET UserID=@UserID
				WHERE UserID=@OldUserID
					
				IF EXISTS(
							SELECT * 
							FROM PT_Order_CheckList_Detail
							WHERE TransferUserID=@OldUserID
						 )
					BEGIN
						UPDATE PT_Order_CheckList_Detail
						SET TransferUserID=@UserID
						WHERE TransferUserID=@OldUserID
						--RAISERROR('Sorry,you can not update the users for he uploaded some files !',16,1)
						--RETURN
					END
				IF EXISTS(
							SELECT * 
							FROM PT_Order_CheckList_Detail_DownLoad
							WHERE ReceivingDownloadUserID=@OldUserID
						 )
					BEGIN
						UPDATE PT_Order_CheckList_Detail_DownLoad
						SET ReceivingDownloadUserID=@UserID
						WHERE ReceivingDownloadUserID=@OldUserID
						--RAISERROR('Sorry,you can not update the users for he downloaded some files !',16,1)
						--RETURN
					END

			END
		UPDATE PT_Users
		SET DepartmentAutoID=@Department,SiteOwner=@SiteOwner,UserID=@UserID,Region=@Domain,Account=@Account,BDM=@BDM,
			Email=@Email,Administrator=@Administrator,Enable=@Enable,Phone=@Phone,Position=@Position
		WHERE AutoID=@AutoID
		
		DECLARE @OldAccount VARCHAR(100),@NewAccount VARCHAR(100)
		SET @OldAccount=(SELECT Region+'\'+Account FROM PT_Users WHERE AutoID=@AutoID)
		SET @NewAccount=@Domain+'\'+@Account
		EXECUTE sp_Automatically_Update_User_Information @OldAccount,@NewAccount

	END
IF @Operation='Delete' 
	BEGIN
		SET @UserID=(SELECT UserID FROM PT_Users WHERE AutoID=@AutoID)
		IF EXISTS(
					SELECT * 
					FROM PT_Order 
					WHERE TransferingSiteOwnerUserID=@UserID 
						OR ReceivingSiteOwnerUserID=@UserID
						OR CreatedUserID=@UserID
						OR DeletedUserID=@UserID
						OR LastUpdatedUserID=@UserID
				 )
			BEGIN
				RAISERROR('Sorry,you can not delete the users for he has some orders !',16,1)
				RETURN
			END
		IF EXISTS(
					SELECT * 
					FROM PT_Order_CheckList_Detail
					WHERE TransferUserID=@UserID 
				 )
			BEGIN
				RAISERROR('Sorry,you can not delete the users for he uploaded some files !',16,1)
				RETURN
			END
		IF EXISTS(
					SELECT * 
					FROM PT_Order_CheckList_Detail_DownLoad
					WHERE ReceivingDownloadUserID=@UserID 
				 )
			BEGIN
				RAISERROR('Sorry,you can not delete the users for he downloaded some files !',16,1)
				RETURN
			END

		IF NOT EXISTS(
						SELECT * FROM PT_Users WHERE UserID=@OperatorUserID AND Administrator=1
					 )
			BEGIN
				IF EXISTS(
							SELECT * FROM PT_Users WHERE AutoID=@AutoID AND Administrator=1
						 )
					BEGIN
						RAISERROR('Sorry, you have not authority to delete an administrator!',16,1)
						RETURN
					END
			END

		DELETE PT_Users
		WHERE AutoID=@AutoID
	END

IF @Operation='Insert' OR @Operation='Update'
	BEGIN
		--Initial user's menus
		INSERT INTO PT_Authority (UserID,MenuID)
		SELECT b.UserID,a.ID
		FROM PT_Menu a,PT_Users b
		WHERE a.ID+b.UserID NOT IN (
							SELECT MenuID+UserID
							FROM  PT_Authority
							   )

		DELETE PT_Authority
		WHERE MenuID NOT IN (
						SELECT ID
						FROM PT_Menu
					 )

		EXECUTE PT_Initial_User_Authority
	END

UPDATE PT_Order
SET ReceivingSiteOwnerUserID=(SELECT TOP 1 b.UserID FROM PT_Users b,PT_Department c WHERE b.DepartmentAutoID=c.AutoID AND b.Enable=1 AND b.SiteOwner=1 AND c.LocationAutoID=(SELECT AutoID FROM PT_Location WHERE Alias=SUBSTRING(OrderNo,4,3)) ORDER BY b.UserID DESC)
WHERE PT_Order.Closed=0
	AND PT_Order.ReceivingSiteOwnerApprove=0
	AND NOT EXISTS(SELECT * FROM PT_Users d WHERE d.UserID=PT_Order.ReceivingSiteOwnerUserID AND d.Enable=1 AND d.SiteOwner=1 )
	
UPDATE PT_Order
SET TransferingSiteOwnerUserID=(SELECT TOP 1 b.UserID FROM PT_Users b,PT_Department c WHERE b.DepartmentAutoID=c.AutoID AND b.Enable=1 AND b.SiteOwner=1 AND c.LocationAutoID=(SELECT AutoID FROM PT_Location WHERE Alias=SUBSTRING(OrderNo,1,3)) ORDER BY b.UserID DESC)
WHERE PT_Order.Closed=0
	AND PT_Order.TransferringSiteOwnerApprove=0
	AND NOT EXISTS(SELECT * FROM PT_Users d WHERE d.UserID=PT_Order.TransferingSiteOwnerUserID AND d.Enable=1 AND d.SiteOwner=1 )
GO
