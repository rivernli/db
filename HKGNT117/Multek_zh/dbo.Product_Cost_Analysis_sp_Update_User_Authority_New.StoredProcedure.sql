USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Product_Cost_Analysis_sp_Update_User_Authority_New]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 

CREATE PROCEDURE [dbo].[Product_Cost_Analysis_sp_Update_User_Authority_New]
	@UserID VARCHAR(50),
	@MenuID VARCHAR(50),
	@CanSee BIT
AS

SET NOCOUNT ON

SET @UserID = replace(@UserID,'|','\')

UPDATE Product_Cost_Analysis_Authority
SET CanSee=@CanSee
WHERE UserID=@UserID
	AND MenuID=@MenuID

UPDATE Product_Cost_Analysis_Authority
SET CanSee=@CanSee
WHERE UserID=@UserID
	AND MenuID LIKE @MenuID+'%'

IF @CanSee=1
	BEGIN
		UPDATE Product_Cost_Analysis_Authority SET CanSee=@CanSee WHERE UserID=@UserID AND MenuID=LEFT(@MenuID,5)
		WHILE LEN(@MenuID)>=5
			BEGIN
				UPDATE Product_Cost_Analysis_Authority
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
				IF NOT EXISTS(SELECT * FROM Product_Cost_Analysis_Authority WHERE UserID=@UserID AND LEFT(MenuID,LEN(@MenuID)-5)=LEFT(@MenuID,LEN(@MenuID)-5) AND LEN(MenuID)=LEN(@MenuID) AND CanSee=1)
					BEGIN
						UPDATE Product_Cost_Analysis_Authority
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


UPDATE Product_Cost_Analysis_Authority
SET CanSee=1
FROM Product_Cost_Analysis_Authority a,Product_Cost_Analysis_Users b
WHERE a.UserID=b.UserID
	AND b.Administrator=1







GO
