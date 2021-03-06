USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_forecast_TopSide_adjustment]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE procedure [dbo].[sp_gam_forecast_TopSide_adjustment](@oemid int, @period int,@adjust int, @isOLS bit,
 @grandTtl int output, @salesTtl int output)
 as
 set nocount on
 
 if not exists(select 1 from gam_forecast where oem_id=@oemid and fiscal_period=@period)
	insert into gam_forecast (oem_id,fiscal_period,fcst_amt,actual_amt,inputed_by,user_type,fcst_amt_sumbypart,ols_adjust,topside_adjust)
	values (@oemid,@period,0,0,0,'n',0,0,0)
	
	
 if @isOLS=1
 begin
	update gam_forecast set ols_adjust=@adjust where oem_id=@oemid and fiscal_period=@period
	select @grandTtl=sum(ols_adjust) from gam_forecast where fiscal_period=@period
	select @salesTtl=sum(ols_adjust) from gam_forecast as a join 
	(select oemid from GAM_OEM where salesmanid in (select salesmanid from dbo.GAM_OEM where oemid=@oemid)) as b
	on a.oem_id=b.oemid  where fiscal_period=@period
end
else
begin
	update gam_forecast set topside_adjust=@adjust where  oem_id=@oemid and fiscal_period=@period
	select @grandTtl=sum(topside_adjust) from gam_forecast where fiscal_period=@period
	select @salesTtl=sum(topside_adjust) from gam_forecast as a join 
	(select oemid from GAM_OEM where salesmanid in (select salesmanid from dbo.GAM_OEM where oemid=@oemid)) as b
	on a.oem_id=b.oemid  where fiscal_period=@period
end
 set nocount on




GO
