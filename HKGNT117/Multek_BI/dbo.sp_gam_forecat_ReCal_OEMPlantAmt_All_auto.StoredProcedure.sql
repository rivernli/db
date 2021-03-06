USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_forecat_ReCal_OEMPlantAmt_All_auto]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[sp_gam_forecat_ReCal_OEMPlantAmt_All_auto]
as
set nocount on
declare @cp int
select @cp=multek_zh.dbo.fx_getCurrentPeriod()
select distinct period into #tmp from dbo.gam_part_forecast where period > @cp order by period
while exists (select 1 period from #tmp)
begin
	select top 1 @cp=period from #tmp
	exec [sp_gam_forecat_ReCal_OEMPlantAmt_byPeriod] @cp
	delete #tmp where period=@cp	
end
drop table #tmp
set nocount off
GO
