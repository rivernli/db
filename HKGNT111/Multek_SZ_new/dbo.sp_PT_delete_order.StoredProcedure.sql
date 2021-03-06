USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[sp_PT_delete_order]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
--select top 1 * into PT_Order_CheckList_Detail_DownLoad_DelBk from PT_Order_CheckList_Detail_DownLoad
drop table PT_Order_CheckList_Detail_DownLoad_DelBk
--select top 1 * into PT_Order_CheckList_Detail_DelBK from PT_Order_CheckList_Detail
drop table PT_Order_CheckList_Detail_DelBK
--select top 1 * into PT_Order_CheckList_Comment_DelBK from PT_Order_CheckList_Comment
drop table PT_Order_CheckList_Comment_DelBK
--select top 1 * into PT_Order_DelBK from PT_Order
drop table PT_Order_DelBK
--select top 1 * into PT_Order_CheckList_DelBK from PT_Order_CheckList
drop table PT_Order_CheckList_DelBK
*/
CREATE procedure [dbo].[sp_PT_delete_order] @orderNo nvarchar(100)
as
declare @orn nvarchar(100)
select @orn = @orderNo
--set @orn= 'gerch5130200002'

delete from dbo.PT_Order_CheckList_Detail_DownLoad where OrderCheckListDetailAutoID in 
(select AutoID  from dbo.PT_Order_CheckList_Detail where OrderCheckListAutoID in 
	(select AutoID from PT_Order_CheckList where orderno = @orn)
)
select * 
 from dbo.PT_Order_CheckList_Detail_DownLoad where OrderCheckListDetailAutoID in 
(select AutoID  from dbo.PT_Order_CheckList_Detail where OrderCheckListAutoID in 
	(select AutoID from PT_Order_CheckList where orderno = @orn)
)


delete from dbo.PT_Order_CheckList_Detail where OrderCheckListAutoID in 
(select AutoID from PT_Order_CheckList where orderno = @orn)

delete from dbo.PT_Order_CheckList_Comment where OrderCheckListAutoID in 
(select AutoID from PT_Order_CheckList where orderno = @orn)

delete from dbo.PT_Order_CheckList where OrderNo = @orn
delete from dbo.PT_Order where OrderNo = @orn
GO
