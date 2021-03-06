USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_isCEM_sales]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_gam_isCEM_sales] @usrid nvarchar(10)
as
if exists (
	select 1 from (
		select distinct uid from dbo.gam_cem_oemName as a left join vw_gam_OEMcomb as b on a.baanName=b.OEMName where uid is not null and isValid=1
		union all
		select distinct vid from dbo.gam_cem_oemName as a left join vw_gam_OEMcomb as b on a.baanName=b.OEMName where vid is not null and isValid=1
	) as a where uid = @usrid
) 
	select 1
else
	select 0

GO
