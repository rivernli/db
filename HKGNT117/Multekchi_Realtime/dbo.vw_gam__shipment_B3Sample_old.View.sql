USE [multekchi_realtime]
GO
/****** Object:  View [dbo].[vw_gam__shipment_B3Sample_old]    Script Date: 2014/11/12 17:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_gam__shipment_B3Sample_old]
as
SELECT     tmp_sales.OEM, tmp_sales.int_part_no, tmp_sales.cus_part_no, tmp_sales.PO_date, tmp_sales.gamDate, tmp_sales.remain_qty, tmp_sales.price, 
                      tmp_sales.amount, tmp_sales.currency, tmp_sales.warehouse_id, tmp_sales.shipment, Multek_ZH.dbo.Baan_vTFSCPP201.T$PLNT AS plant, tmp_sales.sqft
FROM         (SELECT     T$ENDC AS OEM, T$CUPN AS cus_part_no, T$ITEM AS int_part_no, CONVERT(varchar(8), T$PODT, 112) AS PO_date, CONVERT(varchar(8), T$INVD, 112) 
                                              AS gamDate, T$DQUA AS remain_qty, T$PRIC AS price, T$AMNT AS amount, T$CCUR AS currency, T$CWAR AS warehouse_id, 1 AS shipment, 
                                              T$AREA AS sqft
                       FROM          dbo.TFSOLP102180
                       WHERE      (T$COTP = 'SMP') AND (T$CUPN NOT IN ('Tooling Charge', 'Cancellation Charge'))) AS tmp_sales LEFT OUTER JOIN
                      Multek_ZH.dbo.Baan_vTFSCPP201 ON tmp_sales.warehouse_id = Multek_ZH.dbo.Baan_vTFSCPP201.T$CWAR
WHERE     (Multek_ZH.dbo.Baan_vTFSCPP201.T$PLNT = 'B3')
GO
