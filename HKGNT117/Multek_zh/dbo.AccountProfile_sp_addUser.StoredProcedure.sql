USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[AccountProfile_sp_addUser]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
 

CREATE PROCEDURE [dbo].[AccountProfile_sp_addUser] 
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
	@Management bit,
	@OnlyAccess bit,
	@Operation VARCHAR(10)
AS
BEGIN
	SET NOCOUNT ON;
	IF @Operation='Insert' 
	BEGIN
	insert into AccountProfile_Users
				(UserID,Account,BDM,[Enable],Administrator,Region,Email,department,jobTitle,Mobile,fax,tel,sitesAccess,creationDate,createdBy,ManagerId,Management,OnlyAccess) 
				values
				(@UserID,@uid,@userName,@isActive,@isAdmin,@domain,@emailAddress,@department,@jobTitle,@Mobile,@fax,@tel,@sitesAccess,getdate(),@createdBy,@ManagerId,@Management,@OnlyAccess) 
	END
	IF @Operation='Update' 
	BEGIN
		UPDATE AccountProfile_Users
		SET [Enable]=@isActive,Administrator=@isAdmin,ManagerId=@ManagerId,Management=@Management,OnlyAccess=@OnlyAccess    
		WHERE Account=@uid
	END
	IF @Operation='Delete' 
	BEGIN
		DELETE AccountProfile_Users
		WHERE Account=@uid
	END


IF @Operation='Insert' OR @Operation='Update'
	BEGIN
		INSERT INTO AccountProfile_Authority (UserID,MenuID)
		SELECT b.UserID,a.ID
		FROM AccountProfile_Menu a,AccountProfile_Users b
		WHERE a.ID+b.UserID NOT IN (
							SELECT MenuID+UserID
							FROM  AccountProfile_Authority
							   )

		DELETE AccountProfile_Authority
		WHERE MenuID NOT IN (
						SELECT ID
						FROM AccountProfile_Menu
					 )

		--Initial Administrator's authority
		UPDATE AccountProfile_Authority
		SET CanSee=1
		WHERE UserID IN
			(SELECT UserID FROM AccountProfile_Users WHERE Administrator=1)
			
		UPDATE AccountProfile_Authority 
		SET CanSee=1
		WHERE MenuID IN ('00001','00009')

	END
END












GO
