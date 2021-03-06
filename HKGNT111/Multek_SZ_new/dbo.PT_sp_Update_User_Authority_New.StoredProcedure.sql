USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[PT_sp_Update_User_Authority_New]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PT_sp_Update_User_Authority_New]
	@UserID VARCHAR(50),
	@MenuID VARCHAR(50),
	@CanSee BIT
AS

SET NOCOUNT ON

UPDATE PT_Authority
SET CanSee=@CanSee
WHERE UserID=@UserID
	AND MenuID=@MenuID

UPDATE PT_Authority
SET CanSee=@CanSee
WHERE UserID=@UserID
	AND MenuID LIKE @MenuID+'%'

IF @CanSee=1
	BEGIN
		UPDATE PT_Authority SET CanSee=@CanSee WHERE UserID=@UserID AND MenuID=LEFT(@MenuID,5)
		WHILE LEN(@MenuID)>=5
			BEGIN
				UPDATE PT_Authority
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
				IF NOT EXISTS(SELECT * FROM PT_Authority WHERE UserID=@UserID AND LEFT(MenuID,LEN(@MenuID)-5)=LEFT(@MenuID,LEN(@MenuID)-5) AND LEN(MenuID)=LEN(@MenuID) AND CanSee=1)
					BEGIN
						UPDATE PT_Authority
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

EXECUTE PT_Initial_User_Authority
GO
