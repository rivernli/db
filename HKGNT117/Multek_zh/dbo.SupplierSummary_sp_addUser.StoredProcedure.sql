USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[SupplierSummary_sp_addUser]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SupplierSummary_sp_addUser] 
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
	insert into SupplierSummary_Users
				(UserID,Account,BDM,[Enable],Administrator,Region,Email,department,jobTitle,fax,tel,sitesAccess,creationDate,createdBy) 
				values
				(@UserID,@uid,@userName,@isActive,@isAdmin,@domain,@emailAddress,@department,@jobTitle,@fax,@tel,@sitesAccess,getdate(),@createdBy) 
	END
	IF @Operation='Update' 
	BEGIN
		UPDATE SupplierSummary_Users
		SET [Enable]=@isActive,Administrator=@isAdmin  
		WHERE Account=@uid
	END

IF @Operation='Insert' OR @Operation='Update'
	BEGIN
		INSERT INTO SupplierSummary_Authority (UserID,MenuID)
		SELECT b.UserID,a.ID
		FROM SupplierSummary_Menu a,SupplierSummary_Users b
		WHERE a.ID+b.UserID NOT IN (
							SELECT MenuID+UserID
							FROM  SupplierSummary_Authority
							   )
		AND b.UserID=@UserID

		DELETE SupplierSummary_Authority
		WHERE MenuID NOT IN (
						SELECT ID
						FROM SupplierSummary_Menu
					 )

		--Initial Administrator's authority
		UPDATE SupplierSummary_Authority
		SET CanSee=1
		WHERE UserID IN
			(SELECT UserID FROM SupplierSummary_Users WHERE Administrator=1)

		UPDATE SupplierSummary_Authority
		SET CanSee=1
		WHERE MenuID IN ('00001','00009') 
	END
END










GO
