USE [multekchi_realtime]
GO
/****** Object:  Table [dbo].[frank_shipped_all_china]    Script Date: 2014/11/12 17:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[frank_shipped_all_china](
	[Loc] [varchar](3) NOT NULL,
	[SONum] [char](9) NULL,
	[SOPos] [numeric](28, 0) NULL,
	[DD] [numeric](28, 0) NULL,
	[SHDate] [datetime] NULL,
	[Sh1Date] [char](10) NULL,
	[Sh1] [int] NULL,
	[ShTime] [char](10) NULL,
	[CustNum] [char](50) NULL,
	[Customer Name] [char](150) NULL,
	[ShCust] [char](10) NULL,
	[ShCustName] [char](150) NULL,
	[InvCust] [char](10) NULL,
	[InvCustName] [char](150) NULL,
	[CustPONum] [char](50) NULL,
	[BusSegNum] [char](8) NULL,
	[BusSeg] [char](50) NULL,
	[CDueDate] [char](10) NULL,
	[DocDate] [char](10) NULL,
	[CPartNum] [varchar](50) NULL,
	[CPartRev] [varchar](6) NULL,
	[CprtID] [int] NULL,
	[Priority] [decimal](15, 0) NULL,
	[OrdBrds] [decimal](15, 0) NULL,
	[ShBrds] [decimal](15, 0) NULL,
	[ShDols] [float] NULL,
	[NRE] [decimal](17, 4) NULL,
	[TtlSales] [decimal](17, 4) NULL,
	[PriceB] [decimal](17, 4) NULL,
	[CostB] [decimal](17, 4) NULL,
	[ProfitB] [decimal](17, 4) NULL,
	[UP] [numeric](38, 0) NULL,
	[PriceP] [decimal](17, 4) NULL,
	[CostP] [decimal](17, 4) NULL,
	[ProfitP] [decimal](17, 4) NULL,
	[ProfitPct] [decimal](15, 4) NULL,
	[ProfitT] [decimal](17, 4) NULL,
	[SODate] [char](10) NULL,
	[SOTime] [varchar](8) NULL,
	[SOType] [char](3) NULL,
	[OrdStat] [numeric](28, 0) NULL,
	[InRepNum] [char](10) NULL,
	[InRepName] [char](35) NULL,
	[OutRepNum] [char](10) NULL,
	[OutRepName] [char](35) NULL,
	[ContactNum] [char](9) NULL,
	[ContactName] [char](35) NULL,
	[BaanItemNum] [varchar](50) NULL,
	[ProToolNum] [char](16) NULL,
	[OEM] [char](10) NULL,
	[OEM Name] [char](100) NULL,
	[Carrier] [varchar](30) NULL,
	[TrackNum] [varchar](50) NULL,
	[Lays] [int] NULL,
	[SelCode] [char](3) NULL,
	[ShPan] [float] NULL,
	[ShLays] [float] NULL,
	[WidthB] [decimal](15, 5) NULL,
	[LengthB] [decimal](15, 5) NULL,
	[AreaB] [decimal](15, 5) NULL,
	[WidthP] [decimal](20, 5) NULL,
	[LengthP] [decimal](20, 5) NULL,
	[AreaP] [decimal](20, 5) NULL,
	[Subs] [varchar](12) NULL,
	[BaseMtl] [char](30) NULL,
	[HolesB] [decimal](15, 0) NULL,
	[HolesP] [decimal](15, 0) NULL,
	[SmallHole] [decimal](18, 8) NULL,
	[Thick] [decimal](16, 6) NULL,
	[AspRatio] [decimal](15, 5) NULL,
	[ShBrdsDD] [decimal](15, 0) NULL,
	[ShPanDD] [decimal](15, 0) NULL,
	[ShLaysDD] [decimal](15, 0) NULL,
	[ShDolsDD] [float] NULL,
	[ATLCusNum] [char](6) NULL,
	[ShipName] [varchar](1) NULL,
	[UPArr] [numeric](28, 0) NULL,
	[BrdPerArr] [numeric](28, 0) NULL,
	[AreaA] [decimal](16, 6) NULL,
	[CPRTSID] [int] NULL,
	[InvBP] [char](9) NULL,
	[InvBPName] [char](35) NULL,
	[CprtID_PDDim] [bigint] NULL,
	[ProToolNum_PDDim] [varchar](8) NULL,
	[SOSeq] [numeric](34, 6) NULL,
	[ShDols_loc] [float] NULL,
	[NRE_loc] [decimal](17, 4) NULL,
	[TtlSales_loc] [decimal](17, 4) NULL,
	[PriceB_loc] [decimal](17, 4) NULL,
	[CostB_loc] [decimal](17, 4) NULL,
	[ProfitB_loc] [decimal](17, 4) NULL,
	[PriceP_loc] [decimal](17, 4) NULL,
	[CostP_loc] [decimal](17, 4) NULL,
	[ProfitP_loc] [decimal](17, 4) NULL,
	[ProfitPct_loc] [decimal](15, 4) NULL,
	[ProfitT_loc] [decimal](17, 4) NULL,
	[ShDolsDD_loc] [float] NULL,
	[Item] [varchar](47) NULL,
	[ShDateTime] [char](10) NULL,
	[ShipID] [numeric](28, 0) NULL,
	[Plant] [char](5) NULL,
	[Bus_Unit] [nvarchar](15) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [hjhj]    Script Date: 2014/11/12 17:13:32 ******/
CREATE CLUSTERED INDEX [hjhj] ON [dbo].[frank_shipped_all_china]
(
	[SONum] ASC,
	[SOPos] ASC,
	[ShipID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [loc]    Script Date: 2014/11/12 17:13:32 ******/
CREATE NONCLUSTERED INDEX [loc] ON [dbo].[frank_shipped_all_china]
(
	[Loc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [shdate]    Script Date: 2014/11/12 17:13:32 ******/
CREATE NONCLUSTERED INDEX [shdate] ON [dbo].[frank_shipped_all_china]
(
	[SHDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
