USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[PT_sp_Update_CheckList_NotAvaliable]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[PT_sp_Update_CheckList_NotAvaliable]
	-- Add the parameters for the stored procedure here
	@OrderNo VARCHAR(50)=NULL,
	@CheckListAutoID INT=NULL,
	@NotAvaliable BIT =NULL,
	@Operator VARCHAR(50)=NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE PT_Order_CheckList 
	SET NotAvaliable=@NotAvaliable
	WHERE OrderNo=@OrderNo 
		AND CheckListAutoID=@CheckListAutoID 

	--EXECUTE PT_sp_Send_Mail	 @OrderNo=@OrderNo,@OrderCheckListAutoID=@CheckListAutoID,@OperatorUserID=@Operator,@Option='Update Check List Item Avaliable',@Code='05'

END
GO
