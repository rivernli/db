USE [multekchi_realtime]
GO
/****** Object:  View [dbo].[vw_gam_sales__old]    Script Date: 2014/11/12 17:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_gam_sales__old]
AS
SELECT     tmp_sales.oem, tmp_sales.int_part_no, tmp_sales.cus_part_no, tmp_sales.po_date, tmp_sales.gamDate, tmp_sales.remain_qty, tmp_sales.price, tmp_sales.amount,
                       tmp_sales.currency, tmp_sales.warehouse_id, tmp_sales.shipment, Multek_ZH.dbo.Baan_vTFSCPP201.T$PLNT AS plant, tmp_sales.sqft
FROM         (SELECT     oem, int_part_no, cus_part_no, po_date, expected_ship_date AS gamDate, remain_qty, price, amount, currency, warehouse_id, 0 AS shipment, sqft
                       FROM          dbo.vw_gam__backlog
                       UNION ALL
                       SELECT     OEM, int_part_no, cus_part_no, PO_date, Invoice_date AS gamDate, qty, price, amount, currency, warehouse_id, 1 AS shipment, sqft
                       FROM         dbo.vw_gam__shipment) AS tmp_sales LEFT OUTER JOIN
                      Multek_ZH.dbo.Baan_vTFSCPP201 ON tmp_sales.warehouse_id = Multek_ZH.dbo.Baan_vTFSCPP201.T$CWAR
UNION ALL
SELECT     oem, int_part_no, cus_part_no, po_date, gamDate, remain_qty, price, amount, currency, warehouse_id, shipment, plant, sqft
FROM         dbo.vw_gam__shipment_B3Sample

GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4[30] 2[40] 3) )"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 3
   End
   Begin DiagramPane = 
      PaneHidden = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 5
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_gam_sales__old'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_gam_sales__old'
GO
