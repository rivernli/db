USE [Multek_SZ_New]
GO
/****** Object:  StoredProcedure [dbo].[sp_PT_check_order]    Script Date: 11/06/2014 15:47:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_PT_check_order] @orn nvarchar(100)
as
--declare @orn nvarchar(100)
--set @orn= 'gerch4130300079'

select * 
 from dbo.PT_Order_CheckList_Detail_DownLoad where OrderCheckListDetailAutoID in 
(select AutoID  from dbo.PT_Order_CheckList_Detail where OrderCheckListAutoID in 
	(select AutoID from PT_Order_CheckList where orderno = @orn)
)


select * 
from dbo.PT_Order_CheckList_Detail where OrderCheckListAutoID in 
(select AutoID from PT_Order_CheckList where orderno = @orn)

select *
from dbo.PT_Order_CheckList_Comment where OrderCheckListAutoID in 
(select AutoID from PT_Order_CheckList where orderno = @orn)

select *
from dbo.PT_Order_CheckList where OrderNo = @orn
select * 
from dbo.PT_Order where OrderNo = @orn
GO
