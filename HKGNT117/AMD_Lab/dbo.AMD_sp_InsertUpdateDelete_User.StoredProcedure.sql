USE [AMD_Lab]
GO
/****** Object:  StoredProcedure [dbo].[AMD_sp_InsertUpdateDelete_User]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



/*============================================ AMD_sp_InsertUpdateDelete_User ======================================================================*/

CREATE PROCEDURE [dbo].[AMD_sp_InsertUpdateDelete_User]
	@AutoID INT=NULL,
	@Domain VARCHAR(50)=NULL,
	@Analyst VARCHAR(50)=NULL,
	@Account VARCHAR(50)=NULL,
	@BDM VARCHAR(50)=NULL,
	@Email VARCHAR(100)=NULL,
	@Administrator BIT=NULL,	
	@Title nvarchar(50)=NULL,
	@FirstName nvarchar(50)=NULL,
	@LastName nvarchar(50)=NULL,
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
		INSERT INTO AMD_Users (UserID,Region,Analyst,Account,BDM,Email,Administrator,Enable,Title,FirstName,LastName)
			VALUES(@UserID,@Domain,@Analyst,@Account,@BDM,@Email,@Administrator,@Enable,@Title,@FirstName,@LastName)

		if not exists( select * from tblAnalyst where FirstName=@FirstName AND LastName=@LastName )
		Begin		
			Insert into tblAnalyst (Analyst,[Current],Title,FirstName,LastName)
				values(@Analyst,@Enable,@Title,@FirstName,@LastName) 
		END
	END
IF @Operation='Update' 
	BEGIN
		UPDATE AMD_Users
		SET UserID=@UserID,Region=@Domain,Analyst=@Analyst,Account=@Account,BDM=@BDM,Email=@Email,Administrator=@Administrator,Enable=@Enable, 
			Title=@Title,FirstName=@FirstName,LastName=@LastName 
		WHERE AutoID=@AutoID
		
		update tblAnalyst set Analyst=@Analyst,[Current]=@Enable,Title=@Title,FirstName=@FirstName,LastName=@LastName 
		where FirstName=@FirstName AND LastName=@LastName 
	END
IF @Operation='Delete' 
	BEGIN
		DELETE AMD_Users
		WHERE AutoID=@AutoID
	END

IF @Operation='Insert' OR @Operation='Update'
	BEGIN
		--Initial user's menus
		INSERT INTO AMD_Authority (UserID,MenuID)
		SELECT b.UserID,a.ID
		FROM AMD_Menu a,AMD_Users b
		WHERE a.ID+b.UserID NOT IN (
							SELECT MenuID+UserID
							FROM  AMD_Authority
							   )

		DELETE AMD_Authority
		WHERE MenuID NOT IN (
						SELECT ID
						FROM AMD_Menu
					 )

		--Initial Administrator's authority
		UPDATE AMD_Authority
		SET CanSee=1
		WHERE UserID IN
			(SELECT UserID FROM AMD_Users WHERE Administrator=1)

		UPDATE AMD_Authority
		SET CanSee=1
		WHERE MenuID IN ('00001')
	END






GO
