USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_MKTGAM_getRight]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[sp_MKTGAM_getRight]( @sysuid int,@isSA bit output,@isPV bit output,@isAC bit output,@limitQty int = 0 output)
as
select @isSA=0,@isPV=0,@isAC=0

select @isPV=case when isadmin=1 then 1 else isPriceView end,@isSa=isSales,
@isAc=case when isadmin=1 or isReportViewer=1 or isSales=1 then 1 else 0 end ,
@limitQty=case when isAdmin=1 then 50000 else 10000 end
from multek_bi.dbo.gam_users where sysUserId=@sysuid and isActive=1
/*
select @isPV=case when isadmin=1 or isReportViewer=1 then 1 else isPriceView end,@isSa=isSales,
@isAc=case when isadmin=1 or isReportViewer=1 or isSales=1 then 1 else 0 end from multek_bi.dbo.gam_users where sysUserId=@sysuid and isActive=1
*/



GO
