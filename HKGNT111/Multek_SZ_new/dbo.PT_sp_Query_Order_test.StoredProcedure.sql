USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[PT_sp_Query_Order_test]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[PT_sp_Query_Order_test]
	-- Add the parameters for the stored procedure here
	@OrderNo VARCHAR(50)=NULL,
	@TransferringSiteName VARCHAR(200)=NULL,
	@ReceivingSiteName VARCHAR(200)=NULL,
	@PartNumber VARCHAR(50)=NULL,
	@RevisionNumber VARCHAR(50)=NULL,
	@ToolNumber VARCHAR(50)=NULL,
	@CustomerCEM VARCHAR(50)=NULL,
	@OperatorUserID VARCHAR(50)=NULL,
	@Closed BIT=NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SET @OrderNo='%'+RTRIM(LTRIM(ISNULL(@OrderNo,'')))+'%'
	SET @TransferringSiteName='%'+RTRIM(LTRIM(ISNULL(@TransferringSiteName,'')))+'%'
	SET @ReceivingSiteName='%'+RTRIM(LTRIM(ISNULL(@ReceivingSiteName,'')))+'%'
	SET @PartNumber='%'+RTRIM(LTRIM(ISNULL(@PartNumber,'')))+'%'
	SET @RevisionNumber='%'+RTRIM(LTRIM(ISNULL(@RevisionNumber,'')))+'%'
	SET @ToolNumber='%'+RTRIM(LTRIM(ISNULL(@ToolNumber,'')))+'%'
	SET @CustomerCEM='%'+RTRIM(LTRIM(ISNULL(@CustomerCEM,'')))+'%'

	IF NOT EXISTS(SELECT * FROM PT_Users WHERE UserID=@OperatorUserID AND Administrator=1)
		BEGIN
			SELECT a.*,
					dbo.PT_fun_Judge_Need_Receiving_Site_Owner_Approve(a.OrderNo) AS NeedReceivingSiteOwnerApprove
			INTO #Temp1
			FROM PT_uvw_Order a
			WHERE a.OrderNo LIKE @OrderNo
				AND a.TransferringSiteName LIKE @TransferringSiteName
				AND a.ReceivingSiteName LIKE @ReceivingSiteName
				AND a.PartNumber LIKE @PartNumber
				AND a.RevisionNumber LIKE @RevisionNumber
				AND a.ToolNumber LIKE @ToolNumber
				AND a.CustomerCEM LIKE @CustomerCEM
				--AND a.OwnerName LIKE '%'+@OperatorUserID+'%'
				--AND a.Closed=@ClosedCompare
				AND (
						a.TransferingDepartmentAutoID=(
														SELECT b.SiteAutoID 
														FROM PT_uvw_User b 
														WHERE b.UserID=@OperatorUserID
													   )
						OR 
						a.ReceivingDepartmentAutoID=(
														SELECT b.SiteAutoID 
														FROM PT_uvw_User b 
														WHERE b.UserID=@OperatorUserID
													   )
					)

			IF @Closed IS NULL
				BEGIN
					SELECT * FROM #Temp1
				END
			ELSE
				BEGIN
					SELECT * FROM #Temp1 WHERE Closed=@Closed
				END
		END
	ELSE
		BEGIN
			SELECT a.*,
				dbo.PT_fun_Judge_Need_Receiving_Site_Owner_Approve(a.OrderNo) AS NeedReceivingSiteOwnerApprove
			INTO #Temp2
			FROM PT_uvw_Order a
			WHERE a.OrderNo LIKE @OrderNo
				AND a.TransferringSiteName LIKE @TransferringSiteName
				AND a.ReceivingSiteName LIKE @ReceivingSiteName
				AND a.PartNumber LIKE @PartNumber
				AND a.RevisionNumber LIKE @RevisionNumber
				AND a.ToolNumber LIKE @ToolNumber
				AND a.CustomerCEM LIKE @CustomerCEM
				--AND a.OwnerName LIKE '%'+@OperatorUserID+'%'
				--AND a.Closed=@ClosedCompare
			IF @Closed IS NULL
				BEGIN
					SELECT * FROM #Temp2
				END
			ELSE
				BEGIN
					SELECT * FROM #Temp2 WHERE Closed=@Closed
				END

		END
END
GO
