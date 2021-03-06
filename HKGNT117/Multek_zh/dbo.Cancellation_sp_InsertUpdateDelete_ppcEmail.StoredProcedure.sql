USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Cancellation_sp_InsertUpdateDelete_ppcEmail]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Cancellation_sp_InsertUpdateDelete_ppcEmail]
	-- Add the parameters for the stored procedure here
@ID			INT,
@Plant		NVARCHAR(5),
@Email		NVARCHAR(60),
@Operation	NVARCHAR(10)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SET	@Plant		= ISNULL(@Plant,'')
	SET	@Email		= ISNULL(@Email,'')
	SET @Operation	= ISNULL(@Operation,'')
	
	IF(@Operation='insert')
		BEGIN
			IF(@Plant='')
				BEGIN
					RAISERROR('Please input Plant !',16,1)
					RETURN
				END
			IF(@Email='')
				BEGIN
					RAISERROR('Please input email address !',16,1)
					RETURN
				END
			IF(@Plant<>'' and @Email<>'')
				BEGIN
					INSERT INTO dbo.Cancellation_ppc_Email(Plant,Email) VALUES(@Plant,@Email)
				END
		END
	IF(@Operation='update')
		BEGIN
			IF(@Plant='' and @Email='')
				BEGIN
					RAISERROR('Please input Plant & email address!',16,1)
					RETURN
				END
			ELSE
				BEGIN
					UPDATE dbo.Cancellation_ppc_Email SET Plant = @Plant,Email=@Email WHERE ID = @ID
				END
		END
	IF(@Operation='delete')
		BEGIN
			DELETE dbo.Cancellation_ppc_Email WHERE ID = @ID
		END
END

GO
