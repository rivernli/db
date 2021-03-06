USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_actualItemRemark_get]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_gam_actualItemRemark_get]
@oemid int, @part_no nvarchar(50),
@remark nvarchar(1000) output
as
/*
declare @remark nvarchar(1000)
declare @oemid int, @part_no nvarchar(50)
select @oemid=55,@part_no ='1229-2860.2 Receiver Flex'
*/
declare @oem nvarchar(50),@baanName nvarchar(50), @plant nvarchar(10)

set nocount on
select @oem=cusOEM,@baanName=OEMName,@plant=plant,@remark='product_name:""' from dbo.vw_gam_OEMcomb where oemid=@oemid
select @remark='product_name:"'+ replace(rtrim(product_name),'"','\"') +'"' from vMKT_pName_vs_PNo where part_no =@part_no and oem_name=@baanName and plant=@plant
select @remark=@remark+',remark:"'+ replace(remark,'"','\"')+'",ASP:"'+ convert(varchar(10),asp) +'"' from dbo.gam_customerPart_remark where oem_id=@oemid and part_no = @part_no

select top 1 @remark=@remark+',suggestASP:"'+ convert(varchar(10),isnull(asp,0))+
'",item:"'+ rtrim(item) +'",layer:"'+ convert(varchar(10),isnull(layer,'')) +
'",tech:"'+ rtrim(isnull(tech,'')) +'",surf:"'+ rtrim(isnull(surf,'')) +'"'
from gam_itemsDetail where oem=@baanName and plant=@plant and cus_part_no = @part_no order by gamDate desc
select @remark = '{'+ @remark +',oemid:"'+ convert(varchar(10),@oemid) +'",pn:"'+ @part_no+'"}'
set nocount off
GO
