USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[PT_sp_InsertUpdateDelete_Order_CheckListDetail_DownLoad]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[PT_sp_InsertUpdateDelete_Order_CheckListDetail_DownLoad]
	-- Add the parameters for the stored procedure here
		-- Add the parameters for the stored procedure here
	@AutoID INT=NULL,
	@OperatorUserID	VARCHAR(50)=NULL,
	@OperationType VARCHAR(50)=NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @OrderNo VARCHAR(50),@CheckListID AS INT

	SET @OrderNo=(
					SELECT b.OrderNo
					FROM PT_Order_CheckList_Detail a,PT_Order_CheckList b
				    WHERE a.OrderCheckListAutoID=b.AutoID
						AND a.AutoID=@AutoID
				 )
    -- Insert statements for procedure here
	IF @OperationType='Insert'
		BEGIN
			INSERT INTO PT_Order_CheckList_Detail_DownLoad (OrderCheckListDetailAutoID,ReceivingDownloadUserID)
					VALUES(@AutoID,@OperatorUserID)
			/*
			IF EXISTS(
						SELECT *
						FROM PT_Users
						WHERE UserID=@OperatorUserID
							AND DepartmentAutoID IN (
														SELECT DepartmentAutoID
														FROM PT_Department_CheckList
														WHERE CheckListAutoID=(
																				SELECT b.CheckListAutoID
																				FROM PT_Order_CheckList_Detail a,PT_Order_CheckList b
																				WHERE a.OrderCheckListAutoID=b.AutoID
																					AND a.AutoID=@AutoID
																			   )
													)
							AND DepartmentAutoID=(
													 SELECT ReceivingDepartmentAutoID
													 FROM PT_Order 
													 WHERE OrderNo=@OrderNo
											      )
					 )
			*/
			IF (
					SELECT SiteName
					FROM PT_uvw_User	
					WHERE UserID=(
									SELECT TransferUserID
									FROM PT_Order_CheckList_Detail
									WHERE  AutoID=@AutoID
								 )
				)<>
				(
					SELECT SiteName
					FROM PT_uvw_User	
					WHERE UserID=@OperatorUserID
				)
					BEGIN
						UPDATE PT_Order_CheckList_Detail SET ReceivingDownload=1 WHERE AutoID=@AutoID
					END
		END

	--EXECUTE PT_sp_Send_Mail @OrderNo=@OrderNo,@OrderCheckListDetailAutoID=@AutoID, @Option='Download File',@OperatorUserID=@OperatorUserID,@Code='07'

END
GO
