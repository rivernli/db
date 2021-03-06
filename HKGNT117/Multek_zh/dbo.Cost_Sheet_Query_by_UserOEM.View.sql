USE [Multek_ZH]
GO
/****** Object:  View [dbo].[Cost_Sheet_Query_by_UserOEM]    Script Date: 2014/11/12 17:12:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Cost_Sheet_Query_by_UserOEM]
AS
SELECT     b.T$PJNO, b.T$SERN, b.T$CRID, b.T$CRDT, b.T$LCDT, b.T$STAT, b.T$MBSP, b.T$ODSP, b.T$STSP, b.T$MASP, b.T$BUSP, b.T$CESU, b.T$CESP, 
                      b.T$CESS, b.T$CISU, b.T$CISP, b.T$CISS, b.T$DLIU, b.T$DLIP, b.T$DLIS, b.T$ILIU, b.T$ILIP, b.T$ILIS, b.T$MDSU, b.T$MDSP, b.T$MDSS, b.T$LDIU, 
                      b.T$LDIP, b.T$LDIS, b.T$LDMU, b.T$LDMP, b.T$LDMS, b.T$TCIU, b.T$TCIP, b.T$TCIS, b.T$GSRU, b.T$GSRP, b.T$GSRS, b.T$PRIC, b.T$MCSR, 
                      b.T$PRMG, b.T$PMGR, b.T$EPRP, b.T$EPPP, b.T$EPPC, b.T$VERS, b.T$AVER, b.T$TCUU, b.T$TCUP, b.T$TCUS, b.T$FDIR, b.T$BTYP, b.T$ATYP, 
                      b.T$TQTY, b.T$MRB1, b.T$MRB4, b.T$MR12, b.T$MR13, b.T$TXTA, b.T$PLNT, b.T$UFLG, b.T$SCRE, b.T$DCFA, b.T$CODA, b.T$COTI, b.T$PVER, 
                      b.T$MVER, b.T$REFCNTD, b.T$REFCNTU, b.T$CSGP, b.T$DSCA, a.Account
FROM         dbo.Cost_Sheet_Query_CS_OEM_Authority AS a INNER JOIN
                      dbo.Cost_Sheet_Query_TFSBOM400180 AS b ON a.OEM = b.T$DSCA

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
         Begin Table = "a"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 99
               Right = 168
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "b"
            Begin Extent = 
               Top = 6
               Left = 206
               Bottom = 114
               Right = 344
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Cost_Sheet_Query_by_UserOEM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Cost_Sheet_Query_by_UserOEM'
GO
