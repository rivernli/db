USE [multekchi_realtime]
GO
/****** Object:  View [dbo].[vw_gam_sales]    Script Date: 2014/11/12 17:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[vw_gam_sales]
as
SELECT oem, int_part_no, cus_part_no, po_date, expected_ship_date AS gamDate, remain_qty, price, amount, currency, warehouse_id, 0 AS shipment,plant, sqft
FROM          dbo.vw_gam__backlog
UNION ALL
SELECT OEM, int_part_no, cus_part_no, PO_date, Invoice_date AS gamDate, qty, price, amount, currency, warehouse_id, 1 AS shipment,plant, sqft
FROM         dbo.vw_gam__shipment
union all
SELECT OEM, int_part_no, cus_part_no, PO_date, Invoice_date AS gamDate, qty, price, amount, currency, warehouse_id, 1 AS shipment,plant, sqft
FROM         dbo.vw_gam__shipment_B3Sample


GO
