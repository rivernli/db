USE [multekchi_realtime]
GO
/****** Object:  View [dbo].[vw_gam__shipment_old]    Script Date: 2014/11/12 17:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_gam__shipment_old]
as
SELECT     T$ITEM AS int_part_no, T$CUPN AS cus_part_no, CONVERT(varchar(8), T$INVD, 112) AS Invoice_date, CONVERT(varchar(8), T$PODT, 112) AS PO_date, 
                      CONVERT(varchar(8), T$RQDT, 112) AS Request_ship_date, T$DQUA AS qty, T$PRIC AS price, T$AMNT AS amount, T$CCUR AS currency, T$ENDC AS OEM, 
                      T$CODA AS OEM_region, T$CWAR AS warehouse_id, T$COTP AS co_type, T$STYP AS s_type, T$AREA AS sqft
FROM         dbo.TFSOLP102180
WHERE     (T$COTP NOT IN ('RMA', 'BFS', 'RPL', 'SMP', 'CNR', 'ICO', 'PAC', 'SL8', 'SNE', 'TSL')) AND (T$CUPN NOT IN ('Tooling Charge', 'Cancellation Charge'))
GO
