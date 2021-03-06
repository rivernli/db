USE [multekchi_realtime]
GO
/****** Object:  View [dbo].[uvw_jgzhang_test]    Script Date: 2014/11/12 17:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO










CREATE VIEW [dbo].[uvw_jgzhang_test]
AS

/*  这是把117上的TFSOLP101180转到111上的过程
	SELECT 'Chi' AS Loc,CONVERT(VARCHAR(15),a.t$orno) AS SONum,a.t$pono	AS SOPos,CONVERT(DATETIME,CONVERT(VARCHAR(10),a.t$invd,120))AS SHDate	,a.t$cuno  AS CustNum ,ISNULL(a.t$cunm,'')  AS InvCustName	,a.t$dqua AS ShBrds	,a.t$amnt AS ShDols	,a.t$item AS BaanItemNum,RTRIM(LTRIM(ISNULL(a.t$endc,'')))	AS [OEM Name],RTRIM(LTRIM(ISNULL(a.t$cunm,'')))	AS [Customer Name]	,
			dbo.ShipmentReport_fun_Get_Layers(a.t$item) AS Lays,	
			a.t$amnt AS	ShDols_loc,	b.T$COPR AS CostB_Loc,t$srnb AS ShipID,	RTRIM(LTRIM(ISNULL(c.T$PLNT,''))) AS Plant,a.t$cotp AS SOType,a.T$Area,a.t$nama as salesman
	FROM HKGNT117.multekchi_realtime.dbo.tfsolp101180 a,
		 (
			SELECT t$item,T$COPR FROM HKGNT117.FactoryLoading.dbo.TTIITM001180
		 ) b,
		 (
			SELECT t$cwar,T$PLNT FROM HKGNT117.FactoryLoading.dbo.TFSCPP201180 
			UNION 
			SELECT t$cwar,T$PLNT FROM HKGNT117.FactoryLoading.dbo.TFSCPP201183					
		 ) c
	WHERE a.t$item=b.T$ITEM
		AND a.t$cwar=c.t$cwar

*/
--下面是我把TFSOLP140180的字段转成SHIPPED_ALL的标准字段的过程, 请注意我在字段加的注释
SELECT    
		T$LOCA AS Loc,
		T$ORNO AS SONum,
		T$PONO AS SOPos,
		T$DRCT AS DD,
		T$SDAT AS SHDate,				--OK 上面的是TFSOLP101180.t$invd, 但TFSOLP140180中没有这个字段. ?
		T$S1DA AS Sh1Date,
		T$SH11 AS Sh1,
		T$SHTM AS ShTime,	
		T$CUST AS CustNum,				--OK 上面的是TFSOLP101180.t$cuno,  ?
		T$CUSN AS [Customer Name],		--OK 上面的是TFSOLP101180.t$cunm, 但TFSOLP140180中没有这个字段.  ?
		T$SHCU AS ShCust,
		T$SHCN AS ShCustName,
		T$CUNO AS InvCust,
		T$INSN AS InvCustName,			--OK 上面的是TFSOLP101180.t$cunm, 但TFSOLP140180中没有这个字段.  ?
		T$EONO AS CustPONum,
		T$BUSN AS BusSegNum,
		T$BUSG AS BusSeg,
		T$DUDT AS CDueDate,
		T$DODT AS DocDate,
		T$PARN AS CPartNum,
		T$PARV AS CPartRev,
		T$CPID AS CprtID,
		T$PRIY AS Priority,
		T$ORDS AS OrdBrds,
		T$SHDS AS ShBrds,				--OK 上面的是TFSOLP101180.t$dqua, 但TFSOLP140180中没有这个字段.  ?
		T$SHLS AS ShDols,				--OK 上面的是TFSOLP101180.t$amnt, 但TFSOLP140180中没有这个字段.  ?
		T$NREE AS NRE,
		T$TSAL AS TtlSales,
		T$PRIC AS PriceB,
		T$COST AS CostB,
		T$PROF AS ProfitB,
		T$UPRI AS UP,
		T$PRIP AS PriceP,
		T$COSP AS CostP,
		T$PROP AS ProfitP,
		T$PROT AS ProfitPct,
		T$PROI AS ProfitT,
		T$SODT AS SODate,
		CONVERT(VARCHAR(8),T$SOTM) AS SOTime,
		T$COTP AS SOType,
		T$ORDT AS OrdStat,
		T$INNU AS InRepNum,
		T$INNA AS InRepName,
		T$ORNU AS OutRepNum,
		T$ORNA AS OutRepName,
		T$CONN AS ContactNum,
		T$CONA AS ContactName,
		T$BITM AS BaanItemNum,			--OK 上面的是TFSOLP101180.t$item 
		T$PRON AS ProToolNum,
		T$OEMM AS OEM,
		T$OEMN AS [OEM Name],			--OK 上面的是TFSOLP101180.t$endc, 但TFSOLP140180中没有这个字段.  ?
		T$CARR AS Carrier,
		T$TRAN AS TrackNum,
		T$LAYS AS Lays,					--等RIVERN 上面的是ShipmentReport_fun_Get_Layers(TFSOLP101180.t$item) AS Lays, 请问TFSOLP140180中还需要转换吗?
		T$SELC AS SelCode,
		T$SHPA AS ShPan,
		T$SHLY AS ShLays,
		T$WIDB AS WidthB,
		T$LENB AS LengthB,
		T$AREB AS AreaB,
		T$WIDP AS WidthP,
		T$LENP AS LengthP,
		T$AREP AS AreaP,
		T$SUBS AS Subs,
		T$BASM AS BaseMtl,
		T$HOLB AS HolesB,
		T$HOLP AS HolesP,
		T$SMAH AS SmallHole,
		T$THIC AS Thick,
		T$ASPR AS AspRatio,
		T$SHBD AS ShBrdsDD,
		T$SHDD AS ShPanDD,
		T$SHAY AS ShLaysDD,
		T$SHDL AS ShDolsDD,
		T$ATLC AS ATLCusNum,
		T$SHPN AS ShipName,
		T$UPAR AS UPArr,
		T$BRAR AS BrdPerArr,
		T$AREA AS AreaA,
		T$CRRT AS CPRTSID,
		T$INVB AS InvBP,
		T$INVN AS InvBPName,
		T$CPRT AS CprtID_PDDim,
		T$PRTP AS ProToolNum_PDDim,
		T$SOSE AS SOSeq,
		T$SHDO AS ShDols_loc,				--OK 上面的是TFSOLP101180.t$amnt, 但TFSOLP140180中没有这个字段.  ?
		T$NREL AS NRE_loc,
		T$ITLS AS TtlSales_loc,
		T$PRIB AS PriceB_loc,
		T$COSL AS CostB_loc,				--OK 上面的是TTIITM001180.T$COPR, ?
		T$PROL AS ProfitB_loc,
		T$PRIL AS PriceP_loc,
		T$COPL AS CostP_loc,
		T$PRPL AS ProfitP_loc,
		T$PRFP AS ProfitPct_loc,
		T$PRFL AS ProfitT_loc,
		T$SHOC AS ShDolsDD_loc,
		T$ITEM AS Item,
		T$SHDT AS ShDateTime,
		--T$SHID AS ShipID,					--上面的是TFSOLP101180.t$srnb	?
		t$srnb AS ShipID,					--上面的是TFSOLP101180.t$srnb	?
		T$PLNT AS Plant,					--RIVERN要在BAAN里面处理TFSOLP140180  上面的是TFSCPP201180 和TFSCPP201183 中的T$PLNT, 目前TFSOLP140180中有许多PLANT='',15639条记录.
		T$BUSU AS Bus_Unit,
		T$INNA AS SalesMan
FROM    TFSOLP140180
WHERE T$BITM NOT LIKE '18%'   --订单不用理会，要过滤掉，这些单是内部交易，买卖材料的。










GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[33] 4[18] 2[31] 3) )"
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
         Begin Table = "TFSOLP140180"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 185
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'uvw_jgzhang_test'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'uvw_jgzhang_test'
GO
