USE [Multek_ZH]
GO
/****** Object:  View [dbo].[vw_non_production_with_Calender]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
SELECT     dbo.vw_non_production_report.factory, dbo.vw_non_production_report.department, dbo.vw_non_production_report.sub_work_center, 
                      dbo.vw_non_production_report.item_group, dbo.vw_non_production_report.item, dbo.vw_non_production_report.qty, dbo.vw_non_production_report.price, 
                      dbo.vw_non_production_report.amount, dbo.vw_non_production_report.Year, dbo.vw_non_production_report.period, dbo.vw_non_production_report.weekly, 
                      dbo.vw_non_production_report.issue_date, c.calenderDate, c.calenderYear, c.calenderMonth, c.calenderMonthDesc, c.calenderquarter, c.calenderquarterDesc, 
                      c.calenderWeek, c.calenderWeekDesc, c.enWeek, c.enMonth, c.FiscalYear, c.FiscalYearDesc, c.FiscalPeriod, c.FiscalPeriodDesc, c.FiscalQuarter, 
                      c.FiscalQuarterDesc
FROM         dbo.vw_non_production_report LEFT OUTER JOIN
                      dbo.vw_Calender AS c ON dbo.vw_non_production_report.issue_date = c.calenderDate
*/
CREATE VIEW [dbo].[vw_non_production_with_Calender]
AS
SELECT     RIGHT(dbo.fx_trim(Year), 4) AS fiscalYear, dbo.fx_getQuarterByPeriod(period) AS fiscalQuarter, period AS fiscalPeriod, period, factory, department, sub_work_center, 
                      item_group, item, qty, price, amount, Year, weekly, issue_date
FROM         dbo.vw_non_production_report

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
         Begin Table = "vw_non_production_report"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 210
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_non_production_with_Calender'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_non_production_with_Calender'
GO
