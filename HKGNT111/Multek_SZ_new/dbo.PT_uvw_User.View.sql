USE [Multek_SZ_New]
GO
/****** Object:  View [dbo].[PT_uvw_User]    Script Date: 11/06/2014 15:47:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[PT_uvw_User]
AS
SELECT     dbo.PT_Users.AutoID AS UserAutoID, dbo.PT_Users.DepartmentAutoID, dbo.PT_Users.UserID, dbo.PT_Users.Region, dbo.PT_Users.Account, 
                      dbo.PT_Users.Email, dbo.PT_Users.Phone, dbo.PT_Users.Position, dbo.PT_Users.BDM, dbo.PT_Users.Administrator, dbo.PT_Users.SiteOwner, 
                      dbo.PT_Users.Enable, dbo.PT_Department.Name AS DepartmentName, dbo.PT_Department.Distribution, dbo.PT_Department.CreatePT, 
                      dbo.PT_Department.Enable AS DepartmentEnable, dbo.PT_Location.Name AS SiteName, dbo.PT_Location.Alias, 
                      dbo.PT_Location.Enable AS SiteEnable, dbo.PT_Department.AutoID, dbo.PT_Location.AutoID AS SiteAutoID
FROM         dbo.PT_Users INNER JOIN
                      dbo.PT_Department ON dbo.PT_Users.DepartmentAutoID = dbo.PT_Department.AutoID INNER JOIN
                      dbo.PT_Location ON dbo.PT_Department.LocationAutoID = dbo.PT_Location.AutoID
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[30] 4[34] 2[19] 3) )"
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
         Begin Table = "PT_Users"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 209
            End
            DisplayFlags = 280
            TopColumn = 8
         End
         Begin Table = "PT_Department"
            Begin Extent = 
               Top = 6
               Left = 247
               Bottom = 114
               Right = 401
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "PT_Location"
            Begin Extent = 
               Top = 6
               Left = 439
               Bottom = 114
               Right = 590
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
      Begin ColumnWidths = 23
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
   ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PT_uvw_User'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'      Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PT_uvw_User'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'PT_uvw_User'
GO
