USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Cancellation_Charge_sp_InsertDeleteUpdate_Material]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Cancellation_Charge_sp_InsertDeleteUpdate_Material]
@ID				INT,
@SO				NVARCHAR(6),
@ITEM			NVARCHAR(35),
@Project		NVARCHAR(35),
@Project_Desc	NVARCHAR(35),
@quantity		DECIMAL(18,4),
@Unit			NVARCHAR(10),
@Operation	NVARCHAR(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	SET @ID				= ISNULL(@ID,0)
	SET @SO				= ISNULL(@SO,'')
	SET @ITEM			= ISNULL(@ITEM,'')
	SET @Project		= ISNULL(@Project,'')
	SET @Project_Desc	= ISNULL(@Project_Desc,'')
	SET @quantity		= ISNULL(@quantity,0)
	SET @UNIT			= ISNULL(@UNIT,'')
	SET @Operation		= ISNULL(@Operation,'')

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
--					IF EXISTS(SELECT * FROM dbo.Cancellation_Charge_PPC_Material WHERE T$ORNO = @SO)
--						BEGIN
--							DELETE dbo.Cancellation_Charge_PPC_Material WHERE T$ORNO = @SO
--						END

					INSERT INTO dbo.Cancellation_Charge_PPC_Material(T$ORNO,T$ITEM,T$PJNO,T$DESC,T$aqua,T$UNIT) 
					VALUES(@SO,@ITEM,@Project,@Project_Desc,@quantity,@UNIT)
				END
		END
	IF(@Operation = 'Update')
		BEGIN
			IF EXISTS(SELECT * FROM dbo.Cancellation_Charge_PPC_Material WHERE T$ORNO = @SO)
				BEGIN
					UPDATE	dbo.Cancellation_Charge_PPC_Material SET T$ITEM = @ITEM,T$PJNO = @Project,T$DESC=@Project_Desc,T$aqua=@quantity,T$UNIT=@UNIT
					FROM	dbo.Cancellation_Charge_PPC_Material
					WHERE	ID = @ID
				END
		END
	IF(@Operation = 'Delete')
		BEGIN
--			IF(@SO = '')
--				BEGIN
--					RAISERROR('Please enter so number!',16,1)
--					RETURN
--				END
--			ELSE
			BEGIN
				DELETE dbo.Cancellation_Charge_PPC_Material WHERE ID= @ID--T$ORNO = @SO and T$ITEM = @ITEM and T$PJNO = @Project and T$aqua = @quantity
			END
		END
		
END



GO
