USE [multekchi_realtime]
GO
/****** Object:  View [dbo].[vw_gam__backlog_step1]    Script Date: 2014/11/12 17:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_gam__backlog_step1]
as
SELECT     T$DSCA AS oem, T$ITEM AS int_part_no, T$CUPN AS cus_part_no, CONVERT(varchar(8), T$ODAT, 112) AS po_date, CONVERT(varchar(8), T$PDAT, 112) 
                      AS expected_ship_date, remain_qty, price, amount, 'USD' AS currency, T$CWAR AS warehouse_id, 0 AS shipment, T$OUSQ AS sqft,
jobDate
from (
SELECT T$ORUA AS remain_qty, T$PRIC AS price, t$ORMN as amount,t$jdat as jobDate,*
FROM         Multek_ZH.dbo.TFSOLP122180
WHERE  t$flag='backlog' and   (T$TYPE = 'main') and t$year='fy2012' and t$prno=11
union all
SELECT T$FOUA AS remain_qty, T$PRIC AS price, t$FOMN as amount,t$jdat as jobDate,*
FROM         Multek_ZH.dbo.TFSOLP122180
WHERE  t$flag='shipment' and   (T$TYPE = 'main') and t$year='fy2012' and t$prno=11
) as xx
GO
