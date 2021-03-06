USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_itemsDetailForForecastDownload]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
  
CREATE procedure [dbo].[sp_gam_itemsDetailForForecastDownload] @period int  
as  
set nocount on  
  
select *,case when ttlAmt =0 or ttlSqft=0 then (maxAsp + minAsp)/2 else ttlAmt/ttlSqft end as expASP  
into #lastPart  
from   
(  
  
 select y.OEM,y.plant,y.cus_part_no,y.layer,y.tech,surf,y.iperiod,y.item,  
 sum(amount) as ttlAmt ,sum(sqft) as ttlSqft,sum(qty) as ttlQty,  
 max(asp) as maxAsp,min(asp) as minAsp  
 from  
 (  
  select OEM,plant,cus_part_no,max(iperiod) as iperiod,max(item) as item  
  from gam_itemsDetail where amount <> 0 and sqft <> 0   
  group by OEM,plant,cus_part_no  
    
 ) as h left join gam_itemsDetail as y  
 on h.item=y.item and h.oem=y.oem and h.cus_part_no=y.cus_part_no  
 and h.iperiod=y.iperiod  
 group by y.OEM,y.plant,y.cus_part_no,y.layer,y.tech,y.surf,y.iperiod,y.item  
  
) as single_itemDetail  
  
  
select period as ForecastPeriod,project as cusPart,amt as forecastAmount,  
o.userName,o.oemid,cusoem,o.oemName,o.plant,  
item,expASP,iperiod as expASPperiod,asp as cusASP,  
maxAsp,minAsp  
,layer,tech,surf,ttlAmt,ttlSqft,ttlQty  
  
from gam_part_forecast as f   
left join vw_gam_OEMcomb as o on f.oemid=o.oemid  
left join #lastPart as p  
on f.project=p.cus_part_no and o.oemName=p.oem and o.plant=p.plant and p.iperiod=f.period  
where o.isvalid=1 and f.period >=@period  
  
  
drop table #lastPart  
  
set nocount off
GO
