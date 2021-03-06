USE [Multek_SZ_New]
GO
/****** Object:  View [dbo].[View_1]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_1]
AS
SELECT     dbo.PT_Order.OrderNo, dbo.PT_Order.TransferingDepartmentAutoID, dbo.PT_Order.TransferingSiteOwnerUserID, dbo.PT_Order.ReceivingDepartmentAutoID, 
                      dbo.PT_Order.ReceivingSiteOwnerUserID, dbo.PT_Order.PartNumber, dbo.PT_Order.RevisionNumber, dbo.PT_Order.ToolNumber, dbo.PT_Order.CustomerCEM, 
                      dbo.PT_Order.CustomerOEM, dbo.PT_Order.DeliveryDate, dbo.PT_Order.CustomerApprove, dbo.PT_Order.SalesOrderOption, dbo.PT_Order.SalesOrderAttachment, 
                      dbo.PT_Order.SalesOrderPhysicalAttachment, dbo.PT_Order.SalesOrderComment, dbo.PT_Order.PurchaseOrderOption, dbo.PT_Order.PurchaseOrderAttachment, 
                      dbo.PT_Order.PurchaseOrderPhysicalAttachment, dbo.PT_Order.PurchaseOrderComment, dbo.PT_Order.TransferingInvolvedDepartmentAutoID, 
                      dbo.PT_Order.GoldenBoardShipment, dbo.PT_Order.GoldenBoardQuantity, dbo.PT_Order.GoldenBoardWhen, dbo.PT_Order.GoldenBoardAWB, 
                      dbo.PT_Order.GoldenBoardByWhom, dbo.PT_Order.GoldenBoardComment, dbo.PT_Order.RejectedBoardShipment, dbo.PT_Order.RejectedBoardQuantity, 
                      dbo.PT_Order.RejectedBoardWhen, dbo.PT_Order.RejectedBoardAWB, dbo.PT_Order.RejectedBoardByWhom, dbo.PT_Order.RejectedBoardComment, 
                      dbo.PT_Order.Closed, dbo.PT_Order.ClosedUserID, dbo.PT_Order.ClosedDate, dbo.PT_Order.CreatedUserID, dbo.PT_Order.CreatedDate, dbo.PT_Order.Deleted, 
                      dbo.PT_Order.DeletedUserID, dbo.PT_Order.DeletedDate, dbo.PT_Order.LastUpdatedUserID, dbo.PT_Order.LastUpdatedDate, 
                      dbo.PT_Users.BDM + '(' + dbo.PT_Users.Region + '\' + dbo.PT_Users.Account + ')' AS OwnerName, dbo.PT_Location.Name AS TransferringSiteName, 
                      PT_Location_1.Name AS ReceivingSiteName, PT_Users_1.BDM + '(' + PT_Users_1.Region + '\' + PT_Users_1.Account + ')' AS TransferringSiteOwnerName, 
                      PT_Users_2.BDM + '(' + PT_Users_2.Region + '\' + PT_Users_2.Account + ')' AS ReceivingSiteOwnerName, dbo.PT_Order.ReceivingSiteOwnerApprove, 
                      dbo.PT_Order.ReceivingSiteOwnerApproveDate, dbo.PT_Order.TransferringSiteOwnerApprove, dbo.PT_Order.TransferringSiteOwnerApproveDate, 
                      PT_Users_3.BDM + '(' + PT_Users_3.Region + '\' + PT_Users_3.Account + ')' AS ClosedName
FROM         dbo.PT_Order INNER JOIN
                      dbo.PT_Users ON dbo.PT_Order.CreatedUserID = dbo.PT_Users.UserID INNER JOIN
                      dbo.PT_Location ON dbo.PT_Order.TransferingDepartmentAutoID = dbo.PT_Location.AutoID INNER JOIN
                      dbo.PT_Location AS PT_Location_1 ON dbo.PT_Order.ReceivingDepartmentAutoID = PT_Location_1.AutoID INNER JOIN
                      dbo.PT_Users AS PT_Users_1 ON dbo.PT_Order.TransferingSiteOwnerUserID = PT_Users_1.UserID INNER JOIN
                      dbo.PT_Users AS PT_Users_2 ON dbo.PT_Order.ReceivingSiteOwnerUserID = PT_Users_2.UserID LEFT OUTER JOIN
                      dbo.PT_Users AS PT_Users_3 ON dbo.PT_Order.ClosedUserID COLLATE Chinese_PRC_CI_AS = PT_Users_3.UserID
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
         Begin Table = "PT_Order"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 306
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PT_Users"
            Begin Extent = 
               Top = 6
               Left = 344
               Bottom = 114
               Right = 515
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PT_Location"
            Begin Extent = 
               Top = 6
               Left = 553
               Bottom = 114
               Right = 704
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PT_Location_1"
            Begin Extent = 
               Top = 114
               Left = 38
               Bottom = 222
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PT_Users_1"
            Begin Extent = 
               Top = 114
               Left = 227
               Bottom = 222
               Right = 398
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PT_Users_2"
            Begin Extent = 
               Top = 114
               Left = 436
               Bottom = 222
               Right = 607
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PT_Users_3"
            Begin Extent = 
               Top = 114
               Left = 645
               Bottom = 222
               Right = 816
            End
           ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N' DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_1'
GO
