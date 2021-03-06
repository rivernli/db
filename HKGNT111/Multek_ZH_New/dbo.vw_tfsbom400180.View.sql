USE [Multek_ZH_New]
GO
/****** Object:  View [dbo].[vw_tfsbom400180]    Script Date: 11/06/2014 15:50:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_tfsbom400180]
AS
SELECT       T$PJNO, T$SERN, T$CRID, T$CRDT, T$LCDT, T$STAT, T$MBSP, T$ODSP, T$STSP, T$MASP, T$BUSP, T$CESU, T$CESP, T$CESS, T$CISU, T$CISP, T$CISS, T$DLIU, 
                         T$DLIP, T$DLIS, T$ILIU, T$ILIP, T$ILIS, T$MDSU, T$MDSP, T$MDSS, T$LDIU, T$LDIP, T$LDIS, T$LDMU, T$LDMP, T$LDMS, T$TCIU, T$TCIP, T$TCIS, T$GSRU, 
                         T$GSRP, T$GSRS, T$PRIC, T$MCSR, T$PRMG, T$PMGR, T$EPRP, T$EPPP, T$EPPC, T$VERS, T$AVER, T$TCUU, T$TCUP, T$TCUS, T$FDIR, T$BTYP, T$ATYP, 
                         T$TQTY, T$MRB1, T$MRB4, T$MR12, T$MR13, T$TXTA, T$PLNT, T$UFLG, T$SCRE, T$DCFA, T$CODA, T$COTI, T$PVER, T$MVER, T$OU13, T$APRJ, T$TSCU, 
                         T$TSCP, T$TSCS, T$QSTA, T$PLEN, T$PWID, T$UNST, T$STPL, T$PLUP, T$REFCNTD, T$REFCNTU
FROM            [hkgnt117].[multekchi_realtime].[dbo].[TFSBOM400180]

left join sgp_tmp_key on T$PJNO = fName

WHERE        (LEFT(T$PJNO, 1) = '$') and fName is null
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
         Begin Table = "TFSBOM400180"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 135
               Right = 208
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_tfsbom400180'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_tfsbom400180'
GO
