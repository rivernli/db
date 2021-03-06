USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[EHS_sp_addUser]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[EHS_sp_addUser] 
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
	@Plant nvarchar(25),
	@Access bit,
	@Operation VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON;
	IF @Operation='Insert' 
	BEGIN
	insert into EHS_Users
				(UserID,Account,BDM,[Enable],Administrator,Region,Email,department,jobTitle,fax,tel,sitesAccess,creationDate,createdBy,Plant,Access) 
				values
				(@UserID,@uid,@userName,@isActive,@isAdmin,@domain,@emailAddress,@department,@jobTitle,@fax,@tel,@sitesAccess,getdate(),@createdBy,@Plant,@Access) 
	END
	IF @Operation='Update' 
	BEGIN
		UPDATE EHS_Users
		SET Plant=@Plant,[Enable]=@isActive,Administrator=@isAdmin,Access=@Access 
		WHERE Account=@uid
	END
	IF @Operation='Delete' 
	BEGIN
		DELETE EHS_Users
		WHERE Account=@uid
	END

IF @Operation='Insert' OR @Operation='Update'
	BEGIN
		INSERT INTO EHS_Authority (UserID,MenuID)
		SELECT b.UserID,a.ID
		FROM EHS_Menu a,EHS_Users b
		WHERE a.ID+b.UserID NOT IN (
							SELECT MenuID+UserID
							FROM  EHS_Authority
							   )

		DELETE EHS_Authority
		WHERE MenuID NOT IN (
						SELECT ID
						FROM EHS_Menu
					 )

		--Initial Administrator's authority
		UPDATE EHS_Authority
		SET CanSee=1,User_Right=1
		WHERE UserID IN
			(SELECT UserID FROM EHS_Users WHERE Administrator=1)

		UPDATE EHS_Authority
		SET CanSee=1 WHERE UserID=@UserID 
	END
END

















GO
