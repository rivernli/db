USE [Multek_SZ_New]
GO
/****** Object:  UserDefinedFunction [dbo].[PT_fun_Judge_Need_Transferring_Site_Owner_Approve]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[PT_fun_Judge_Need_Transferring_Site_Owner_Approve]
(
	-- Add the parameters for the function here
	@OrderNo VARCHAR(20)
)
RETURNS BIT
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Judge BIT 

	-- Add the T-SQL statements to compute the return value here
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
		AND (SELECT GoldenBoardShipment FROM PT_Order WHERE OrderNo=@OrderNo )<>0
		AND (SELECT RejectedBoardShipment FROM PT_Order WHERE OrderNo=@OrderNo )<>0
		AND (SELECT ReceivingSiteOwnerApprove FROM PT_Order WHERE OrderNo=@OrderNo)=1
		BEGIN
			SET @Judge=1
		END			
	-- Return the result of the function
	RETURN (ISNULL(@Judge,0))

END
GO
