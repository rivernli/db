USE [BOC]
GO
/****** Object:  View [dbo].[Trend_Product_Types]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Trend_Product_Types]
AS
SELECT     [Data Source Type].Data_Source, '1' AS Sequence, Week_Period.Fiscal_Year, Week_Period.Fiscal_Period, Trend_Key_Plant.Plant, 
                      'Week/Period' AS Product_Type, Trend_key_report_type.Description AS RType, Week_Period.Week_Period AS Tvalue
FROM         dbo.Trend_Key_Plant AS Trend_Key_Plant CROSS JOIN
                      dbo.[Data Source Type] AS [Data Source Type] CROSS JOIN
                      dbo.Week_Period AS Week_Period CROSS JOIN
                      dbo.Trend_key_report_type AS Trend_key_report_type
WHERE     (Trend_key_report_type.Description LIKE N'%Trend Product_Types%')
UNION ALL
SELECT     RTRIM(Data_Source) AS Data_Source, 
                      CASE Product_Type WHEN 'Week/Period' THEN 1 WHEN 'Others' THEN 3 WHEN 'Total per Week' THEN 4 WHEN 'Total' THEN 5 ELSE 2 END AS Sequence,
                       Fiscal_Year, Fiscal_Period, Plant, Product_Type, 'Trend Product_Types - Number Of Project' AS Rtype, No_of_Project
FROM         dbo.tfsboc104180
UNION ALL
SELECT     RTRIM(Data_Source) AS Data_Source, 
                      CASE Product_Type WHEN 'Week/Period' THEN 1 WHEN 'Others' THEN 3 WHEN 'Total per Week' THEN 4 WHEN 'Total' THEN 5 ELSE 2 END AS Sequence,
                       Fiscal_Year, Fiscal_Period, Plant, Product_Type, 'Trend Product_Types - ALC' AS Rtype, Avg_Layer_Count
FROM         dbo.tfsboc104180 AS tfsboc104180_1
UNION ALL
SELECT     RTRIM(Data_Source) AS Data_Source, 
                      CASE Product_Type WHEN 'Week/Period' THEN 1 WHEN 'Others' THEN 3 WHEN 'Total per Week' THEN 4 WHEN 'Total' THEN 5 ELSE 2 END AS Sequence,
                       Fiscal_Year, Fiscal_Period, Plant, Product_Type, 'Trend Product_Types - ASP' AS Rtype, ASP$
FROM         dbo.tfsboc104180 AS tfsboc104180_2
UNION ALL
SELECT     RTRIM(Data_Source) AS Data_Source, 
                      CASE Product_Type WHEN 'Week/Period' THEN 1 WHEN 'Others' THEN 3 WHEN 'Total per Week' THEN 4 WHEN 'Total' THEN 5 ELSE 2 END AS Sequence,
                       Fiscal_Year, Fiscal_Period, Plant, Product_Type, 'Trend Product_Types - ASP-Per_Layer' AS Rtype, ASP_Layer$
FROM         dbo.tfsboc104180 AS tfsboc104180_3
UNION ALL
SELECT     RTRIM(Data_Source) AS Data_Source, 
                      CASE Product_Type WHEN 'Week/Period' THEN 1 WHEN 'Others' THEN 3 WHEN 'Total per Week' THEN 4 WHEN 'Total' THEN 5 ELSE 2 END AS Sequence,
                       Fiscal_Year, Fiscal_Period, Plant, Product_Type, 'Trend Product_Types - Output-sqft' AS Rtype, Output_Sqft
FROM         dbo.tfsboc104180 AS tfsboc104180_4
UNION ALL
SELECT     RTRIM(Data_Source) AS Data_Source, 
                      CASE Product_Type WHEN 'Week/Period' THEN 1 WHEN 'Others' THEN 3 WHEN 'Total per Week' THEN 4 WHEN 'Total' THEN 5 ELSE 2 END AS Sequence,
                       Fiscal_Year, Fiscal_Period, Plant, Product_Type, 'Trend Product_Types - Output-k$' AS Rtype, Output_Amount
FROM         dbo.tfsboc104180 AS tfsboc104180_8
UNION ALL
SELECT     RTRIM(Data_Source) AS Data_Source, 
                      CASE Product_Type WHEN 'Week/Period' THEN 1 WHEN 'Others' THEN 3 WHEN 'Total per Week' THEN 4 WHEN 'Total' THEN 5 ELSE 2 END AS Sequence,
                       Fiscal_Year, Fiscal_Period, Plant, Product_Type, 'Trend Product_Types - Margin-k$' AS Rtype, Margin$
FROM         dbo.tfsboc104180 AS tfsboc104180_7
UNION ALL
SELECT     RTRIM(Data_Source) AS Data_Source, 
                      CASE Product_Type WHEN 'Week/Period' THEN 1 WHEN 'Others' THEN 3 WHEN 'Total per Week' THEN 4 WHEN 'Total' THEN 5 ELSE 2 END AS Sequence,
                       Fiscal_Year, Fiscal_Period, Plant, Product_Type, 'Trend Product_Types - Margin-%' AS Rtype, Margin_Percent
FROM         dbo.tfsboc104180 AS tfsboc104180_6

GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[26] 4[11] 2[45] 3) )"
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
         Configuration = "(H (4[30] 2[17] 3) )"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2[61] 3) )"
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
         Configuration = "(H (4[60] 2) )"
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
      ActivePaneConfig = 5
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
      Begin ColumnWidths = 10
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 3150
         Width = 3150
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 5
         Column = 3090
         Alias = 1845
         Table = 1785
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Trend_Product_Types'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'     Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Trend_Product_Types'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Trend_Product_Types'
GO
