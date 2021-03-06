USE [Multek_ZH]
GO
/****** Object:  View [dbo].[Baan_vTFSCPP200180]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Baan_vTFSCPP200180]
AS
SELECT     T$PITM, T$PVER, T$PFIX, T$CEMN, T$CSGS, T$CUNO, T$CDEL, T$DSCA, T$CREP, T$CRTE, T$CBRN, T$CPER, T$CCDE, T$REMK, T$INDT, T$INTM, 
                      T$INID, T$MODT, T$MOTM, T$MOID, T$MFL1, T$MFL2, T$PFIX1, T$PCBA, T$ITEM, T$COPY, T$CITG, T$ISEG, T$STYP, T$ASST, T$PRDN, T$STMA, 
                      T$OTYP, T$REFCNTD, T$REFCNTU
FROM         OPENQUERY(AS1P1, 
                      'SELECT T$PITM, T$PVER, T$PFIX, T$CEMN, T$CSGS, T$CUNO, T$CDEL, T$DSCA, T$CREP, T$CRTE, T$CBRN, T$CPER, T$CCDE, T$REMK, to_char(T$INDT,''YYYY-MM-DD'') as T$INDT, T$INTM, 
                      T$INID, to_char(T$MODT,''YYYY-MM-DD'') as T$MODT, T$MOTM, T$MOID, T$MFL1, T$MFL2, T$PFIX1, T$PCBA, T$ITEM, T$COPY, T$CITG, T$ISEG, T$STYP, T$ASST, T$PRDN, T$STMA, 
                      T$OTYP, T$REFCNTD, T$REFCNTU FROM BAAN.TFSCPP200180')
                       AS derivedtbl_1

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
         Begin Table = "derivedtbl_1"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 189
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Baan_vTFSCPP200180'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Baan_vTFSCPP200180'
GO
