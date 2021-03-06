USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[KPI_sp_addUser]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



 

CREATE PROCEDURE [dbo].[KPI_sp_addUser] 
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
	insert into KPI_Users
				(UserID,Account,BDM,[Enable],Administrator,Region,Email,department,jobTitle,fax,tel,sitesAccess,creationDate,createdBy) 
				values
				(@UserID,@uid,@userName,@isActive,@isAdmin,@domain,@emailAddress,@department,@jobTitle,@fax,@tel,@sitesAccess,getdate(),@createdBy) 
	END
	IF @Operation='Update' 
	BEGIN
		UPDATE KPI_Users
		SET [Enable]=@isActive,Administrator=@isAdmin  
		WHERE Account=@uid
	END
	IF @Operation='Delete' 
	BEGIN
		DELETE KPI_Users
		WHERE Account=@uid
	END

IF @Operation='Insert' OR @Operation='Update'
	BEGIN
		INSERT INTO KPI_Authority (UserID,MenuID)
		SELECT b.UserID,a.ID
		FROM KPI_Menu a,KPI_Users b
		WHERE a.ID+b.UserID NOT IN (
							SELECT MenuID+UserID
							FROM  KPI_Authority
							   )

		DELETE KPI_Authority
		WHERE MenuID NOT IN (
						SELECT ID
						FROM KPI_Menu
					 )

		--Initial Administrator's authority
		UPDATE KPI_Authority
		SET CanSee=1
		WHERE UserID IN
			(SELECT UserID FROM KPI_Users WHERE Administrator=1)

		UPDATE KPI_Authority
		SET CanSee=1
		WHERE MenuID IN ('00001')


		--KPI Item Authority
		INSERT INTO KPI_Item_Authority (UserID,KPI_Id)
		SELECT b.UserID,a.ID
		FROM KPI_List a,KPI_Users b
		WHERE convert(varchar(20),a.ID)+b.UserID NOT IN (
							SELECT convert(varchar(20),KPI_Id)+UserID
							FROM  KPI_Item_Authority
							   )

		DELETE KPI_Item_Authority
		WHERE KPI_Id NOT IN (
						SELECT ID
						FROM KPI_List
					 )

	END
END

















GO
