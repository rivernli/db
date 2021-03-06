USE [multekchi_realtime]
GO
/****** Object:  View [dbo].[vTFSOLP101180_bk]    Script Date: 2014/11/12 17:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vTFSOLP101180_bk]
AS
SELECT     a.T$ORNO, a.T$PONO, a.T$SRNB, a.T$BAD1, a.T$BAD2, a.T$COBA, a.T$CUNO, a.T$CUNM, a.T$ITEM, a.T$CUPN, a.T$CWAR, a.T$EONO, a.T$TTYP, a.T$INVN, 
                      a.T$INVD, a.T$PODT, a.T$RQDT, a.T$DQUA, CAST(a.T$PRIC AS decimal(15, 4)) AS T$PRIC, a.T$CCUR, CAST(a.T$AMNT AS decimal(15, 4)) AS T$AMNT, 
                      CAST(a.T$AREA AS decimal(15, 4)) AS T$AREA, a.T$REFA, a.T$ENDC, a.T$CODA, a.T$NAMA, a.T$CSCO, a.T$USNM, a.T$SEGM, a.T$COTP, a.T$CDSC, a.T$STYP, 
                      a.T$FIDS, a.T$PSPL, CASE WHEN len(rtrim(ltrim(a.T$ITEM))) < 9 THEN a.T$PRDN WHEN len(rtrim(ltrim(a.T$ITEM))) > 9 THEN c.T$PRDN END AS T$PRDN, a.T$FLEX, 
                      a.T$ISEG, a.T$DESC, b.T$CDEL, c.T$OTYP
FROM         dbo.TFSOLP101180 AS a LEFT OUTER JOIN
                      HKGNT137.MultekChi_RealTime.dbo.vTFSDELCOD180 AS b ON a.T$ORNO = b.T$ORNO AND a.T$PONO = b.T$PONO AND a.T$RQDT = CONVERT(datetime, 
                      b.T$RQDATE) LEFT OUTER JOIN
                      dbo.vTFSCPP200180 AS c ON a.T$ITEM = c.T$ITEM
WHERE     (a.T$INVD >= '2005-01-01') AND (a.T$RQDT <> '1901-01-01')
UNION ALL
SELECT     a.T$ORNO, a.T$PONO, a.T$SRNB, a.T$BAD1, a.T$BAD2, a.T$COBA, a.T$CUNO, a.T$CUNM, a.T$ITEM, a.T$CUPN, a.T$CWAR, a.T$EONO, a.T$TTYP, a.T$INVN, 
                      a.T$INVD, a.T$PODT, a.T$RQDT, a.T$DQUA, CAST(a.T$PRIC AS decimal(15, 4)) AS T$PRIC, a.T$CCUR, CAST(a.T$AMNT AS decimal(15, 4)) AS T$AMNT, 
                      CAST(a.T$AREA AS decimal(15, 4)) AS T$AREA, a.T$REFA, a.T$ENDC, a.T$CODA, a.T$NAMA, a.T$CSCO, a.T$USNM, a.T$SEGM, a.T$COTP, a.T$CDSC, a.T$STYP, 
                      a.T$FIDS, a.T$PSPL, CASE WHEN len(rtrim(ltrim(a.T$ITEM))) < 9 THEN a.T$PRDN WHEN len(rtrim(ltrim(a.T$ITEM))) > 9 THEN c.T$PRDN END AS T$PRDN, a.T$FLEX, 
                      a.T$ISEG, a.T$DESC, b.T$CDEL, c.T$OTYP
FROM         dbo.TFSOLP101180_correct_data AS a LEFT OUTER JOIN
                      HKGNT137.MultekChi_RealTime.dbo.TFSDELCOD180_correct_data AS b ON a.T$ORNO = b.T$ORNO AND a.T$PONO = b.T$PONO AND 
                      a.T$RQDT = b.T$RQDATE LEFT OUTER JOIN
                      dbo.vTFSCPP200180 AS c ON a.T$ITEM = c.T$ITEM
WHERE     (a.T$FLAG = '1')

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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vTFSOLP101180_bk'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vTFSOLP101180_bk'
GO
