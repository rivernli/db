USE [Multek_BI]
GO
/****** Object:  StoredProcedure [dbo].[sp_gam_AutoUpdate_CEM_CSPN]    Script Date: 2014/11/12 17:08:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE procedure [dbo].[sp_gam_AutoUpdate_CEM_CSPN]
as


set nocount on
/**version 1 **/
/*
SELECT OEM, plant, 
ltrim(rtrim(int_Part_No)) as ipn,
ltrim(rtrim(cus_part_no)) as cpn,
sum(sqft)as tSqft, sum(amount)as tAmt, gamDate, iperiod,sum(remain_qty) as tQty,max(price) as maxPrice,min(price) as minPrice
into #tmp FROM dbo.gam_sales 
WHERE (shipment = 1) and cus_part_no <> 'Credit Charge' 
group by OEM, plant, int_Part_No,cus_part_no,gamDate,iperiod

select oem,plant,ipn,cpn,max(gamDate) as lastDate into #tmp2 from #tmp group by oem,plant,ipn,cpn


if exists (select 1 from sysobjects where name = 'cemFC_customerPN')
	drop table cemFC_customerPN

select b.*,convert(varchar(100),replace(b.cpn,' ','')) as cPN2, convert(varchar(100),b.cpn) as cPN3,
case when tQty > 0 then tAmt/tQty else 0 end as AvgPrice,
case when tAmt = 0 or tSqft=0 then 0 else tAmt / tSqft end AS asp into cemFC_customerPN
from #tmp2 as a left join #tmp as b 
on a.oem=b.oem and a.plant=b.plant and a.ipn=b.ipn and a.cpn=b.cpn and a.lastDate = b.gamDate
drop table #tmp
drop table #tmp2

update cemFC_customerPN set cPN3=cPN2
update cemFC_customerPN set cPN3=substring(cPN2,1,charindex('rev',cPN2)-1) where charindex('rev',cPN2) > 0

create index cpn on cemFC_customerPN (cpn) with fillfactor = 90 on [primary]
create index cpn2 on cemFC_customerPN (cpn2) with fillfactor = 90 on [primary]
*/
/*replace version 1*/
SELECT OEM, plant,ltrim(rtrim(int_Part_No)) as ipn,ltrim(rtrim(cus_part_no)) as cpn,
sum(sqft)as tSqft, sum(amount)as tAmt, gamDate, iperiod,sum(remain_qty) as tQty,max(price) as maxPrice,min(price) as minPrice
into #tmp FROM dbo.gam_sales 
WHERE (shipment = 1) and cus_part_no <> 'Credit Charge' 
group by OEM, plant, int_Part_No,cus_part_no,gamDate,iperiod

select oem,plant,ipn,cpn,max(gamDate) as lastDate,max(iperiod) as iperiod,max(maxPrice) as maPrice,min(minPrice) as miPrice into #tmp2 from #tmp group by oem,plant,ipn,cpn

if exists (select 1 from sysobjects where name = 'cemFC_customerPN')
	drop table cemFC_customerPN


select a.oem,a.plant,a.ipn,a.cpn,convert(varchar(100),replace(a.cpn,' ','')) as cPN2, convert(varchar(100),a.cpn) as cPN3,
a.lastDate as gamDate,a.iperiod,ttlQty as tQty,ttlAmt as tAmt,maPrice as maxPrice,miPrice as minPrice,expAsp as asp,ttlsqft as tSqft,
case when ttlAmt=0 or ttlQty=0 then (maPrice+miPrice)/2 else ttlAmt/ttlQty end as avgPrice
into cemFC_customerPN
from #tmp2 as a left join dbo.vw_gam_itemsDetail__byCusPartItem__lastPeriod as b on a.ipn=b.item and a.oem=b.oem and a.plant=b.plant
drop table #tmp
drop table #tmp2

update cemFC_customerPN set cPN3=cPN2
update cemFC_customerPN set cPN3=substring(cPN2,1,charindex('rev',cPN2)-1) where charindex('rev',cPN2) > 0
create index cpn on cemFC_customerPN (cpn) with fillfactor = 90 on [primary]
create index cpn2 on cemFC_customerPN (cpn2) with fillfactor = 90 on [primary]



/**version 2**/

if exists (select 1 from sysobjects where name = 'cemFC_ship_and_mss')
	drop table cemFC_ship_and_mss

select typ,orderType,customer_code,oem,int_part_no,cus_part_no,expected_invoice_date as gamDate,po_date,
remain_qty as qty,price,amount,currency,warehouse_id,sqft,plant,cal.iperiod,fiscalYear,fiscalPeriod,fiscalQuarter into cemFC_ship_and_mss
from multekchi_realtime.dbo.vw_gam_sales_all as sales
left join multek_zh.dbo.vw_calender_ext as cal
on cal.idate = expected_invoice_date
where expected_invoice_date >= 20100401 and warehouse_id <> ''
and cus_part_no <> 'Credit Charge'

update cemFC_ship_and_mss set plant ='B1' where plant='P2'
--drop table cemFC_ship_and_mss

SELECT customer_code,OEM, plant, ltrim(rtrim(int_Part_No)) as ipn,ltrim(rtrim(cus_part_no)) as cpn,
sum(sqft)as tSqft, sum(amount)as tAmt, gamDate, iperiod,sum(qty) as tQty,max(price) as maxPrice,min(price) as minPrice
into #temp2 from cemFC_ship_and_mss group by customer_code,OEM, plant, int_Part_No,cus_part_no,gamDate,iperiod

select customer_code,oem,plant,ipn,cpn,max(gamDate) as lastDate,max(iperiod) as lperiod 
into #temp3 from #temp2 group by customer_code,oem,plant,ipn,cpn

select b.*,convert(varchar(100),replace(b.cpn,' ','')) as cPN2, convert(varchar(100),b.cpn) as cPN3,
case when tQty = 0 or tAmt=0  then 0 else tAmt/tQty end as AvgPrice,
case when tAmt = 0 or tSqft=0 then 0 else tAmt / tSqft end AS asp 
into #temp4 from #temp3 as a left join #temp2 as b 
on a.customer_code=b.customer_code and a.oem=b.oem and a.plant=b.plant and a.ipn=b.ipn and a.cpn=b.cpn and a.lastDate = b.gamDate

if exists (select 1 from sysobjects where name = 'cemFC_customerPN2')
	drop table cemFC_customerPN2

select a.*,b.pSqft,b.pAmt,b.pQty,pMaxPrice,pMinPrice,
case when pQty =0 or pAmt=0 then 0 else pAmt/pQty end as pAvgPrice,
case when pAmt = 0 or pSqft=0 then 0 else pAmt / pSqft end AS pASP 
into cemFC_customerPN2
from #temp4 as a left join (
select customer_code,oem,plant,ipn,cpn,iperiod,sum(tsqft) as pSqft,sum(tamt) as pAmt,sum(tqty) as pQty,max(maxprice) as PMaxPrice,min(minPrice) as PMinPrice
from #temp2 group by customer_code,oem,plant,ipn,cpn,iperiod
)as b on a.customer_code=b.customer_code and a.oem=b.oem and a.plant=b.plant and a.ipn=b.ipn and a.cpn=b.cpn and a.iperiod=b.iperiod


update cemFC_customerPN2 set plant='B1' where plant='P2'

drop table #temp2
drop table #temp3
drop table #temp4

set nocount off

--select * from cemFC_customerPN







GO
