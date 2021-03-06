USE [AMD_Lab]
GO
/****** Object:  StoredProcedure [dbo].[Monthly_Cu_Tensile_Strength_sp_addUser]    Script Date: 2014/11/12 17:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 

CREATE PROCEDURE [dbo].[Monthly_Cu_Tensile_Strength_sp_addUser] 
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
	insert into Monthly_Cu_Tensile_Strength_Users
				(UserID,Account,BDM,[Enable],Administrator,Region,Email,department,jobTitle,fax,tel,sitesAccess,creationDate,createdBy) 
				values
				(@UserID,@uid,@userName,@isActive,@isAdmin,@domain,@emailAddress,@department,@jobTitle,@fax,@tel,@sitesAccess,getdate(),@createdBy) 
	END
	IF @Operation='Update' 
	BEGIN
		UPDATE Monthly_Cu_Tensile_Strength_Users
		SET [Enable]=@isActive,Administrator=@isAdmin  
		WHERE Account=@uid
	END
	IF @Operation='Delete' 
	BEGIN
		DELETE Monthly_Cu_Tensile_Strength_Users
		WHERE Account=@uid
	END


IF @Operation='Insert' OR @Operation='Update'
	BEGIN
		INSERT INTO Monthly_Cu_Tensile_Strength_Authority (UserID,MenuID)
		SELECT b.UserID,a.ID
		FROM Monthly_Cu_Tensile_Strength_Menu a,Monthly_Cu_Tensile_Strength_Users b
		WHERE a.ID+b.UserID NOT IN (
							SELECT MenuID+UserID
							FROM  Monthly_Cu_Tensile_Strength_Authority
							   )

		DELETE Monthly_Cu_Tensile_Strength_Authority
		WHERE MenuID NOT IN (
						SELECT ID
						FROM Monthly_Cu_Tensile_Strength_Menu
					 )

		--Initial Administrator's authority
		UPDATE Monthly_Cu_Tensile_Strength_Authority
		SET CanSee=1
		WHERE UserID IN
			(SELECT UserID FROM Monthly_Cu_Tensile_Strength_Users WHERE Administrator=1)
			
		UPDATE Monthly_Cu_Tensile_Strength_Authority 
		SET CanSee=1
		WHERE MenuID IN ('00001','00002','00009')

	END
END 









GO
