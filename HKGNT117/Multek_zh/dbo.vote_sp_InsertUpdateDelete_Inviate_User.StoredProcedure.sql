USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[vote_sp_InsertUpdateDelete_Inviate_User]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*============================================ vote_sp_InsertUpdateDelete_User ======================================================================*/

CREATE PROCEDURE [dbo].[vote_sp_InsertUpdateDelete_Inviate_User]
	@AutoID INT=NULL,
	@voteID INT,
	@Domain NVARCHAR(50),
	@Account  NVARCHAR(50),
	@FullName NVARCHAR(50),
	@Email NVARCHAR(100),
	@Telephone NVARCHAR(50),
	@EmployeeID NVARCHAR(50),
	@Status bit,
	@Operation VARCHAR(10)
AS

SET NOCOUNT ON

DECLARE @UserID VARCHAR(50) 

SET @Domain=LTRIM(RTRIM(@Domain))
SET @Account=LTRIM(RTRIM(@Account))
SET @FullName=LTRIM(RTRIM(@FullName))
SET @Email=LTRIM(RTRIM(@Email))

IF @Operation='Insert' OR @Operation='Update'
	BEGIN
		--IF @Domain IS NULL OR @Domain=''
		--	BEGIN
		--		RAISERROR('Sorry, [domain] can not be empty!',16,1)
		--		RETURN
		--	END
		IF @Account IS NULL OR @Account=''
			BEGIN
				RAISERROR('Sorry, [account] can not be empty!',16,1)
				RETURN
			END
		IF @FullName IS NULL OR @FullName=''
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
		INSERT INTO vote_Inviate_Users (voteID,Domain,Account,FullName,Email,Telephone,EmployeeID,[Status])
			VALUES(@voteID,@Domain,@Account,@FullName,@Email,@Telephone,@EmployeeID,0)
	END
IF @Operation='Update' 
	BEGIN
		UPDATE vote_Inviate_Users
		SET voteID = @voteID,Domain=@Domain,Account=@Account,FullName=@FullName,Email=@Email,Telephone=@Telephone,EmployeeID=@EmployeeID,[Status] = @Status
		WHERE ID=@AutoID
	END
IF @Operation='Delete' 
	BEGIN
		DELETE vote_Inviate_Users
		WHERE ID=@AutoID
	END

--IF @Operation='Insert' OR @Operation='Update'
--	BEGIN
--		--Initial user's menus
--		INSERT INTO vote_Authority (UserID,MenuID)
--		SELECT b.UserID,a.ID
--		FROM vote_Menu a,vote_Users b
--		WHERE a.ID+b.UserID NOT IN (
--							SELECT MenuID+UserID
--							FROM  vote_Authority
--							   )

--		DELETE vote_Authority
--		WHERE MenuID NOT IN (
--						SELECT ID
--						FROM vote_Menu
--					 )

--		--Initial Administrator's authority
--		UPDATE vote_Authority
--		SET CanSee=1
--		WHERE UserID IN
--			(SELECT UserID FROM vote_Users WHERE Administrator=1)

--		UPDATE vote_Authority
--		SET CanSee=1
--		WHERE MenuID IN ('00001')
--	END

GO
