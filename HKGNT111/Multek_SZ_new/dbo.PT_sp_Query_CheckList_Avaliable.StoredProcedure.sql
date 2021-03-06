USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[PT_sp_Query_CheckList_Avaliable]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[PT_sp_Query_CheckList_Avaliable]
	-- Add the parameters for the stored procedure here
	@OrderNo VARCHAR(50)=NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
		  (SELECT ISNULL(NotAvaliable,0) FROM PT_Order_CheckList WHERE OrderNo=@OrderNo AND CheckListAutoID=1)
		   AS CheckList1NotAvaliable,
		  (SELECT ISNULL(NotAvaliable,0) FROM PT_Order_CheckList WHERE OrderNo=@OrderNo AND CheckListAutoID=2)
		   AS CheckList2NotAvaliable,
		  (SELECT ISNULL(NotAvaliable,0) FROM PT_Order_CheckList WHERE OrderNo=@OrderNo AND CheckListAutoID=3)
		   AS CheckList3NotAvaliable,
		  (SELECT ISNULL(NotAvaliable,0) FROM PT_Order_CheckList WHERE OrderNo=@OrderNo AND CheckListAutoID=4)
		   AS CheckList4NotAvaliable,
		  (SELECT ISNULL(NotAvaliable,0) FROM PT_Order_CheckList WHERE OrderNo=@OrderNo AND CheckListAutoID=5)
		   AS CheckList5NotAvaliable,
		  (SELECT ISNULL(NotAvaliable,0) FROM PT_Order_CheckList WHERE OrderNo=@OrderNo AND CheckListAutoID=6)
		   AS CheckList6NotAvaliable,
		  (SELECT ISNULL(NotAvaliable,0) FROM PT_Order_CheckList WHERE OrderNo=@OrderNo AND CheckListAutoID=7)
		   AS CheckList7NotAvaliable,
		  (SELECT ISNULL(NotAvaliable,0) FROM PT_Order_CheckList WHERE OrderNo=@OrderNo AND CheckListAutoID=8)
		   AS CheckList8NotAvaliable,
		  (SELECT ISNULL(NotAvaliable,0) FROM PT_Order_CheckList WHERE OrderNo=@OrderNo AND CheckListAutoID=9)
		   AS CheckList9NotAvaliable,
		  (SELECT ISNULL(NotAvaliable,0) FROM PT_Order_CheckList WHERE OrderNo=@OrderNo AND CheckListAutoID=10)
		   AS CheckList10NotAvaliable,
		  (SELECT ISNULL(NotAvaliable,0) FROM PT_Order_CheckList WHERE OrderNo=@OrderNo AND CheckListAutoID=11)
		   AS CheckList11NotAvaliable,
		  (SELECT ISNULL(NotAvaliable,0) FROM PT_Order_CheckList WHERE OrderNo=@OrderNo AND CheckListAutoID=12)
		   AS CheckList12NotAvaliable,
		  (SELECT ISNULL(NotAvaliable,0) FROM PT_Order_CheckList WHERE OrderNo=@OrderNo AND CheckListAutoID=13)
		   AS CheckList13NotAvaliable,
		  (SELECT ISNULL(NotAvaliable,0) FROM PT_Order_CheckList WHERE OrderNo=@OrderNo AND CheckListAutoID=14)
		   AS CheckList14NotAvaliable,
		  (SELECT ISNULL(NotAvaliable,0) FROM PT_Order_CheckList WHERE OrderNo=@OrderNo AND CheckListAutoID=15)
		   AS CheckList15NotAvaliable,
		  (SELECT ISNULL(NotAvaliable,0) FROM PT_Order_CheckList WHERE OrderNo=@OrderNo AND CheckListAutoID=16)
		   AS CheckList16NotAvaliable,
		  (SELECT ISNULL(NotAvaliable,0) FROM PT_Order_CheckList WHERE OrderNo=@OrderNo AND CheckListAutoID=17)
		   AS CheckList17NotAvaliable,
		  (SELECT ISNULL(NotAvaliable,0) FROM PT_Order_CheckList WHERE OrderNo=@OrderNo AND CheckListAutoID=18)
		   AS CheckList18NotAvaliable,
		  (SELECT ISNULL(NotAvaliable,0) FROM PT_Order_CheckList WHERE OrderNo=@OrderNo AND CheckListAutoID=19)
		   AS CheckList19NotAvaliable,
		  (SELECT ISNULL(NotAvaliable,0) FROM PT_Order_CheckList WHERE OrderNo=@OrderNo AND CheckListAutoID=20)
		   AS CheckList20NotAvaliable,
		  (SELECT ISNULL(NotAvaliable,0) FROM PT_Order_CheckList WHERE OrderNo=@OrderNo AND CheckListAutoID=21)
		   AS CheckList21NotAvaliable,
		  (SELECT ISNULL(NotAvaliable,0) FROM PT_Order_CheckList WHERE OrderNo=@OrderNo AND CheckListAutoID=22)
		   AS CheckList22NotAvaliable

END
GO
