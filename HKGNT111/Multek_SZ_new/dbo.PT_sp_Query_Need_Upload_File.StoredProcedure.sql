USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[PT_sp_Query_Need_Upload_File]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[PT_sp_Query_Need_Upload_File]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @OrderNo VARCHAR(50),@OrderCheckListAutoID INT
	DECLARE PT_Order_CheckList_C CURSOR FOR
	SELECT b.CheckListAutoID,b.OrderNo
	FROM PT_Order_CheckList b
	WHERE b.NotAvaliable=0
		AND NOT EXISTS(SELECT  a.* FROM PT_Order_CheckList_Detail a WHERE a.OrderCheckListAutoID=b.AutoID)
	OPEN PT_Order_CheckList_C
	FETCH NEXT FROM PT_Order_CheckList_C INTO @OrderCheckListAutoID,@OrderNo
	WHILE @@FETCH_STATUS=0
		BEGIN
			EXECUTE PT_sp_Send_Mail @OrderNo=@OrderNo,@OrderCheckListAutoID=@OrderCheckListAutoID, @Option='Need Upload File',@Code='09'
			FETCH NEXT FROM PT_Order_CheckList_C INTO @OrderCheckListAutoID,@OrderNo
		END
	CLOSE PT_Order_CheckList_C
	DEALLOCATE PT_Order_CheckList_C

END
GO
