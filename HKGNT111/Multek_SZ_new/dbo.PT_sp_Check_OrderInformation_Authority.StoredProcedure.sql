USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[PT_sp_Check_OrderInformation_Authority]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[PT_sp_Check_OrderInformation_Authority]
	-- Add the parameters for the stored procedure here
	@OrderNo VARCHAR(50)=NULL,
	@UserID VARCHAR(50)=NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON

    -- Insert statements for procedure here
	DECLARE @Administrator BIT,@Creator BIT,@SiteOwner BIT,@Closed BIT,@TR TINYINT,@TransferringSiteOwnerApprove BIT,@HasAttachmentFile BIT
	SET @Administrator=0
	SET @Creator=0
	SET @SiteOwner=0
	SET @Closed=0
	SET @TR=3
	SET @TransferringSiteOwnerApprove=0
	SET @HasAttachmentFile=0

	IF EXISTS(SELECT * FROM PT_Users WHERE UserID=@UserID AND Administrator=1)
		BEGIN
			SET @Administrator=1
		END
	IF EXISTS(SELECT * FROM PT_Order WHERE OrderNo=@OrderNo AND CreatedUserID=@UserID)
		BEGIN
			SET @Creator=1
		END
	IF EXISTS(SELECT * FROM PT_Order WHERE OrderNo=@OrderNo AND TransferingSiteOwnerUserID=@UserID)
		BEGIN
			SET @SiteOwner=1
		END
	IF EXISTS(SELECT * FROM PT_Order WHERE OrderNo=@OrderNo AND Closed=1)
		BEGIN
			SET @Closed=1
		END

	IF (SELECT TransferingDepartmentAutoID FROM PT_Order WHERE OrderNo=@OrderNo)=(SELECT SiteAutoID FROM PT_uvw_User WHERE UserID=@UserID)
		BEGIN
			SET @TR=1
		END
	IF (SELECT ReceivingDepartmentAutoID FROM PT_Order WHERE OrderNo=@OrderNo)=(SELECT  SiteAutoID FROM PT_uvw_User WHERE UserID=@UserID)
		BEGIN
			SET @TR=2
		END

	IF EXISTS(SELECT * FROM PT_Order WHERE OrderNo=@OrderNo AND Closed<>1 AND ReceivingSiteOwnerApprove=1 AND TransferringSIteOwnerApprove=1)
		BEGIN
			SET @TransferringSiteOwnerApprove=1
		END

	IF EXISTS(SELECT a.* FROM PT_Order a,PT_Order_CheckList b,PT_Order_CheckList_Detail c WHERE a.OrderNo=b.OrderNo AND b.AutoID=c.OrderCheckListAutoID AND a.OrderNo=@OrderNo)
		BEGIN
			SET @HasAttachmentFile=1
		END

	SELECT @HasAttachmentFile AS HasAttachmentFile,@Administrator AS Administrator,@Creator AS Creator,@SiteOwner AS SiteOwner,@Closed AS Closed,@TR AS TR,@TransferringSiteOwnerApprove AS TransferringSiteOwnerApprove

			
END
GO
