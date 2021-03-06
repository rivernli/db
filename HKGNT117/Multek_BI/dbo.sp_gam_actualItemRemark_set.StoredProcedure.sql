USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_actualItemRemark_set]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[sp_gam_actualItemRemark_set] 
@oemid int, @part_no nvarchar(50),@remark nvarchar(500),@asp float = 0
as
if exists (select 1 from gam_customerPart_remark where oem_id=@oemid and part_no = @part_no)
	update gam_customerPart_remark set remark=@remark,asp=@asp, last_update=getdate()
	where oem_id=@oemid and part_no = @part_no
else
	insert into gam_customerPart_remark (oem_id,part_no,last_update,remark,asp) 
	values (@oemid,@part_no,getdate(),@remark,@asp)


GO
