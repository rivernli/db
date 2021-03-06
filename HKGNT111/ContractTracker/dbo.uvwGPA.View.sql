USE [ContractTracker]
GO
/****** Object:  View [dbo].[uvwGPA]    Script Date: 11/06/2014 15:55:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[uvwGPA]
AS
SELECT     dbo.GPA.GPANo, dbo.GPA.OwnerID, dbo.GPA.LegalID, dbo.GPA.SiteID, dbo.GPA.CustomerName, dbo.GPA.Products, dbo.GPA.KeyProductLine, 
                      dbo.GPA.AgreementID, dbo.GPA.ContractInDate, dbo.GPA.ExpectEDClosingDate, dbo.GPA.ActualClosingDate, dbo.GPA.StatusID, dbo.GPA.Attachment, 
                      dbo.GPA.PhysicalAttachment, dbo.GPA.Closed, dbo.GPA.CreatedDate, dbo.GPA.ClosedDate, dbo.GPA.ClosedOperator, dbo.GPA.Deleted, 
                      dbo.GPA.Remark, dbo.GPA.Deleter, dbo.GPA.DeletedDate, dbo.Agree.Name AS AgreementName, dbo.Site.Name AS SiteName, 
                      dbo.Legal.Name AS LegalName, dbo.Product.Name AS KeyProductLineName, dbo.Status.Name AS StatusName, 
                      dbo.fun_Get_Products_Name(dbo.GPA.Products) AS ProductName, dbo.Users.BDM + ' (' + dbo.Users.Account + ')' AS OwnerName, 
                      Users_1.BDM + ' (' + Users_1.Account + ')' AS ClosedOperatorName, Users_2.BDM + ' (' + Users_2.Account + ')' AS DeleterName
FROM         dbo.Agree INNER JOIN
                      dbo.Site INNER JOIN
                      dbo.GPA INNER JOIN
                      dbo.Legal ON dbo.GPA.LegalID = dbo.Legal.AutoID ON dbo.Site.AutoID = dbo.GPA.SiteID INNER JOIN
                      dbo.Product ON dbo.GPA.KeyProductLine = dbo.Product.AutoID ON dbo.Agree.AutoID = dbo.GPA.AgreementID INNER JOIN
                      dbo.Status ON dbo.GPA.StatusID = dbo.Status.AutoID INNER JOIN
                      dbo.Users ON dbo.GPA.OwnerID = dbo.Users.UserID LEFT OUTER JOIN
                      dbo.Users AS Users_2 ON dbo.GPA.Deleter = Users_2.UserID LEFT OUTER JOIN
                      dbo.Users AS Users_1 ON dbo.GPA.ClosedOperator = Users_1.UserID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[53] 4[27] 2[5] 3) )"
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
         Begin Table = "Agree"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 84
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Site"
            Begin Extent = 
               Top = 6
               Left = 227
               Bottom = 84
               Right = 378
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "GPA"
            Begin Extent = 
               Top = 84
               Left = 38
               Bottom = 192
               Right = 221
            End
            DisplayFlags = 280
            TopColumn = 18
         End
         Begin Table = "Legal"
            Begin Extent = 
               Top = 84
               Left = 259
               Bottom = 162
               Right = 410
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Product"
            Begin Extent = 
               Top = 162
               Left = 259
               Bottom = 240
               Right = 410
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Status"
            Begin Extent = 
               Top = 192
               Left = 38
               Bottom = 270
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Users"
            Begin Extent = 
               Top = 321
               Left = 502
               Bottom = 429
               Right = 660
            End
            DisplayFlags = 280
            TopCo' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'uvwGPA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'lumn = 3
         End
         Begin Table = "Users_2"
            Begin Extent = 
               Top = 6
               Left = 612
               Bottom = 114
               Right = 770
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "Users_1"
            Begin Extent = 
               Top = 6
               Left = 416
               Bottom = 114
               Right = 574
            End
            DisplayFlags = 280
            TopColumn = 2
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 32
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'uvwGPA'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'uvwGPA'
GO
