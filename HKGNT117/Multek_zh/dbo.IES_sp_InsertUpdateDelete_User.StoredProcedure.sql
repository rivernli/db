USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[IES_sp_InsertUpdateDelete_User]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[IES_sp_InsertUpdateDelete_User] 	
		@ID INT=NULL,
		@Domain VARCHAR(50)=NULL,
		@LoginName VARCHAR(50)=NULL,
		@FirstName VARCHAR(50)=NULL,
		@LastName VARCHAR(50)=NULL,
		@Email VARCHAR(500)=NULL,
		@Department VARCHAR(50)=NULL,
		@Title VARCHAR(50)=NULL,
		@Enabled BIT=NULL,
		@Operation VARCHAR(10),
		@CanEdit BIT=NULL
AS

IF @Operation='Insert' 
	BEGIN
		SELECT @ID=ID FROM IES_User WHERE LoginName = @LoginName
		IF @ID > 0
			SET @Operation = 'Update'
		ELSE 
		BEGIN
			INSERT INTO IES_User(Account, Domain, LoginName, FirstName, LastName, Email, Department, Title, Enabled, CanEdit)
				VALUES(@Domain+'\'+@LoginName, @Domain, @LoginName, @FirstName, @LastName, @Email, @Department, @Title, @Enabled, @CanEdit)
			RETURN @@IDENTITY 
		END
	END

IF @Operation='Update' 
	BEGIN
		UPDATE IES_User
		SET Account=@Domain+'\'+@LoginName, Domain=@Domain, LoginName=@LoginName, FirstName=@FirstName, LastName=@LastName, Email=@Email, Department=@Department, Title=@Title, Enabled=@Enabled, CanEdit=@CanEdit
		WHERE ID=@ID 	
	RETURN @ID 
	END
IF @Operation='Delete' 
	BEGIN
		DELETE FROM IES_User WHERE ID=@ID 	
	END



GO
