USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[sp_Traceability_AuthorityUpdate]    Script Date: 2014/11/12 17:12:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[sp_Traceability_AuthorityUpdate]
	@Uid VARCHAR(50)
	,@Domain VARCHAR(50)
	,@MenuID VARCHAR(50)
	,@CanSee BIT
AS
BEGIN
	DECLARE @UserID VARCHAR(50)
	SET @UserID=@Domain +'\'+ @Uid

	IF @MenuID='ALL'
		UPDATE [Traceability_Authority]
		SET CanSee=@CanSee
		WHERE UserID=@UserID
	ELSE
	BEGIN
		--UPDATE [Traceability_Authority]
		--SET CanSee=@CanSee
		--WHERE UserID=@UserID
		--	AND MenuID  IN ( SELECT  CONVERT(INT,col)   FROM   dbo.f_split(@MenuID,','))  -- 分割字符串
		UPDATE [Traceability_Authority]
		SET CanSee=@CanSee
		WHERE UserID=@UserID
			AND MenuID=@MenuID

		UPDATE [Traceability_Authority]
		SET CanSee=@CanSee
		WHERE UserID=@UserID
			AND MenuID LIKE @MenuID+'%'

		IF @CanSee=1
			BEGIN
				UPDATE [Traceability_Authority] SET CanSee=@CanSee WHERE UserID=@UserID AND MenuID=LEFT(@MenuID,5)
				WHILE LEN(@MenuID)>=5
					BEGIN
						UPDATE [Traceability_Authority]
						SET CanSee=@CanSee
						WHERE UserID=@UserID
							AND MenuID =LEFT(@MenuID,LEN(@MenuID)-5)

						IF LEN(@MenuID)-5>0
							BEGIN
								SET @MenuID=LEFT(@MenuID,LEN(@MenuID)-5)
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
						IF NOT EXISTS(SELECT * FROM [Traceability_Authority] WHERE UserID=@UserID AND LEFT(MenuID,LEN(@MenuID)-5)=LEFT(@MenuID,LEN(@MenuID)-5) AND LEN(MenuID)=LEN(@MenuID) AND CanSee=1)
							BEGIN
								UPDATE [Traceability_Authority]
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

	END	 

	SELECT @@rowcount
END






GO
