USE [Multek_ZH]
GO
/****** Object:  StoredProcedure [dbo].[Cancellation_sp_Query_STATUS]    Script Date: 2014/11/12 17:12:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Cancellation_sp_Query_STATUS]
	-- Add the parameters for the stored procedure here
@SO			NVARCHAR(10),
@ITEM		NVARCHAR(50),
@PLANT		NVARCHAR(5),
@DATE		DATETIME,
@USER		NVARCHAR(20),
@OPERATION	NVARCHAR(30)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SET @OPERATION = ISNULL(@OPERATION,'')
	IF @OPERATION = 'QueryHeader'
		BEGIN
			SELECT * FROM dbo.Cancellation_Order_Header
		END
	IF @OPERATION = 'QueryDetails'
		BEGIN
			SELECT * FROM dbo.Cancellation_Order_Details
		END
END

GO
