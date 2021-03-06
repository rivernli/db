USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_forecastCustomerPart_Update]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_gam_forecastCustomerPart_Update]
@period int,@oemid int,@project nvarchar(100),@amt int, @salesmanid int,@tamt int =0 output

as
/*
declare @period int; declare @oemid int; declare @project nvarchar(100)
declare @amt int; declare @salesmanId int; declare @tamt int
select @period=201204,@oemid=2,@project='TVK1281022R1B',@amt=2510,@salesmanid=1
*/
set nocount on

declare @cp int
select @cp=multek_zh.dbo.fx_getCurrentPeriod()
/*
2013-10-28
if(@period <= @cp)
	return
*/
if(@period < @cp)
	return

delete gam_part_forecast where period=@period and oemid=@oemid and project=@project
--delete gam_part_forecast where amt = 0

insert into gam_part_forecast (period,oemid,project,amt,input_date,input_userId,qty) 
	values (@period,@oemid,@project,@amt,getdate(),@salesmanid,0)	

/*automatic update forecase total amount in gam_part_forecast table.*/
/*
select @tamt=sum(amt) from gam_part_forecast where period=@period and oemid=@oemid
if exists (select 1 from gam_forecast where fiscal_period=@period and oem_id=@oemid)
	update gam_forecast set fcst_amt_sumByPart=@tamt where fiscal_period=@period and oem_id=@oemid
else
	insert into gam_forecast (oem_id,fiscal_period,fcst_amt,actual_amt,inputed_by,user_type,fcst_amt_SumByPart)
	values (@oemid,@period,0,0,0,'n',@tamt)
*/
exec sp_gam_ForecastCustomerPart_Update_autoUpdateTotalAmount @period,@oemid,1,@tamt output
set nocount off
GO
