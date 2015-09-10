USE [Multek_ZH_New]
GO
/****** Object:  StoredProcedure [dbo].[QuotationUploadFile_sp_addUser]    Script Date: 11/06/2014 15:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[QuotationUploadFile_sp_addUser] 
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
	insert into QuotationUploadFile_Users
				(UserID,Account,BDM,[Enable],Administrator,Region,Email,department,jobTitle,fax,tel,sitesAccess,creationDate,createdBy) 
				values
				(@UserID,@uid,@userName,@isActive,@isAdmin,@domain,@emailAddress,@department,@jobTitle,@fax,@tel,@sitesAccess,getdate(),@createdBy) 
	END
	IF @Operation='Update' 
	BEGIN
		UPDATE QuotationUploadFile_Users
		SET [Enable]=@isActive,Administrator=@isAdmin  
		WHERE Account=@uid
	END
	IF @Operation='Delete' 
	BEGIN
		DELETE QuotationUploadFile_Users
		WHERE Account=@uid
	END

IF @Operation='Insert' OR @Operation='Update'
	BEGIN
		INSERT INTO QuotationUploadFile_Authority (UserID,MenuID)
		SELECT b.UserID,a.ID
		FROM QuotationUploadFile_Menu a,QuotationUploadFile_Users b
		WHERE a.ID+b.UserID NOT IN (
							SELECT MenuID+UserID
							FROM  QuotationUploadFile_Authority
							   )

		DELETE QuotationUploadFile_Authority
		WHERE MenuID NOT IN (
						SELECT ID
						FROM QuotationUploadFile_Menu
					 )

		--Initial Administrator's authority
		UPDATE QuotationUploadFile_Authority
		SET CanSee=1
		WHERE UserID IN
			(SELECT UserID FROM QuotationUploadFile_Users WHERE Administrator=1)

		UPDATE QuotationUploadFile_Authority
		SET CanSee=1
		WHERE MenuID IN ('00001')
	END
END
GO
