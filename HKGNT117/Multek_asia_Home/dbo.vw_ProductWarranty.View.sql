USE [Multek_AsiaHome]
GO
/****** Object:  View [dbo].[vw_ProductWarranty]    Script Date: 2014/11/12 17:07:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_ProductWarranty]
AS
SELECT     dbo.ProductWarranty_Base.WarrantyId, dbo.ProductWarranty_Base.CustomerName, dbo.ProductWarranty_Base.CustomerType, 
                      dbo.ProductWarranty_Base.ProductApplication, dbo.ProductWarranty_Base.ProductGroup, dbo.ProductWarranty_Base.ContractName, 
                      dbo.ProductWarranty_Base.ContractNumber, dbo.ProductWarranty_Base.ContractDate, dbo.ProductWarranty_Base.ContractValidity, 
                      dbo.ProductWarranty_Base.Site, dbo.ProductWarranty_Base.Representative, dbo.ProductWarranty_Base.WarrantyTime, 
                      dbo.ProductWarranty_Base.WarrantyDefined, dbo.ProductWarranty_Base.MaxLiability, dbo.ProductWarranty_Base.MaxLiabilityDefined, 
                      dbo.ProductWarranty_Base.MaxLiabilityCurrency, dbo.ProductWarranty_Base.MaxLiabilityRemark, dbo.ProductWarranty_Base.PCBACostAgreed, 
                      dbo.ProductWarranty_Base.MaxCreditCost, dbo.ProductWarranty_Base.BOMShown, dbo.ProductWarranty_Base.CustomerSite, 
                      dbo.ProductWarranty_Base.CreatedOn, dbo.ProductWarranty_Base.CreatedBy, dbo.ProductWarranty_Base.ModifiedOn, 
                      dbo.ProductWarranty_Base.ModifiedBy, dbo.ProductWarranty_Base.Deleted, dbo.ProductWarranty_Base.Owner, 
                      dbo.ProductWarranty_User.FullName, dbo.ProductWarranty_User.EmailAddress, dbo.ProductWarranty_User.UserId, 
                      dbo.ProductWarranty_User.sAMAccountName, dbo.ProductWarranty_User.Domain, dbo.ProductWarranty_Base.WarrantyTimeType, 
                      dbo.ProductWarranty_Base.MaxCreditCostType, dbo.ProductWarranty_Base.MaxCreditCostUnlimited
FROM         dbo.ProductWarranty_Base LEFT OUTER JOIN
                      dbo.ProductWarranty_User ON dbo.ProductWarranty_Base.CreatedBy = dbo.ProductWarranty_User.UserId

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
         Begin Table = "ProductWarranty_Base"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 158
               Right = 233
            End
            DisplayFlags = 280
            TopColumn = 24
         End
         Begin Table = "ProductWarranty_User"
            Begin Extent = 
               Top = 6
               Left = 461
               Bottom = 121
               Right = 628
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
      Begin ColumnWidths = 28
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_ProductWarranty'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_ProductWarranty'
GO
