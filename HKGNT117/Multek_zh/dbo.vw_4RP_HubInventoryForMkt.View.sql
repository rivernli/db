USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vw_4RP_HubInventoryForMkt]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** remove some plus data ******/
CREATE VIEW [dbo].[vw_4RP_HubInventoryForMkt]
AS
SELECT     CONVERT(varchar(8), T$DATE, 112) AS iDate, T$LOCA AS location, T$DACA AS OEM, T$CSGS AS cusId, T$ITEM AS partNumber, T$AMNT AS shippedAmount, 
                      T$CCTY AS toCountry, CASE WHEN T$PLNT = 'P1' OR
                      T$PLNT = 'P2' THEN 'B1' ELSE T$PLNT END AS plant, T$DATE AS HubInDate, T$DDAT AS inDate, T$DQUA AS shippedQty, T$PRIC AS unitPrice, 
                      T$CWAR AS warehouse, T$CDEL AS delCode, T$CSDS AS CS, T$EONO AS customerPO, T$CUNO AS customerCode, T$DSCA AS customerPartNo, T$CRFN AS crfCode, 
                      T$ORNO AS BaanSO
FROM         dbo.TFSOLP114180
WHERE     (T$DDAT = CONVERT(varchar(12), GETDATE(), 110)) AND (NOT (T$ITEM = 'L06H943A')) OR
                      (T$DDAT = CONVERT(varchar(12), GETDATE(), 110)) AND (NOT (T$ORNO = 386846)) OR
                      (T$DDAT = CONVERT(varchar(12), GETDATE(), 110)) AND (NOT (T$PONO IN (1000, 5000)))

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
         Configuration = "(H (4 [30] 2 [40] 3))"
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
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "TFSOLP114180"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 198
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_4RP_HubInventoryForMkt'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_4RP_HubInventoryForMkt'
GO
