USE [multekchi_realtime]
GO
/****** Object:  View [dbo].[vw_gam_sales_all]    Script Date: 2014/11/12 17:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[vw_gam_sales_all]
as
select * from (
SELECT  'mss' as typ, t$odty as orderType,t$cuno as customer_code,  T$OEMS AS oem, T$ITEM AS int_part_no, T$CPAR AS cus_part_no, 
CONVERT(varchar(8), T$PDAT, 112) AS expected_invoice_date, 
CONVERT(varchar(8), T$RGDT, 112) AS po_date,
CONVERT(varchar(8), T$PDAT, 112) AS expected_ship_date, 
T$BQTY AS remain_qty, T$PRIC AS price, T$BAMNT AS amount, 'USD' AS currency, T$CWAR AS warehouse_id, T$SQFT AS sqft,T$PLNT AS plant
FROM         Multek_ZH.dbo.TFSOLP131180
WHERE     (T$RETY = 1) AND (CONVERT(varchar(8), T$RGDT, 112) = CONVERT(varchar(8), GETDATE() - 1, 112)) AND (CONVERT(varchar(8), T$PDAT, 112) < 20990000)
union all
SELECT 'shipment' as typ,sotype as orderType,invCust as customer_code, [OEM Name] AS oem, BaanItemNum AS int_part_no,CPartNum AS cus_part_no,
CONVERT(varchar(8), Invoice_Date, 112) AS invoice_date, 
CONVERT(varchar(8), PO_Date, 112) AS po_date, 
CONVERT(varchar(8), Cust_Req_Date, 112) AS request_ship_date, 
ShBrds AS qty, UnitPrice AS price, ShDols AS amount, Currency, Warehouse AS warehouse_id, 
AreaA AS sqft, Plant
FROM         multekchi_realtime.dbo.vcr_Shipped_All_China
where (CPartNum NOT IN ('Tooling Charge', 'Cancellation Charge'))
) as vw_gam_sales_all
WHERE     (orderType NOT IN ('RMA', 'BFS', 'RPL', 'SMP', 'CNR', 'ICO', 'PAC', 'SL8', 'SNE', 'TSL')) 

GO
