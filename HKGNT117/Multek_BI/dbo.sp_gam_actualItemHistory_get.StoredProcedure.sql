USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_actualItemHistory_get]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_gam_actualItemHistory_get] @oemid int,@cspart nvarchar(100)
as
declare @oem nvarchar(100)
declare @plant nvarchar(10)
select @oem=oemname,@plant=plant from dbo.vw_gam_OEMcomb where oemid = @oemid

select top 4 iperiod,int_part_no,amt from dbo.vw_gam_actualItemsAmount_for_Input 
where cus_part_no = @cspart and oem=@oem and plant=@plant and iperiod <= multek_zh.dbo.fx_getCurrentPeriod()
order by iperiod desc



GO
