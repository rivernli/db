USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[KOI_sp_addUser]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[KOI_sp_addUser] 
	@UserID nvarchar(50),
	@uid nvarchar(50),
	@username nvarchar(50),
	@isActive bit,
	@isAdmin bit,
	@domain nvarchar(50),
	@emailAddress nvarchar(50),
	@department nvarchar(50),
	@jobTitle nvarchar(50),
	@fax nvarchar(50),
	@tel nvarchar(50),
	@sitesAccess nvarchar(250),
	@createdBy nvarchar(50),
	@Operation VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON;
	IF @Operation='Insert' 
	BEGIN
	insert into KOI_Users
				(UserID,Account,BDM,[Enable],Administrator,Region,Email,department,jobTitle,fax,tel,sitesAccess,creationDate,createdBy) 
				values
				(@UserID,@uid,@userName,@isActive,@isAdmin,@domain,@emailAddress,@department,@jobTitle,@fax,@tel,@sitesAccess,getdate(),@createdBy) 
	END
	IF @Operation='Update' 
	BEGIN
		UPDATE KOI_Users
		SET [Enable]=@isActive,Administrator=@isAdmin  
		WHERE Account=@uid
	END
	IF @Operation='Delete' 
	BEGIN
		DELETE KOI_Users
		WHERE Account=@uid
	END

IF @Operation='Insert' OR @Operation='Update'
	BEGIN
		INSERT INTO KOI_Authority (UserID,MenuID)
		SELECT b.UserID,a.ID
		FROM KOI_Menu a,KOI_Users b
		WHERE a.ID+b.UserID NOT IN (
							SELECT MenuID+UserID
							FROM  KOI_Authority
							   )

		DELETE KOI_Authority
		WHERE MenuID NOT IN (
						SELECT ID
						FROM KOI_Menu
					 )

		--Initial Administrator's authority
		UPDATE KOI_Authority
		SET CanSee=1
		WHERE UserID IN
			(SELECT UserID FROM KOI_Users WHERE Administrator=1)

		UPDATE KOI_Authority
		SET CanSee=1
		WHERE MenuID IN ('00001')
	END
END













GO
