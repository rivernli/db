USE [BOC]
GO
/****** Object:  StoredProcedure [dbo].[boc_sp_InsertModifyDelete_User]    Script Date: 2014/11/12 17:02:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[boc_sp_InsertModifyDelete_User]
@AutoID		INT,
@Domain		NVARCHAR(20),
@Account	NVARCHAR(20),
@BDM		NVARCHAR(50),
@Email		NVARCHAR(50),
@Role		NVARCHAR(20),
@PriceRole	NVARCHAR(20),
@Plant		NVARCHAR(50),
@Enable		BIT,
@Operation	NVARCHAR(20)
AS
BEGIN
	DECLARE	@UserID NVARCHAR(50),@PL	NVARCHAR(50)
	DECLARE	@LEN	INT,@POS	INT

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET @AutoID		= ISNULL(@AutoID,0)
	SET @Domain		= LTRIM(RTRIM(@Domain));
	SET @Domain		= ISNULL(@Domain,'')
	SET @Account	= LTRIM(RTRIM(@Account))
	SET @Account	= ISNULL(@Account,'')
	SET @BDM		= LTRIM(RTRIM(@BDM))
	SET @BDM		= ISNULL(@BDM,'')
	SET @Email		= LTRIM(RTRIM(@Email))
	SET @Email		= ISNULL(@Email,'')
	SET @Role		= LTRIM(RTRIM(@Role))
	SET @Role		= ISNULL(@Role,'')
	SET @PriceRole	= LTRIM(RTRIM(@PriceRole))
	SET @PriceRole	= ISNULL(@PriceRole,'')
	SET @Plant		= LTRIM(RTRIM(@Plant))
	SET	@Plant		= ISNULL(@Plant,'')
	SET @Operation	= LTRIM(RTRIM(@Operation))
	SET @Operation	= ISNULL(@Operation,'')

    -- Insert statements for procedure here
	IF @Operation = 'Insert' OR @Operation = 'Update'
	BEGIN
		IF @Domain IS NULL OR @Domain=''
			BEGIN
				RAISERROR('Sorry, [domain] can not be empty!',16,1)
				RETURN
			END
		IF @Account IS NULL OR @Account=''
			BEGIN
				RAISERROR('Sorry, [account] can not be empty!',16,1)
				RETURN
			END
		IF @BDM IS NULL OR @BDM=''
			BEGIN
				RAISERROR('Sorry, [Name] can not be empty!',16,1)
				RETURN
			END
		IF @Email IS NULL OR @Email=''
			BEGIN
				RAISERROR('Sorry, [Eamil] can not be empty!',16,1)
				RETURN
			END
		SET @UserID=@Domain+'\'+@Account
	END

	-- OPERATION 
	IF @Operation = 'Insert'
		BEGIN
			INSERT INTO Authority_User(userid,Region,Account,username,Email,role,price,Enable)
				VALUES(@Account,@Domain,@UserID,@BDM,@Email,@Role,@PriceRole,@Enable)

			SET	@LEN = LEN(@Plant)
			SET @POS = CHARINDEX(',',@Plant)
			WHILE @POS >0
				BEGIN
					SELECT	@PL		= SUBSTRING(@Plant,1,@POS-1)
					SELECT	@Plant	= SUBSTRING(@Plant,@POS+1,@LEN - @POS)
					SELECT	@POS	= CHARINDEX(',',@Plant)

					INSERT INTO Authority_Trend_Key_Plant (userid,authority) VALUES(@Account,@PL)
				END
				--INSERT INTO Authority_Trend_Key_Plant (userid,authority) VALUES(@Account,@Plant)
		END

	IF @Operation='Update' 
		BEGIN
			UPDATE Authority_User SET	userid = @Account,Region = @Domain,Account = @UserID,username = @BDM,
										Email = @Email,role = @Role,price=@PriceRole,Enable=@Enable
			WHERE userid = @Account

			DELETE Authority_Trend_Key_Plant WHERE userid = @Account

			SET	@LEN = LEN(@Plant)
			SET @POS = CHARINDEX(',',@Plant)
			WHILE @POS >0
				BEGIN
					SELECT	@PL		= SUBSTRING(@Plant,1,@POS-1)
					SELECT	@Plant	= SUBSTRING(@Plant,@POS+1,@LEN - @POS)
					SELECT	@POS	= CHARINDEX(',',@Plant)

					INSERT INTO Authority_Trend_Key_Plant (userid,authority) VALUES(@Account,@PL)
				END
		END

	IF @Operation='Delete' 
		BEGIN
			SELECT @UserID = USERID FROM Authority_User WHERE Autoid = @AutoID
			DELETE Authority_User WHERE Autoid = @AutoID

			DELETE Authority_Trend_Key_Plant WHERE userid = @UserID
		END
END

GO
