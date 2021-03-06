USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[PT_sp_Query_Order_CheckList]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[PT_sp_Query_Order_CheckList]
	-- Add the parameters for the stored procedure here
	@OrderNo VARCHAR(50)=NULL,
	@CheckListAutoID INT=NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SET @OrderNo='%'+RTRIM(LTRIM(ISNULL(@OrderNo,'')))+'%'

	SELECT a.*,b.*
	FROM PT_Order_CheckList_Detail a,PT_Order_CheckList b
	WHERE	a.OrderCheckListAutoID=b.AutoID 
			AND b.OrderNo LIKE @OrderNo
			AND b.CheckListAutoID=@CheckListAutoID

END
GO
