USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_AutoUpdate_from_Shipment_Backlog]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_gam_AutoUpdate_from_Shipment_Backlog]
as

set nocount on

if exists (select 1 from sysobjects where name = 'gam_sales')
	drop table gam_sales

select sales.*,cal.iperiod,fiscalYear,fiscalPeriod,fiscalQuarter 
into gam_sales from multekchi_realtime.dbo.vw_gam_sales as sales
left join multek_zh.dbo.vw_calender_ext as cal
on cal.idate = gamDate
where gamDate >= 20100401 and warehouse_id <> ''

update gam_sales set plant = 'B1' where plant='P1'
update gam_sales set plant = 'B1' where plant='P2'
--filter the idate after 20091231.

/*set period to current period if loading period < current period*/
declare @current_period int
select @current_period = multek_zh.[dbo].[fx_getPeriodDate](default)
update gam_sales set iperiod=cal.iperiod, fiscalYear=cal.fiscalYear, fiscalPeriod=cal.fiscalPeriod, fiscalQuarter=cal.fiscalQuarter
from gam_sales left join (select top 1 * from multek_zh.dbo.vw_calender_ext where iperiod = @current_period) as cal on 1=1
where shipment=0 and gam_sales.iperiod < @current_period
/*end set period ...*/


update gam_sales set oem = dbo.fx_trim(oem) where oem like ' %'

exec sp_gam_AutoUpdate_OEMList

exec sp_gam_AutoUpdate_ActualAmt_All

--log before 2 days in new period
declare @cp int, @msg nvarchar(100)
select @cp=iperiod from multek_zh.dbo.vw_CalenderLDP
where lastDate between convert(nvarchar(8),getdate()-2,112) and convert(nvarchar(8),getdate(),112)
if @cp is not null and @cp > 0
	exec dbo.sp_gam_AutoSave_ForecastPartLog @msg output,@cp


truncate table gam_itemsDetail
insert into gam_itemsDetail
SELECT     p.OEM, p.plant, p.int_Part_No AS item,p.cus_part_no, p.asp, p.layer, t.T$ASTR AS tech, 
s.T$ASTR AS surf, p.gamDate, p.sqft, p.amount, p.iperiod,price,remain_qty as qty,convert(nvarchar(50),'UNKNOW') as groupTech
FROM
(
SELECT OEM, plant, int_Part_No,cus_part_no, case when amount = 0 or sqft=0 then 0 else amount / sqft end AS asp, 
sqft, amount, gamDate, iperiod,price,remain_qty,
case when (ASCII(SUBSTRING(int_Part_No, 2, 1)) BETWEEN 48 AND 57) AND (ASCII(SUBSTRING(int_Part_No, 3, 1)) BETWEEN 48 AND 57) 
then CONVERT(int, SUBSTRING(int_Part_No, 2, 2)) else null end as layer
FROM dbo.gam_sales WHERE (shipment = 1)
) AS p 
LEFT OUTER JOIN FactoryLoading.dbo.TFIATT006180 AS t ON t.T$ITEM = p.int_Part_No AND t.T$ATTR = 'type' LEFT OUTER JOIN
FactoryLoading.dbo.TFIATT006180 AS s ON s.T$ITEM = p.int_Part_No AND s.T$ATTR = 'surf'

update gam_itemsDetail set groupTech='STD' where tech like 'STD%'
update gam_itemsDetail set groupTech='BVH' where tech like 'BVH%'
update gam_itemsDetail set groupTech='ELIC' where tech like 'ELIC%'
update gam_itemsDetail set groupTech='EMBEDDED COIN' where tech like 'EMBEDDED COIN%'
update gam_itemsDetail set groupTech='BARE FPC' where tech like 'BARE FPC%'
update gam_itemsDetail set groupTech='BARE RIGID' where tech like 'BARE RIGID%'
update gam_itemsDetail set groupTech='HDI 1+N+1' where tech like 'HDI 1+%'
update gam_itemsDetail set groupTech='HDI 2+N+2' where tech like 'HDI 2+%'
update gam_itemsDetail set groupTech='HDI 3+N+3' where tech like 'HDI 3+%'
update gam_itemsDetail set groupTech='HDI 4+N+4' where tech like 'HDI 4+%'

update gam_itemsDetail set groupTech='STD' where tech like '>= % Layers' and groupTech='UNKNOW'
update gam_itemsDetail set groupTech='STD' where tech like '% layers' and groupTech='UNKNOW'
and dbo.fx_trim(substring(tech,1,1)) in ('1','2','3','4','5','6','7','8','9','0')


exec sp_gam_AutoUpdate_CEM_CSPN


exec sp_gam_forecat_ReCal_OEMPlantAmt_All_auto
set nocount off




















GO
