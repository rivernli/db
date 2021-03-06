USE [BOC]
GO
/****** Object:  View [dbo].[vTop_ten_Project]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vTop_ten_Project]
AS
SELECT     [Projects(10)] AS Projects, [Project(4)] AS [Project No], Customer_Name AS [Customer Name], End_Customer AS [End Customer], 
                      Product_Name AS [Product Name], Part_number AS [Part Number], Configuration, [Material-Core] AS [material - Core], [Material-RCC] AS [Material - RCC], 
                      SUBSTRING([Projects(10)], 2, 2) AS [Layer Count], [Array Size(mm)] AS [Array Size], Unit_per_Panel AS [Unit Per Panel], ROUND([Panel Size(sqft)], 2) 
                      AS [Panel Size], CAST(ROUND(Material_Utilization_per_Panel, 2) AS nvarchar(20)) + '%' AS [Material Utilization per Panel], 
                      [Min_Line_Width & Spacing (mil)] AS [Min Line Width & Spacing (mil)], [Mechanical)_Through_Hole] AS [Mechanical Through Hole], 
                      [Mechanical Blind_Buried Hole] AS [Mechanical Blind Buried Hole], [Total Mechanical Hole Count], 
                      [Laser Via - External Layer] AS [Laser Via External Layer], [Laser Via - Internal Layer] AS [Laser Via Internal Layer], [Total Laser Via Hole Count], 
                      [Number of Plating], [Number of Pressing], [Number of Image Transfer], [Surface Finish(EAU)], [Surface Finish(ENTEK)], [Surface Finish(HASL)], 
                      [Surface Finish(GOLD PLATE)], [Surface Finish(EAG)], [Surface Finish(ETN)], [X-out], ROUND([Selling Price Per Unit (US$)], 2) 
                      AS [Selling Price Per Unit (US$)], ROUND([ASP US$], 2) AS [ASP US$], CAST(ROUND([Yield (Current)%], 2) AS nvarchar(20)) + '%' AS [Yield (Current)%], 
                      ROUND([Material cost (Scrap included)], 3) AS [Material cost (Scrap included)], CAST(ROUND([Material Cost _Sale(Current)], 2) AS nvarchar(20)) 
                      AS [Material Cost/Sale(Current)], ROUND([Total Cost per unit(US$)], 2) AS [Total Cost per unit(US$)], CAST(ROUND([%Margin], 2) AS nvarchar(20)) 
                      + '%' AS [%Margin], ROUND([Profit per PCS], 2) AS [Profit per PCS], [Production Volume Booking (Units)], ROUND([Production Volume Booking (Square F],
                       0) AS [Production Volume Booking (Square Foot], CAST(ROUND([% of Production Volume (Square Foot], 1) AS nvarchar(20)) 
                      + '%' AS [% of Production Volume (Square Foot)], ROUND([Total Sales (USD)], 2) AS [Total Sales (USD)], CAST(ROUND([% of Total Sales], 1) 
                      AS nvarchar(20)) AS [% of Total Sales], [Boc Item Type1], [Boc Item Type2], [Boc Item Type3], [Boc Item Type4], [Boc Item Type5], [Boc Item Type6], 
                      [Boc Item Type7], [Boc Item Type8], [Boc Item Type9], [Boc Item Type10], [Boc Item Type11], [Boc Item Type12], [Boc Item Type13], [Boc Item Type14], 
                      [Boc Item Type15], CAST(ROUND([Boc Consumed1], 2) AS nvarchar(20)) AS [Boc Consumed1], CAST(ROUND([Boc Consumed2], 2) AS nvarchar(20)) 
                      AS [Boc Consumed2], CAST(ROUND([Boc Consumed3], 2) AS nvarchar(20)) AS [Boc Consumed3], CAST(ROUND([Boc Consumed4], 2) AS nvarchar(20)) 
                      AS [Boc Consumed4], CAST(ROUND([Boc Consumed5], 2) AS nvarchar(20)) AS [Boc Consumed5], CAST(ROUND([Boc Consumed6], 2) AS nvarchar(20)) 
                      AS [Boc Consumed6], CAST(ROUND([Boc Consumed7], 2) AS nvarchar(20)) AS [Boc Consumed7], CAST(ROUND([Boc Consumed8], 2) AS nvarchar(20)) 
                      AS [Boc Consumed8], CAST(ROUND([Boc Consumed9], 2) AS nvarchar(20)) AS [Boc Consumed9], CAST(ROUND([Boc Consumed10], 2) AS nvarchar(20)) 
                      AS [Boc Consumed10], CAST(ROUND([Boc Consumed11], 2) AS nvarchar(20)) AS [Boc Consumed11], CAST(ROUND([Boc Consumed12], 2) 
                      AS nvarchar(20)) AS [Boc Consumed12], CAST(ROUND([Boc Consumed13], 2) AS nvarchar(20)) AS [Boc Consumed13], CAST(ROUND([Boc Consumed14], 
                      2) AS nvarchar(20)) AS [Boc Consumed14], CAST(ROUND([Boc Consumed15], 2) AS nvarchar(20)) AS [Boc Consumed15], 
                      ROUND([Percent of Boc Consumed1], 2) AS [Percent of Boc Consumed1], ROUND([Percent of Boc Consumed2], 2) AS [Percent of Boc Consumed2], 
                      ROUND([Percent of Boc Consumed3], 2) AS [Percent of Boc Consumed3], ROUND([Percent of Boc Consumed4], 2) AS [Percent of Boc Consumed4], 
                      ROUND([Percent of Boc Consumed5], 2) AS [Percent of Boc Consumed5], ROUND([Percent of Boc Consumed6], 2) AS [Percent of Boc Consumed6], 
                      ROUND([Percent of Boc Consumed7], 2) AS [Percent of Boc Consumed7], ROUND([Percent of Boc Consumed8], 2) AS [Percent of Boc Consumed8], 
                      ROUND([Percent of Boc Consumed9], 2) AS [Percent of Boc Consumed9], ROUND([Percent of Boc Consumed10], 2) AS [Percent of Boc Consumed10], 
                      ROUND([Percent of Boc Consumed11], 2) AS [Percent of Boc Consumed11], ROUND([Percent of Boc Consumed12], 2) AS [Percent of Boc Consumed12], 
                      ROUND([Percent of Boc Consumed13], 2) AS [Percent of Boc Consumed13], ROUND([Percent of Boc Consumed14], 2) AS [Percent of Boc Consumed14], 
                      ROUND([Percent of Boc Consumed15], 2) AS [Percent of Boc Consumed15], CAST(ROUND([% of Margin (total)], 1) AS nvarchar(20)) 
                      + '%' AS [% of Margin (total)], ROUND([Margin$ (total)], 2) AS [Margin$ (total)], ROUND([Cycle time1], 2) AS [Cycle time1], ROUND([Cycle time2], 2) 
                      AS [Cycle time2], ROUND([Cycle time3], 2) AS [Cycle time3], ROUND([Cycle time4], 2) AS [Cycle time4], ROUND([Cycle time5], 2) AS [Cycle time5], 
                      ROUND([Cycle time6], 2) AS [Cycle time6], ROUND([Cycle time7], 2) AS [Cycle time7], ROUND([Cycle time8], 2) AS [Cycle time8], ROUND([Cycle time9], 
                      2) AS [Cycle time9], ROUND([Cycle time10], 2) AS [Cycle time10], ROUND([Cycle time11], 2) AS [Cycle time11], ROUND([Cycle time12], 2) 
                      AS [Cycle time12], ROUND([Cycle time13], 2) AS [Cycle time13], ROUND([Cycle time14], 2) AS [Cycle time14], ROUND([Cycle time15], 2) 
                      AS [Cycle time15], CAST(Fiscal_Year AS nvarchar(10)) AS Fiscal_Year, CAST(Fiscal_Period AS nvarchar(8)) AS Fiscal_Period, Plant, 
                      [Projects(8)] AS Project, ROUND(T$TCUS, 2) AS T$TCUS, ROUND(T$GSRS, 2) AS T$GSRS, ROUND([Oh.Land], 2) AS [Oh.Land], 
                      ROUND([Oh.Waste.Water], 2) AS [Oh.Waste.Water], ROUND([Oh.Fresh.Water], 2) AS [Oh.Fresh.Water], ROUND([Oh.Eletricity], 2) AS [Oh.Eletricity], 
                      ROUND([Las.Maintenance], 2) AS [Las.Maintenance], ROUND([Las.Depreciation], 2) AS [Las.Depreciation], ROUND([Oh.Maintenance], 2) 
                      AS [Oh.Maintenance], ROUND([Oh.Depreciation], 2) AS [Oh.Depreciation], ROUND([Dos.Cost], 2) AS [Dos.Cost], ROUND([Process.Cost], 2) 
                      AS [Process.Cost], ROUND([Material.Cost], 2) AS [Material.Cost], ROUND([Indirect.Labor], 2) AS [Indirect.Labor], ROUND([Direct.Labor], 2) 
                      AS [Direct.Labor], T$MRBS
FROM         dbo.tfsboc100180

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
         Configuration = "(H (1[75] 4) )"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[49] 2) )"
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
      ActivePaneConfig = 10
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tfsboc100180"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 243
               Right = 391
            End
            DisplayFlags = 280
            TopColumn = 129
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      PaneHidden = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vTop_ten_Project'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vTop_ten_Project'
GO
