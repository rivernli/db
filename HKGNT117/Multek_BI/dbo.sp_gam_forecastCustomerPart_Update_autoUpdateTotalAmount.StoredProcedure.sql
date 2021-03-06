USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_forecastCustomerPart_Update_autoUpdateTotalAmount]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_gam_forecastCustomerPart_Update_autoUpdateTotalAmount]
@period int,@oemid int, @update bit=1,@tamt int =0 output
as


declare @cp int,@mcp int,@c int
select @cp=multek_zh.dbo.fx_getCurrentPeriod(),@c=0,@mcp=@cp
/*2013-10-28
if(@period <= @cp)
	return
*/
if(@period < @cp)
	return
	
declare @cemName nvarchar(100), @cemPlant nvarchar(10)
select @cemName=OEMName,@cemPlant=Plant from [dbo].[vw_gam_OEMcomb]  as a join [dbo].[gam_cem_oemName] on oemName=baanName where oemid=@oemid
if (@cemName is not null)
begin
	if(@period <=@cp)
	begin
		select @cp = multek_zh.dbo.[fx_PeriodAdd](@period,-1),@c=1,@mcp=@period
	end
	else
	begin
		while(@mcp<> @period and @c < 12)
		begin
			select @c=@c+1,@mcp=multek_zh.[dbo].[fx_PeriodAdd](@cp,@c)
		end
	end 
	
	if(@mcp=@period)
	begin
		select @tamt = case when @c=1 then sum(p1) else
			case when @c=2 then sum(p2) else
				case when @c=3 then sum(p3) else
					case when @c=4 then sum(p4) else
						case when @c=5 then sum(p5) else
							sum(p6) 
						end
					end
				end
			end
		end
		from [dbo].[GAM_CEM_Forecast] where period=@cp and oem=@cemName and plant=@cemPlant
	end
	select @tamt=isnull(@tamt,0) + isnull(sum(amt),0) from gam_part_forecast where period=@period and oemid=@oemid and project like '%]%]%]'
end
else
begin
	select @tamt=isnull(sum(amt),0) from gam_part_forecast where period=@period and oemid=@oemid
end
if(@update=1)
begin
if exists (select 1 from gam_forecast where fiscal_period=@period and oem_id=@oemid)
	update gam_forecast set fcst_amt_sumByPart=@tamt where fiscal_period=@period and oem_id=@oemid
else
	insert into gam_forecast (oem_id,fiscal_period,fcst_amt,actual_amt,inputed_by,user_type,fcst_amt_SumByPart)
	values (@oemid,@period,0,0,0,'n',@tamt)
end
GO
