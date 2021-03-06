USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[E_quote_sp_addUser]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[E_quote_sp_addUser] 
	@UserID nvarchar(50),
	@uid nvarchar(50),
	@username nvarchar(50),
	@isActive bit,
	@isAdmin bit,
	@domain nvarchar(50),
	@emailAddress nvarchar(50),
	@department nvarchar(50),
	@jobTitle nvarchar(50),
	@Mobile varchar(50),
	@fax nvarchar(50),
	@tel nvarchar(50),
	@sitesAccess nvarchar(250),
	@createdBy nvarchar(50),
	@ManagerId nvarchar(50),
	@Operation VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON;
	IF @Operation='Insert' 
	BEGIN
	insert into E_quote_Users
				(UserID,Account,BDM,[Enable],Administrator,Region,Email,department,jobTitle,Mobile,fax,tel,sitesAccess,creationDate,createdBy,ManagerId) 
				values
				(@UserID,@uid,@userName,@isActive,@isAdmin,@domain,@emailAddress,@department,@jobTitle,@Mobile,@fax,@tel,@sitesAccess,getdate(),@createdBy,@ManagerId) 
	END
	IF @Operation='Update' 
	BEGIN
		UPDATE E_quote_Users
		SET [Enable]=@isActive,Administrator=@isAdmin  
		WHERE Account=@uid
	END
	IF @Operation='Delete' 
	BEGIN
		DELETE E_quote_Users
		WHERE Account=@uid
	END


IF @Operation='Insert' OR @Operation='Update'
	BEGIN
		INSERT INTO E_quote_Authority (UserID,MenuID)
		SELECT b.UserID,a.ID
		FROM E_quote_Menu a,E_quote_Users b
		WHERE a.ID+b.UserID NOT IN (
							SELECT MenuID+UserID
							FROM  E_quote_Authority
							   )

		DELETE E_quote_Authority
		WHERE MenuID NOT IN (
						SELECT ID
						FROM E_quote_Menu
					 )

		--Initial Administrator's authority
		UPDATE E_quote_Authority
		SET CanSee=1
		WHERE UserID IN
			(SELECT UserID FROM E_quote_Users WHERE Administrator=1)

	END
END











GO
