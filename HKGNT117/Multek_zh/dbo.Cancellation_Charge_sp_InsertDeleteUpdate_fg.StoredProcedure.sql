USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Cancellation_Charge_sp_InsertDeleteUpdate_fg]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Cancellation_Charge_sp_InsertDeleteUpdate_fg]
@SO			NVARCHAR(6),
@LINE		NVARCHAR(4),
@ITEM		NVARCHAR(35),
@quantity	DECIMAL(18,4),
@Operation	NVARCHAR(10)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SET @SO = ISNULL(@SO,'')
	SET @LINE = ISNULL(@LINE,'')
	SET @ITEM = ISNULL(@ITEM,'')
	SET @quantity = ISNULL(@quantity,0)
	SET @Operation = ISNULL(@Operation,'')

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
					IF NOT EXISTS(SELECT * FROM dbo.Cancellation_Charge_PPC_FG WHERE T$ORNO = @SO AND T$PONO = @LINE)
						BEGIN
							INSERT INTO dbo.Cancellation_Charge_PPC_FG(T$ORNO,T$PONO,T$ITEM,T$QUAN) 
							VALUES(@SO,@LINE,@ITEM,@quantity)
						END
					ELSE
						BEGIN
							RAISERROR('The so & line exists!please update value',16,1)
							RETURN
						END
				END
		END
	IF(@Operation = 'Update')
		BEGIN
			IF EXISTS(SELECT * FROM dbo.Cancellation_Charge_PPC_FG WHERE T$ORNO = @SO AND T$PONO = @LINE)
				BEGIN
					UPDATE	dbo.Cancellation_Charge_PPC_FG SET T$ITEM = @ITEM,T$QUAN = @quantity
					FROM	dbo.Cancellation_Charge_PPC_FG
					WHERE	T$ORNO = @SO
					AND		T$PONO = @LINE
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
					DELETE dbo.Cancellation_Charge_PPC_FG WHERE T$ORNO = @SO AND T$PONO = @LINE
				END
		END
		
END

GO
