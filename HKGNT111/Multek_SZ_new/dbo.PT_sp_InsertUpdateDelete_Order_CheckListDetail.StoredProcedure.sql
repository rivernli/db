USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[PT_sp_InsertUpdateDelete_Order_CheckListDetail]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[PT_sp_InsertUpdateDelete_Order_CheckListDetail]
	-- Add the parameters for the stored procedure here
		-- Add the parameters for the stored procedure here
	@AutoID INT=NULL,
	@OrderNo VARCHAR(50)=NULL,
	@CheckListAutoID INT=NULL,
	@OrderCheckListAutoID INT=NULL,
	@Attachment NVARCHAR(500)=NULL,
	@PhysicalAttachment VARCHAR(50)=NULL,
	@TransferComment NVARCHAR(500)=NULL,
	@ReceivingDownloadDate DATETIME=NULL,
	@OperatorUserID	VARCHAR(50)=NULL,
	@OperationType VARCHAR(50)=NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF @OperationType='Insert'
		BEGIN
			SET @OrderCheckListAutoID=(SELECT AutoID FROM PT_Order_CheckList WHERE OrderNo=@OrderNo AND CheckListAutoID=@CheckListAutoID)
			IF EXISTS(SELECT * FROM PT_Order_CheckList_Detail WHERE OrderCheckListAutoID=@OrderCheckListAutoID AND Attachment=@Attachment)
				BEGIN
					RAISERROR('Sorry,file can not be redupilicate under a check list item!',16,1)
					RETURN
				END
			IF EXISTS(SELECT * FROM PT_Order_CheckList WHERE AutoID=@OrderCheckListAutoID AND NotAvaliable=1)
				BEGIN
					RAISERROR('Sorry,this check list item is not avaliable, you can not upload file!',16,1)
					RETURN
				END

			INSERT INTO PT_Order_CheckList_Detail (OrderCheckListAutoID,TransferUserID,Attachment,PhysicalAttachment,TransferComment)
					VALUES(@OrderCheckListAutoID,@OperatorUserID,@Attachment,@PhysicalAttachment,@TransferComment)
			
			--EXECUTE PT_sp_Send_Mail @OrderNo=@OrderNo,@OrderCheckListDetailAutoID=@@IDENTITY, @Option='Upload File',@OperatorUserID=@OperatorUserID,@Code='06'

		END
	IF @OperationType='Delete'
		BEGIN
			IF EXISTS(SELECT * FROM PT_Order_CheckList_Detail WHERE AutoID=@AutoID AND ReceivingDownload=1)
				BEGIN
					RAISERROR('Sorry,you can not delete the file what was downloaded by receiving site users!',16,1)
					RETURN
				END

			--EXECUTE PT_sp_Send_Mail @OrderNo=@OrderNo,@OrderCheckListDetailAutoID=@AutoID, @Option='Delete File',@OperatorUserID=@OperatorUserID,@Code='08'

			DELETE PT_Order_CheckList_Detail WHERE AutoID=@AutoID AND ReceivingDownload=0
		END
END
GO
