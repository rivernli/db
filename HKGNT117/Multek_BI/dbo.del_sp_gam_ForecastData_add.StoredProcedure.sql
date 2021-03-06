USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[del_sp_gam_ForecastData_add]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [dbo].[del_sp_gam_ForecastData_add]
@uid int,
@oid int,
@period int,
@amt real
as
/*

declare @uid int
declare @oid int
declare @amt real 
declare @period int

set @uid=2
set @oid=6
set @period = 201203
set @amt = 100020*/
declare @update bit
declare @n char(1)
set @n='n'

set @update=0
select top 1 @update=1,@n='s' from dbo.vw_gam_OEMcomb where salesmanID=@uid and oemid=@oid
if(@update=0)
	select top 1 @update=1,@n='m' from dbo.fx_getSalesByManager(@uid) join dbo.GAM_OEM on salesmanId=sysUserId
	where oemid=@oid
if(@update=0)
	select top 1 @update=1,@n='a' from gam_users where sysUserId=@uid and isAdmin=1 and isActive=1

if(@update=1)
begin
	declare @fcst_id int
	set @fcst_id= 0
	select @fcst_id=fcst_id from dbo.gam_forecast where oem_id=@oid and fiscal_period=@period
	if(@fcst_id=0)
		insert into gam_forecast (oem_id,fiscal_period,fcst_amt,inputed_by,user_type) values (@oid,@period,@amt,@uid,@n);
	else
		update gam_forecast set fcst_amt=@amt,inputed_by=@uid,user_type=@n where oem_id=@oid and fiscal_period=@period

	select @amt
end
else
	select 0



GO
