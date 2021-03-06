USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[PT_sp_Query_Need_ReceivingSiteOwner_Approve]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[PT_sp_Query_Need_ReceivingSiteOwner_Approve]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @OrderNo VARCHAR(50)
	DECLARE Order_C CURSOR FOR
	SELECT OrderNo
	FROM PT_Order
	WHERE Closed=0
	
	OPEN Order_C
	FETCH NEXT FROM Order_C INTO @OrderNo
	WHILE @@FETCH_STATUS=0
		BEGIN
			IF NOT EXISTS(
						SELECT a.* 
						FROM PT_Order a,PT_Order_CheckList b
						WHERE a.OrderNo=b.OrderNo
							AND a.OrderNo=@OrderNo
							AND b.NotAvaliable=0
							AND NOT EXISTS(SELECT c.* FROM PT_Order_CheckList_Detail c WHERE c.OrderCheckListAutoID=b.AutoID)
					  )

				AND NOT EXISTS(
									SELECT c.* 
									FROM PT_Order a,PT_Order_CheckList b,PT_Order_CheckList_Detail c
									WHERE a.OrderNo=b.OrderNo
										AND b.AutoID=c.OrderCheckListAutoID
										AND a.OrderNo=@OrderNo
										AND c.ReceivingDownload<>'1'
							  )
				AND (SELECT GoldenBoardShipment FROM PT_Order WHERE OrderNo=@OrderNo )<>1
				AND (SELECT RejectedBoardShipment FROM PT_Order WHERE OrderNo=@OrderNo )<>1
				AND (SELECT ReceivingSiteOwnerApprove FROM PT_Order WHERE OrderNo=@OrderNo)<>1
					BEGIN
							EXECUTE PT_sp_Send_Mail @OrderNo=@OrderNo,@Option='ReceivingSiteOwnerNeedApprove',@Code='11'
					END
			FETCH NEXT FROM Order_C INTO @OrderNo
		END
	CLOSE Order_C
	DEALLOCATE Order_C



END
GO
