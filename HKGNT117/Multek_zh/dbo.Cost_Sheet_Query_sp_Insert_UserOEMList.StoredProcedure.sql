USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Cost_Sheet_Query_sp_Insert_UserOEMList]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Cost_Sheet_Query_sp_Insert_UserOEMList]
@Account	VARCHAR(50),
@OEM		CHAR(30),
@Operation	NVARCHAR(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SET @Account   = ISNULL(@Account,'')
	SET @OEM	   = ISNULL(@OEM,'')
	SET @Operation = ISNULL(@Operation,'')

	IF @Account = ''
		BEGIN
			RAISERROR('Account can not null!',16,1)
			RETURN
		END
	IF @Operation = 'Insert'
		BEGIN
			IF @OEM = ''
				BEGIN
					RAISERROR('OEM can not null!',16,1)
					RETURN
				END
			INSERT INTO dbo.Cost_Sheet_Query_CS_OEM_Authority(Account,OEM) VALUES(@Account,@OEM)
		END
	IF @Operation = 'Delete'
		BEGIN
			DELETE dbo.Cost_Sheet_Query_CS_OEM_Authority WHERE Account = @Account AND OEM = @OEM
		END
	IF @Operation = 'Query'
		BEGIN
			SELECT * FROM dbo.Cost_Sheet_Query_CS_OEM_Authority WHERE Account = @Account
		END
END
GO
