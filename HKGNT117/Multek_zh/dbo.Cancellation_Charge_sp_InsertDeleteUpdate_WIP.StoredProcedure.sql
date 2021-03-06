USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Cancellation_Charge_sp_InsertDeleteUpdate_WIP]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Cancellation_Charge_sp_InsertDeleteUpdate_WIP]
@ID				INT,
@SO				NVARCHAR(6),
@ITEM			NVARCHAR(35),
@WorkCenter		NVARCHAR(5),
@quantity		DECIMAL(18,4),
@Rate			NVARCHAR(10),
@Operation		NVARCHAR(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SET @SO			= ISNULL(@SO,'')
	SET @ITEM		= ISNULL(@ITEM,'')
	SET @WorkCenter = ISNULL(@WorkCenter,'')
	SET @quantity	= ISNULL(@quantity,0)
	SET @Rate		= ISNULL(@Rate,'')
	SET @Operation	= ISNULL(@Operation,'')

    -- Insert statements for procedure here
	IF(@Operation = 'Insert')
		BEGIN
			IF(@SO = '')
				BEGIN
					RAISERROR('Please enter so number!',16,1)
					RETURN
				END
			ELSE
				BEGIN
--					IF EXISTS(SELECT * FROM dbo.Cancellation_Charge_PPC_WIP WHERE SO = @SO)
--						BEGIN
--							DELETE dbo.Cancellation_Charge_PPC_WIP WHERE SO = @SO
--						END

					INSERT INTO dbo.Cancellation_Charge_PPC_WIP(SO,Item,Work_center,quantity,Rate) 
					VALUES(@SO,@ITEM,@WorkCenter,@quantity,@Rate)
				END
		END
	IF(@Operation = 'Update')
		BEGIN
			IF EXISTS(SELECT * FROM dbo.Cancellation_Charge_PPC_WIP WHERE SO = @SO)
				BEGIN
					UPDATE	dbo.Cancellation_Charge_PPC_WIP SET Item = @ITEM,Work_center = @WorkCenter,quantity = @quantity,Rate = @Rate
					FROM	dbo.Cancellation_Charge_PPC_WIP
					WHERE	ID = @ID
				END
		END
	IF(@Operation = 'Delete')
		BEGIN
			IF(@SO = '')
				BEGIN
					RAISERROR('Please enter so number!',16,1)
					RETURN
				END
			ELSE
				BEGIN
					DELETE dbo.Cancellation_Charge_PPC_WIP WHERE ID = @ID
				END
		END
		
END




GO
