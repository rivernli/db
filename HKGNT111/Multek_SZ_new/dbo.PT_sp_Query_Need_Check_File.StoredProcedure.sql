USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[PT_sp_Query_Need_Check_File]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[PT_sp_Query_Need_Check_File]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @OrderNo VARCHAR(50),@OrderCheckListDetailAutoID INT
	DECLARE PT_Order_CheckList_Detail_C CURSOR FOR
	SELECT a.AutoID,b.OrderNo
	FROM PT_Order_CheckList_Detail a,PT_Order_CheckList b
	WHERE a.OrderCheckListAutoID=b.AutoID
		AND ISNULL(a.ReceivingDownload,0)=0
	OPEN PT_Order_CheckList_Detail_C
	FETCH NEXT FROM PT_Order_CheckList_Detail_C INTO @OrderCheckListDetailAutoID,@OrderNo
	WHILE @@FETCH_STATUS=0
		BEGIN
			EXECUTE PT_sp_Send_Mail @OrderNo=@OrderNo,@OrderCheckListDetailAutoID=@OrderCheckListDetailAutoID, @Option='Need Check File',@Code='10'
			FETCH NEXT FROM PT_Order_CheckList_Detail_C INTO @OrderCheckListDetailAutoID,@OrderNo
		END
	CLOSE PT_Order_CheckList_Detail_C
	DEALLOCATE PT_Order_CheckList_Detail_C

END
GO
