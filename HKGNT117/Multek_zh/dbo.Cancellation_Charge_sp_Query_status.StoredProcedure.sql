USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Cancellation_Charge_sp_Query_status]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Cancellation_Charge_sp_Query_status]
	-- Add the parameters for the stored procedure here
@SO			NVARCHAR(10),
@ITEM		NVARCHAR(50),
@PLANT		NVARCHAR(5),
@USER		NVARCHAR(20),
@Status		NVARCHAR(20),
@OPERATION	NVARCHAR(30)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SET @SO			= ISNULL(@SO,'')
	SET @ITEM		= ISNULL(@ITEM,'')
	SET @PLANT		= ISNULL(@PLANT,'')
	SET @USER		= ISNULL(@USER,'')
	SET @Status		= ISNULL(@Status,'')
	SET @OPERATION	= ISNULL(@OPERATION,'')

	IF @SO = 'ALL'
		SET @SO = '%%'
	ELSE
		SET @SO = '%'+@SO+'%'

	IF @ITEM = 'ALL'
		SET @ITEM = '%%'
	ELSE
		SET @ITEM = '%'+@ITEM+'%'

	IF @PLANT = 'ALL'
		SET @PLANT = '%%'
	ELSE
		SET @PLANT = '%'+@PLANT+'%'

	IF @USER = 'ALL'
		SET @USER = '%%'
	ELSE
		SET @USER = '%'+@USER+'%'

	IF @Status = 'ALL'
		SET @Status = '%%'
	ELSE
		SET @Status = '%'+@Status+'%'

	-- 
	IF @OPERATION = 'QueryHeader'
		BEGIN
			SELECT SO,Plant,OrderQuantity,BacklogQuantity,Sales,OEM,CONVERT(NVARCHAR,Date,111) AS DATE,[User],STATUS FROM dbo.Cancellation_Charge_Order_Header
			WHERE	SO		LIKE @SO
			AND		Plant	LIKE @PLANT 
			AND		[User]	LIKE @USER
			AND		STATUS	LIKE @Status
		END
	IF @OPERATION = 'QueryDetails'
		BEGIN
			SELECT * FROM dbo.Cancellation_Charge_Order_Details where T$ORNO LIKE @SO
		END
END




GO
