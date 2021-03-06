USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[PT_sp_Query_Order_CheckList_Comment]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[PT_sp_Query_Order_CheckList_Comment]
	-- Add the parameters for the stored procedure here
	@AutoID INT=NULL,
	@OrderNo VARCHAR(50)=NULL,
	@CheckListAutoID INT=NULL,
	@OrderCheckListAutoID INT=NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SET @OrderCheckListAutoID=(SELECT AutoID FROM PT_Order_CheckList WHERE OrderNo=@OrderNo AND CheckListAutoID=@CheckListAutoID)
	SELECT * 
	FROM PT_Order_CheckList_Comment 
	WHERE OrderCheckListAutoID=@OrderCheckListAutoID
	ORDER BY DateTime ASC
END
GO
