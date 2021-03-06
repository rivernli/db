USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Cancellation_Charge_sp_ME_Update_cost]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Cancellation_Charge_sp_ME_Update_cost]
	-- Add the parameters for the stored procedure here
@So		NVARCHAR(6),
@ITEM	NVARCHAR(32),
@PLANT	NVARCHAR(6),
@Cost	DECIMAL(18,4)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SET @SO		= ISNULL(@SO,'')
	SET @ITEM	= ISNULL(@ITEM,'')
	SET @PLANT	= ISNULL(@PLANT,'')
	SET @COST	= ISNULL(@COST,0)

	UPDATE	dbo.Cancellation_Charge_Order_Details SET T$COPR = @COST
	WHERE	T$ORNO = @SO
	AND		T$PLNT = @PLANT
	AND		T$ITEM = @ITEM
END

GO
