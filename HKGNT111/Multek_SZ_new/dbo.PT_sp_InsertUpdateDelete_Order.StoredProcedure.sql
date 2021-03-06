USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[PT_sp_InsertUpdateDelete_Order]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[PT_sp_InsertUpdateDelete_Order]
	-- Add the parameters for the stored procedure here
	@OrderNo VARCHAR(50)=NULL,
	@TransferingDepartmentAutoID INT=NULL,
	@TransferingSiteOwnerUserID VARCHAR(50)=NULL,
	@ReceivingDepartmentAutoID INT=NULL,
	@ReceivingSiteOwnerUserID VARCHAR(50)=NULL,
	@PartNumber VARCHAR(50)=NULL,
	@RevisionNumber VARCHAR(50)=NULL,
	@ToolNumber VARCHAR(50)=NULL,
	@CustomerCEM VARCHAR(50)=NULL,
	@CustomerOEM VARCHAR(50)=NULL,
	@DeliveryDate DATETIME=NULL,
	@CustomerApprove BIT=NULL,
	@SalesOrderOption INT=NULL,
	@SalesOrderAttachment VARCHAR(50)=NULL,
	@SalesOrderPhysicalAttachment VARCHAR(500)=NULL,
	@SalesOrderComment VARCHAR(500)=NULL,
	@PurchaseOrderOption INT=NULL,
	@PurchaseOrderAttachment VARCHAR(50)=NULL,
	@PurchaseOrderPhysicalAttachment VARCHAR(500)=NULL,
	@PurchaseOrderComment VARCHAR(500)=NULL,
	@TransferingInvolvedDepartmentAutoID VARCHAR(500)=NULL,
	@GoldenBoardShipment TINYINT=NULL,
	@GoldenBoardQuantity INT=NULL,
	@GoldenBoardWhen DATETIME=NULL,
	@GoldenBoardAWB NVARCHAR(200)=NULL,
	@GoldenBoardByWhom NVARCHAR(200)=NULL,
	@GoldenBoardComment NVARCHAR(MAX)=NULL,
	@RejectedBoardShipment TINYINT=NULL,
	@RejectedBoardQuantity INT=NULL,
	@RejectedBoardWhen DATETIME=NULL,
	@RejectedBoardAWB NVARCHAR(200)=NULL,
	@RejectedBoardByWhom NVARCHAR(200)=NULL,
	@RejectedBoardComment NVARCHAR(MAX)=NULL,
	@OperationType VARCHAR(50),
	@Operator VARCHAR(50),
	@ReceivingSiteOwnerApprove BIT=NULL,
	@TransferringSiteOwnerApprove BIT =NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @NowOrderNo INT
    -- Insert statements for procedure here
	IF @OperationType='Insert' OR @OperationType='Update'
		BEGIN
			IF @TransferingDepartmentAutoID IS NULL AND @OperationType='Insert'
				BEGIN
					RAISERROR('Sorry,transferring site can not be empty!',16,1)
					RETURN
				END
			IF @TransferingSiteOwnerUserID IS NULL OR @TransferingSiteOwnerUserID=''
				BEGIN
					RAISERROR('Sorry,transferring site owner can not be empty!',16,1)
					RETURN
				END
			IF @ReceivingDepartmentAutoID IS NULL AND @OperationType='Insert'
				BEGIN
					RAISERROR('Sorry,receiving site can not be empty!',16,1)
					RETURN
				END
			IF @ReceivingSiteOwnerUserID IS NULL OR @ReceivingSiteOwnerUserID=''
				BEGIN
					RAISERROR('Sorry,receiving site owner can not be empty!',16,1)
					RETURN
				END


		END
	IF @OperationType='Insert'
		BEGIN
			SET @OrderNo=(SELECT Alias FROM PT_Location WHERE AutoID=@TransferingDepartmentAutoID)+
						 (SELECT Alias FROM PT_Location WHERE AutoID=@ReceivingDepartmentAutoID)+
						 CONVERT(VARCHAR(4),GETDATE(),12)
			SET @NowOrderNo=(SELECT ISNULL(MAX(RIGHT(OrderNo,5)),0) FROM PT_Order WHERE OrderNo LIKE @OrderNo+'%')+1
			SET @OrderNo=@OrderNo+(
									CASE WHEN @NowOrderNo BETWEEN 1 AND 9 THEN REPLICATE('0',4)
										 WHEN @NowOrderNo BETWEEN 10 AND 99 THEN REPLICATE('0',3)
										 WHEN @NowOrderNo BETWEEN 100 AND 999 THEN REPLICATE('0',2)
										 WHEN @NowOrderNo BETWEEN 1000 AND 9999 THEN REPLICATE('0',1)
									ELSE ''
									END
								  )+CONVERT(VARCHAR(5),@NowOrderNo)
			INSERT INTO PT_Order(
									OrderNo,
									TransferingDepartmentAutoID,
									TransferingSiteOwnerUserID,
									ReceivingDepartmentAutoID,
									ReceivingSiteOwnerUserID,
									PartNumber,
									RevisionNumber,
									ToolNumber,
									CustomerCEM,
									CustomerOEM,
									DeliveryDate,
									CustomerApprove,
									/*
									SalesOrderOption,
									SalesOrderAttachment,
									SalesOrderPhysicalAttachment,
									SalesOrderComment,
									PurchaseOrderOption,
									PurchaseOrderAttachment,
									PurchaseOrderPhysicalAttachment,
									PurchaseOrderComment,
									*/
									TransferingInvolvedDepartmentAutoID,
									CreatedUserID
								)				
						VALUES  (
									@OrderNo,
									@TransferingDepartmentAutoID,
									@TransferingSiteOwnerUserID,
									@ReceivingDepartmentAutoID,
									@ReceivingSiteOwnerUserID,
									@PartNumber,
									@RevisionNumber,
									@ToolNumber,
									@CustomerCEM,
									@CustomerOEM,
									@DeliveryDate,
									@CustomerApprove,
									/*
									@SalesOrderOption,
									@SalesOrderAttachment,
									@SalesOrderPhysicalAttachment,
									@SalesOrderComment,
									@PurchaseOrderOption,
									@PurchaseOrderAttachment,
									@PurchaseOrderPhysicalAttachment,
									@PurchaseOrderComment,
									*/
									@TransferingInvolvedDepartmentAutoID,
									@Operator
								)
			
			INSERT INTO PT_Order_CheckList (OrderNo,ChecklistAutoID)
			SELECT @OrderNo,AutoID FROM PT_CheckList	
		
			UPDATE PT_Order_CheckList
			SET NotAvaliable=1 
			WHERE OrderNo=@OrderNo
					AND CheckListAutoID BETWEEN 20 AND 21

			EXECUTE PT_sp_Send_Mail @OrderNo=@OrderNo,@Option='Insert Order',@OperatorUserID=@Operator,@Code='01'

		END
	IF @OperationType='Update'
			BEGIN
				UPDATE PT_Order 
				SET TransferingSiteOwnerUserID=@TransferingSiteOwnerUserID,
					ReceivingSiteOwnerUserID=@ReceivingSiteOwnerUserID,
					PartNumber=@PartNumber,
					RevisionNumber=@RevisionNumber,
					ToolNumber=@ToolNumber,
					CustomerCEM=@CustomerCEM,
					CustomerOEM=@CustomerOEM,
					DeliveryDate=@DeliveryDate,
					CustomerApprove=@CustomerApprove,
					LastUpdatedUserID=@Operator,
					LastUpdatedDate=GETDATE()
				WHERE OrderNo=@OrderNo

				--EXECUTE PT_sp_Send_Mail @OrderNo=@OrderNo,@Option='Update Order',@OperatorUserID=@Operator,@Code='03'

			END	
	IF @OperationType='Delete'
			BEGIN
				IF EXISTS(
							SELECT c.* 
							FROM PT_Order a,PT_Order_CheckList b,PT_Order_CheckList_Detail c
							WHERE a.OrderNo=b.OrderNo
								AND b.AutoID=c.OrderCheckListAutoID
								AND a.OrderNo=@OrderNo
						  )
					BEGIN
						RAISERROR('Sorry,you can not delete the order for its some check list items have attached files . If you want to delete it,please remove its attached files !',16,1)
						RETURN
					END

				--EXECUTE PT_sp_Send_Mail @OrderNo=@OrderNo,@Option='Delete Order',@OperatorUserID=@Operator,@Code='02'

				DELETE PT_Order WHERE OrderNo=@OrderNo				

			END
	IF @OperationType='Update Board'
			BEGIN
				IF @GoldenBoardShipment=0
					BEGIN
						SET @GoldenBoardWhen =NULL
						SET @GoldenBoardQuantity =NULL
						SET @GoldenBoardAWB=NULL
						SET @GoldenBoardByWhom=NULL
						SET @GoldenBoardComment =NULL
					END
				IF @GoldenBoardShipment=1
					BEGIN
						SET @GoldenBoardComment=''
						IF @GoldenBoardQuantity IS NULL OR @GoldenBoardQuantity<1
							BEGIN
								RAISERROR('Sorry, golden board QUANTITY must be more than 0 if shipped!',16,1)
								RETURN
							END
						IF @GoldenBoardWhen IS NULL 
							BEGIN
								RAISERROR('Sorry, golden board WHEN can not be empty if shipped!',16,1)
								RETURN
							END
						IF CONVERT(VARCHAR(10),@GoldenBoardWhen,120)='01/01/1900'
							BEGIN
								RAISERROR('Sorry, golden board WHEN can not be empty if shipped!',16,1)
								RETURN
							END
						IF RTRIM(LTRIM(ISNULL(@GoldenBoardAWB,'')))=''
							BEGIN
								RAISERROR('Sorry, golden board AWB when can not be empty if shipped!',16,1)
								RETURN
							END
						IF RTRIM(LTRIM(ISNULL(@GoldenBoardByWhom,'')))=''
							BEGIN
								RAISERROR('Sorry, golden board BY WHOM can not be empty if shipped!',16,1)
								RETURN
							END
					END
				IF @GoldenBoardShipment=2
					BEGIN
						SET @GoldenBoardQuantity=NULL
						SET @GoldenBoardWhen=NULL
						SET @GoldenBoardAWB=NULL
						SET @GoldenBoardByWhom=NULL
					END

				IF @RejectedBoardShipment=0
					BEGIN
						SET @RejectedBoardWhen =NULL
						SET @RejectedBoardQuantity =NULL
						SET @RejectedBoardAWB=NULL
						SET @RejectedBoardByWhom=NULL
						SET @RejectedBoardComment =NULL
					END
				IF @RejectedBoardShipment=1
					BEGIN
						SET @RejectedBoardComment=''
						IF @RejectedBoardQuantity IS NULL OR @RejectedBoardQuantity<1
							BEGIN
								RAISERROR('Sorry, Rejected board QUANTITY must be more than 0 if shipped!',16,1)
								RETURN
							END
						IF @RejectedBoardWhen IS NULL 
							BEGIN
								RAISERROR('Sorry, Rejected board WHEN can not be empty if shipped!',16,1)
								RETURN
							END
						IF RTRIM(LTRIM(ISNULL(@RejectedBoardAWB,'')))=''
							BEGIN
								RAISERROR('Sorry, Rejected board AWB when can not be empty if shipped!',16,1)
								RETURN
							END
						IF RTRIM(LTRIM(ISNULL(@RejectedBoardByWhom,'')))=''
							BEGIN
								RAISERROR('Sorry, Rejected board BY WHOM can not be empty if shipped!',16,1)
								RETURN
							END
					END
				IF @RejectedBoardShipment=2
					BEGIN
						SET @RejectedBoardQuantity=NULL
						SET @RejectedBoardWhen=NULL
						SET @RejectedBoardAWB=NULL
						SET @RejectedBoardByWhom=NULL
					END

				UPDATE PT_Order 
				SET GoldenBoardShipment=@GoldenBoardShipment,
					GoldenBoardQuantity=@GoldenBoardQuantity,
					GoldenBoardWhen=@GoldenBoardWhen,
					GoldenBoardAWB=@GoldenBoardAWB,
					GoldenBoardByWhom=@GoldenBoardByWhom,
					GoldenBoardComment=@GoldenBoardComment,
					RejectedBoardShipment=@RejectedBoardShipment,
					RejectedBoardQuantity=@RejectedBoardQuantity,
					RejectedBoardWhen=@RejectedBoardWhen,
					RejectedBoardAWB=@RejectedBoardAWB,
					RejectedBoardByWhom=@RejectedBoardByWhom,
					RejectedBoardComment=@RejectedBoardComment,			
					LastUpdatedUserID=@Operator,
					LastUpdatedDate=GETDATE()
				WHERE OrderNo=@OrderNo

				--EXECUTE PT_sp_Send_Mail @OrderNo=@OrderNo,@Option='Update Board',@OperatorUserID=@Operator,@Code='04'

			END	
	IF @OperationType='ReceivingSiteOwnerApprove'
			BEGIN
				IF EXISTS(
							SELECT a.* 
							FROM PT_Order a,PT_Order_CheckList b
							WHERE a.OrderNo=b.OrderNo
								AND a.OrderNo=@OrderNo
								AND b.NotAvaliable=0
								AND NOT EXISTS(SELECT c.* FROM PT_Order_CheckList_Detail c WHERE c.OrderCheckListAutoID=b.AutoID)
						  )
					BEGIN
						RAISERROR('Sorry,you can not confirm the order for its some avaliable check list items has not attached files!',16,1)
						RETURN
					END

				IF EXISTS(
							SELECT c.* 
							FROM PT_Order a,PT_Order_CheckList b,PT_Order_CheckList_Detail c
							WHERE a.OrderNo=b.OrderNo
								AND b.AutoID=c.OrderCheckListAutoID
								AND a.OrderNo=@OrderNo
								AND c.ReceivingDownload<>'1'
						  )
					BEGIN
						RAISERROR('Sorry,you can not confirm the order for it has some attached files what not be downloaded by receiving site!',16,1)
						RETURN
					END
				IF (SELECT GoldenBoardShipment FROM PT_Order WHERE OrderNo=@OrderNo )=0
					BEGIN
						RAISERROR('Sorry,you can not confirm the order for its golden board has not been shipped to receiving site!',16,1)
						RETURN
					END
				IF (SELECT RejectedBoardShipment FROM PT_Order WHERE OrderNo=@OrderNo )=0
					BEGIN
						RAISERROR('Sorry,you can not confirm the order for its rejected board has not been shipped to receiving site!',16,1)
						RETURN
					END
				IF EXISTS(SELECT * FROM PT_Order WHERE OrderNo=@OrderNo AND TransferringSiteOwnerApprove=1)
					BEGIN
						RAISERROR('Sorry,you can not change CONFIRM DATA STATUS for the transferring site owner confirmed all data was OK !',16,1)
						RETURN
					END

				UPDATE PT_Order SET ReceivingSiteOwnerApprove=@ReceivingSiteOwnerApprove ,ReceivingSiteOwnerApproveDate=GETDATE() WHERE OrderNo=@OrderNo
				--EXECUTE PT_sp_Send_Mail @OrderNo=@OrderNo,@Option='Receiving Site Owner Approve',@OperatorUserID=@Operator,@Code='13'
			END
	IF @OperationType='TransferringSiteOwnerApprove'
			BEGIN

				IF EXISTS(
							SELECT a.* 
							FROM PT_Order a,PT_Order_CheckList b
							WHERE a.OrderNo=b.OrderNo
								AND a.OrderNo=@OrderNo
								AND b.NotAvaliable=0
								AND NOT EXISTS(SELECT c.* FROM PT_Order_CheckList_Detail c WHERE c.OrderCheckListAutoID=b.AutoID)
						  )
					BEGIN
						RAISERROR('Sorry,you can not confirm the order for its some avaliable check list items has not attached files!',16,1)
						RETURN
					END

				IF EXISTS(
							SELECT c.* 
							FROM PT_Order a,PT_Order_CheckList b,PT_Order_CheckList_Detail c
							WHERE a.OrderNo=b.OrderNo
								AND b.AutoID=c.OrderCheckListAutoID
								AND a.OrderNo=@OrderNo
								AND c.ReceivingDownload<>'1'
						  )
					BEGIN
						RAISERROR('Sorry,you can not confirm the order for it has some attached files what not be downloaded by receiving site!',16,1)
						RETURN
					END
				IF (SELECT GoldenBoardShipment FROM PT_Order WHERE OrderNo=@OrderNo )=0
					BEGIN
						RAISERROR('Sorry,you can not confirm the order for its golden board has not been shipped to receiving site!',16,1)
						RETURN
					END
				IF (SELECT RejectedBoardShipment FROM PT_Order WHERE OrderNo=@OrderNo )=0
					BEGIN
						RAISERROR('Sorry,you can not confirm the order for its rejected board has not been shipped to receiving site!',16,1)
						RETURN
					END
				IF NOT EXISTS(SELECT * FROM PT_Order WHERE OrderNo=@OrderNo AND ReceivingSiteOwnerApprove=1)
					BEGIN
						RAISERROR('Sorry, you can not confirm the order before receiving site owner confirms it !',16,1)
						RETURN
					END
				UPDATE PT_Order SET TransferringSiteOwnerApprove=@TransferringSiteOwnerApprove ,TransferringSiteOwnerApproveDate=GETDATE() WHERE OrderNo=@OrderNo
				--EXECUTE PT_sp_Send_Mail @OrderNo=@OrderNo,@Option='Transferring Site Owner Approve',@OperatorUserID=@Operator,@Code='14'
			END
	IF @OperationType='Close'
			BEGIN

				IF EXISTS(
							SELECT a.* 
							FROM PT_Order a,PT_Order_CheckList b
							WHERE a.OrderNo=b.OrderNo
								AND a.OrderNo=@OrderNo
								AND b.NotAvaliable=0
								AND NOT EXISTS(SELECT c.* FROM PT_Order_CheckList_Detail c WHERE c.OrderCheckListAutoID=b.AutoID)
						  )
					BEGIN
						RAISERROR('Sorry,you can not close the order for its some avaliable check list items has not attached files!',16,1)
						RETURN
					END

				IF EXISTS(
							SELECT c.* 
							FROM PT_Order a,PT_Order_CheckList b,PT_Order_CheckList_Detail c
							WHERE a.OrderNo=b.OrderNo
								AND b.AutoID=c.OrderCheckListAutoID
								AND a.OrderNo=@OrderNo
								AND c.ReceivingDownload<>'1'
						  )
					BEGIN
						RAISERROR('Sorry,you can not close the order for it has some attached files what not be downloaded by receiving site!',16,1)
						RETURN
					END
				IF (SELECT GoldenBoardShipment FROM PT_Order WHERE OrderNo=@OrderNo )=0
					BEGIN
						RAISERROR('Sorry,you can not close the order for its golden board has not been shipped to receiving site!',16,1)
						RETURN
					END
				IF (SELECT RejectedBoardShipment FROM PT_Order WHERE OrderNo=@OrderNo )=0
					BEGIN
						RAISERROR('Sorry,you can not close the order for its rejected board has not been shipped to receiving site!',16,1)
						RETURN
					END
				IF NOT EXISTS(SELECT * FROM PT_Order WHERE OrderNo=@OrderNo AND TransferringSiteOwnerApprove=1)
					BEGIN
						RAISERROR('Sorry, you can not close the order before transferring site owner confirms it !',16,1)
						RETURN
					END

				UPDATE PT_Order 
				SET Closed=1 ,ClosedUserID=@Operator,ClosedDate=GETDATE(), 
					TransferingSiteOwnerUserID=@TransferingSiteOwnerUserID,
					ReceivingSiteOwnerUserID=@ReceivingSiteOwnerUserID
				WHERE OrderNo=@OrderNo

				EXECUTE PT_sp_Send_Mail @OrderNo=@OrderNo,@Option='Close Order',@OperatorUserID=@Operator,@Code='16'
			END
END
GO
