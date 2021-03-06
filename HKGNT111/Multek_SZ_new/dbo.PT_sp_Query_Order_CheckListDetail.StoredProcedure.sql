USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[PT_sp_Query_Order_CheckListDetail]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[PT_sp_Query_Order_CheckListDetail]
	-- Add the parameters for the stored procedure here
		-- Add the parameters for the stored procedure here
	@OrderNo VARCHAR(50)=NULL,
	@CheckListAutoID INT=NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @OrderCheckListAutoID INT
	SET @OrderCheckListAutoID=(SELECT AutoID FROM PT_Order_CheckList WHERE OrderNo=@OrderNo AND CheckListAutoID=@CheckListAutoID)

	SELECT a.*,
		(
			SELECT b.BDM+'('+b.UserID+')' FROM PT_Users b WHERE a.TransferUserID=b.UserID
		) AS UploadUserID,
		dbo.PT_fun_GetDownLoad_History(a.AutoID) AS ReceivingUserID
		
	FROM PT_Order_CheckList_Detail a
	WHERE a.OrderCheckListAutoID=@OrderCheckListAutoID
		
END
GO
