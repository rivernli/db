USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[SupplierSummary_sp_Update_User_Authority_New]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 

create PROCEDURE [dbo].[SupplierSummary_sp_Update_User_Authority_New]
	@UserID VARCHAR(50),
	@MenuID VARCHAR(50),
	@CanSee BIT
AS

SET NOCOUNT ON

SET @UserID = replace(@UserID,'|','\')

UPDATE SupplierSummary_Authority
SET CanSee=@CanSee
WHERE UserID=@UserID
	AND MenuID=@MenuID

UPDATE SupplierSummary_Authority
SET CanSee=@CanSee
WHERE UserID=@UserID
	AND MenuID LIKE @MenuID+'%'

IF @CanSee=1
	BEGIN
		UPDATE SupplierSummary_Authority SET CanSee=@CanSee WHERE UserID=@UserID AND MenuID=LEFT(@MenuID,5)
		WHILE LEN(@MenuID)>=5
			BEGIN
				UPDATE SupplierSummary_Authority
				SET CanSee=@CanSee
				WHERE UserID=@UserID
					AND MenuID =LEFT(@MenuID,LEN(@MenuID)-5)

				IF LEN(@MenuID)-10>0
					BEGIN
						SET @MenuID=LEFT(@MenuID,LEN(@MenuID)-10)
					END
				ELSE
					BEGIN
						SET @MenuID=''
					END
			END			
	END

IF @CanSee=0
	BEGIN
		WHILE LEN(@MenuID)>=5
			BEGIN
				IF NOT EXISTS(SELECT * FROM SupplierSummary_Authority WHERE UserID=@UserID AND LEFT(MenuID,LEN(@MenuID)-5)=LEFT(@MenuID,LEN(@MenuID)-5) AND LEN(MenuID)=LEN(@MenuID) AND CanSee=1)
					BEGIN
						UPDATE SupplierSummary_Authority
						SET CanSee=@CanSee
						WHERE UserID=@UserID
							AND MenuID =LEFT(@MenuID,LEN(@MenuID)-5)
						SET @MenuID=LEFT(@MenuID,LEN(@MenuID)-5)
					END
				ELSE
					BEGIN
						BREAK
					END
			END
	END

UPDATE SupplierSummary_Authority
SET CanSee=1
WHERE UserID=@UserID
	AND MenuID IN ('00001','00005','00006')

UPDATE SupplierSummary_Authority
SET CanSee=1
FROM SupplierSummary_Authority a,SupplierSummary_Users b
WHERE a.UserID=b.UserID
	AND b.Administrator=1





GO
