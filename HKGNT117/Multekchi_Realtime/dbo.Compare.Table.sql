USE [multekchi_realtime]
GO
/****** Object:  Table [dbo].[Compare]    Script Date: 2014/11/12 17:13:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Compare](
	[Loc_1] [char](30) NOT NULL,
	[Loc_2] [varchar](3) NOT NULL,
	[Compare1] [varchar](4) NOT NULL,
	[SONum_1] [numeric](19, 0) NULL,
	[SONum_2] [numeric](19, 0) NULL,
	[Compare2] [varchar](4) NOT NULL,
	[SOPos_1] [numeric](19, 0) NULL,
	[SOPos_2] [numeric](19, 0) NULL,
	[Compare3] [varchar](4) NOT NULL,
	[DD_1] [numeric](19, 0) NULL,
	[DD_2] [numeric](19, 0) NULL,
	[Compare4] [varchar](4) NOT NULL,
	[SHDate_1] [datetime] NULL,
	[SHDate_2] [datetime] NULL,
	[Compare5] [varchar](4) NOT NULL,
	[Sh1Date_1] [datetime] NULL,
	[Sh1Date_2] [char](10) NULL,
	[Compare6] [varchar](4) NOT NULL,
	[Sh1_1] [numeric](19, 0) NULL,
	[Sh1_2] [numeric](19, 0) NULL,
	[Compare7] [varchar](4) NOT NULL,
	[ShTime_1] [datetime] NULL,
	[ShTime_2] [char](10) NULL,
	[Compare8] [varchar](4) NOT NULL,
	[CustNum_1] [char](6) NOT NULL,
	[CustNum_2] [char](50) NULL,
	[Compare9] [varchar](4) NOT NULL,
	[Customer_Name_1] [char](35) NOT NULL,
	[Customer_Name_2] [char](150) NULL,
	[Compare10] [varchar](4) NOT NULL,
	[ShCust_1] [char](30) NOT NULL,
	[ShCust_2] [char](10) NULL,
	[Compare11] [varchar](4) NOT NULL,
	[ShCustName_1] [char](30) NOT NULL,
	[ShCustName_2] [char](150) NULL,
	[Compare12] [varchar](4) NOT NULL,
	[InvCust_1] [char](6) NOT NULL,
	[InvCust_2] [char](10) NULL,
	[Compare13] [varchar](4) NOT NULL,
	[InvCustName_1] [char](35) NOT NULL,
	[InvCustName_2] [char](150) NULL,
	[Compare14] [varchar](4) NOT NULL,
	[CustPONum_1] [char](30) NOT NULL,
	[CustPONum_2] [char](50) NULL,
	[Compare15] [varchar](4) NOT NULL,
	[BusSegNum_1] [char](8) NOT NULL,
	[BusSegNum_2] [char](8) NULL,
	[Compare16] [varchar](4) NOT NULL,
	[BusSeg_1] [char](30) NOT NULL,
	[BusSeg_2] [char](50) NULL,
	[Compare17] [varchar](4) NOT NULL,
	[CDueDate_1] [datetime] NULL,
	[CDueDate_2] [char](10) NULL,
	[Compare18] [varchar](4) NOT NULL,
	[DocDate_1] [datetime] NULL,
	[DocDate_2] [char](10) NULL,
	[Compare19] [varchar](4) NOT NULL,
	[CPartNum_1] [char](30) NOT NULL,
	[CPartNum_2] [varchar](50) NULL,
	[Compare20] [varchar](4) NOT NULL,
	[CPartRev_1] [char](30) NOT NULL,
	[CPartRev_2] [varchar](6) NULL,
	[Compare21] [varchar](4) NOT NULL,
	[CprtID_1] [numeric](19, 0) NULL,
	[CprtID_2] [numeric](19, 0) NULL,
	[Compare22] [varchar](4) NOT NULL,
	[Priority_1] [numeric](19, 0) NULL,
	[Priority_2] [numeric](19, 0) NULL,
	[Compare23] [varchar](4) NOT NULL,
	[OrdBrds_1] [numeric](19, 0) NULL,
	[OrdBrds_2] [numeric](19, 0) NULL,
	[Compare24] [varchar](4) NOT NULL,
	[ShBrds_1] [numeric](19, 0) NULL,
	[ShBrds_2] [numeric](19, 0) NULL,
	[Compare25] [varchar](4) NOT NULL,
	[ShDols_1] [numeric](19, 0) NULL,
	[ShDols_2] [numeric](19, 0) NULL,
	[Compare26] [varchar](4) NOT NULL,
	[NRE_1] [numeric](19, 0) NULL,
	[NRE_2] [numeric](19, 0) NULL,
	[Compare27] [varchar](4) NOT NULL,
	[TtlSales_1] [numeric](19, 0) NULL,
	[TtlSales_2] [numeric](19, 0) NULL,
	[Compare28] [varchar](4) NOT NULL,
	[PriceB_1] [numeric](19, 0) NULL,
	[PriceB_2] [numeric](19, 0) NULL,
	[Compare29] [varchar](4) NOT NULL,
	[CostB_1] [numeric](19, 0) NULL,
	[CostB_2] [numeric](19, 0) NULL,
	[Compare30] [varchar](4) NOT NULL,
	[ProfitB_1] [numeric](19, 0) NULL,
	[ProfitB_2] [numeric](19, 0) NULL,
	[Compare31] [varchar](4) NOT NULL,
	[UP_1] [numeric](19, 0) NULL,
	[UP_2] [numeric](19, 0) NULL,
	[Compare32] [varchar](4) NOT NULL,
	[PriceP_1] [numeric](19, 0) NULL,
	[PriceP_2] [numeric](19, 0) NULL,
	[Compare33] [varchar](4) NOT NULL,
	[CostP_1] [numeric](19, 0) NULL,
	[CostP_2] [numeric](19, 0) NULL,
	[Compare34] [varchar](4) NOT NULL,
	[ProfitP_1] [numeric](19, 0) NULL,
	[ProfitP_2] [numeric](19, 0) NULL,
	[Compare35] [varchar](4) NOT NULL,
	[ProfitPct_1] [numeric](19, 0) NULL,
	[ProfitPct_2] [numeric](19, 0) NULL,
	[Compare36] [varchar](4) NOT NULL,
	[ProfitT_1] [numeric](19, 0) NULL,
	[ProfitT_2] [numeric](19, 0) NULL,
	[Compare37] [varchar](4) NOT NULL,
	[SODate_1] [datetime] NULL,
	[SODate_2] [char](10) NULL,
	[Compare38] [varchar](4) NOT NULL,
	[SOTime_1] [varchar](8) NULL,
	[SOTime_2] [varchar](8) NULL,
	[Compare39] [varchar](4) NOT NULL,
	[SOType_1] [char](3) NOT NULL,
	[SOType_2] [char](3) NULL,
	[Compare40] [varchar](4) NOT NULL,
	[OrdStat_1] [numeric](19, 0) NULL,
	[OrdStat_2] [numeric](19, 0) NULL,
	[Compare41] [varchar](4) NOT NULL,
	[InRepNum_1] [numeric](19, 0) NULL,
	[InRepNum_2] [numeric](19, 0) NULL,
	[Compare42] [varchar](4) NOT NULL,
	[InRepName_1] [char](30) NOT NULL,
	[InRepName_2] [char](35) NULL,
	[Compare43] [varchar](4) NOT NULL,
	[OutRepNum_1] [char](5) NOT NULL,
	[OutRepNum_2] [char](10) NULL,
	[Compare44] [varchar](4) NOT NULL,
	[OutRepName_1] [char](30) NOT NULL,
	[OutRepName_2] [char](35) NULL,
	[Compare45] [varchar](4) NOT NULL,
	[ContactNum_1] [char](6) NOT NULL,
	[ContactNum_2] [char](9) NULL,
	[Compare46] [varchar](4) NOT NULL,
	[ContactName_1] [char](30) NOT NULL,
	[ContactName_2] [char](35) NULL,
	[Compare47] [varchar](4) NOT NULL,
	[BaanItemNum_1] [char](32) NOT NULL,
	[BaanItemNum_2] [varchar](50) NULL,
	[Compare48] [varchar](4) NOT NULL,
	[ProToolNum_1] [float] NULL,
	[ProToolNum_2] [char](16) NULL,
	[Compare49] [varchar](4) NOT NULL,
	[OEM_1] [char](30) NOT NULL,
	[OEM_2] [char](10) NULL,
	[Compare50] [varchar](4) NOT NULL,
	[OEM_Name_1] [char](35) NOT NULL,
	[OEM_Name_2] [char](100) NULL,
	[Compare51] [varchar](4) NOT NULL,
	[Carrier_1] [char](30) NOT NULL,
	[Carrier_2] [varchar](30) NULL,
	[Compare52] [varchar](4) NOT NULL,
	[TrackNum_1] [char](30) NOT NULL,
	[TrackNum_2] [varchar](50) NULL,
	[Compare53] [varchar](4) NOT NULL,
	[Lays_1] [char](4) NOT NULL,
	[Lays_2] [int] NULL,
	[Compare54] [varchar](4) NOT NULL,
	[SelCode_1] [char](30) NOT NULL,
	[SelCode_2] [char](3) NULL,
	[Compare55] [varchar](4) NOT NULL,
	[ShPan_1] [numeric](19, 0) NULL,
	[ShPan_2] [numeric](19, 0) NULL,
	[Compare56] [varchar](4) NOT NULL,
	[ShLays_1] [numeric](19, 0) NULL,
	[ShLays_2] [numeric](19, 0) NULL,
	[Compare57] [varchar](4) NOT NULL,
	[WidthB_1] [numeric](19, 0) NULL,
	[WidthB_2] [numeric](19, 0) NULL,
	[Compare58] [varchar](4) NOT NULL,
	[LengthB_1] [numeric](19, 0) NULL,
	[LengthB_2] [numeric](19, 0) NULL,
	[Compare59] [varchar](4) NOT NULL,
	[AreaB_1] [numeric](19, 0) NULL,
	[AreaB_2] [numeric](19, 0) NULL,
	[Compare60] [varchar](4) NOT NULL,
	[WidthP_1] [numeric](19, 0) NULL,
	[WidthP_2] [numeric](19, 0) NULL,
	[Compare61] [varchar](4) NOT NULL,
	[LengthP_1] [numeric](19, 0) NULL,
	[LengthP_2] [numeric](19, 0) NULL,
	[Compare62] [varchar](4) NOT NULL,
	[AreaP_1] [numeric](19, 0) NULL,
	[AreaP_2] [numeric](19, 0) NULL,
	[Compare63] [varchar](4) NOT NULL,
	[Subs_1] [char](30) NOT NULL,
	[Subs_2] [varchar](12) NULL,
	[Compare64] [varchar](4) NOT NULL,
	[BaseMtl_1] [char](30) NOT NULL,
	[BaseMtl_2] [char](30) NULL,
	[Compare65] [varchar](4) NOT NULL,
	[HolesB_1] [numeric](19, 0) NULL,
	[HolesB_2] [numeric](19, 0) NULL,
	[Compare66] [varchar](4) NOT NULL,
	[HolesP_1] [numeric](19, 0) NULL,
	[HolesP_2] [numeric](19, 0) NULL,
	[Compare67] [varchar](4) NOT NULL,
	[SmallHole_1] [numeric](19, 0) NULL,
	[SmallHole_2] [numeric](19, 0) NULL,
	[Compare68] [varchar](4) NOT NULL,
	[Thick_1] [numeric](19, 0) NULL,
	[Thick_2] [numeric](19, 0) NULL,
	[Compare69] [varchar](4) NOT NULL,
	[AspRatio_1] [numeric](19, 0) NULL,
	[AspRatio_2] [numeric](19, 0) NULL,
	[Compare70] [varchar](4) NOT NULL,
	[ShBrdsDD_1] [numeric](19, 0) NULL,
	[ShBrdsDD_2] [numeric](19, 0) NULL,
	[Compare71] [varchar](4) NOT NULL,
	[ShPanDD_1] [numeric](19, 0) NULL,
	[ShPanDD_2] [numeric](19, 0) NULL,
	[Compare72] [varchar](4) NOT NULL,
	[ShLaysDD_1] [numeric](19, 0) NULL,
	[ShLaysDD_2] [numeric](19, 0) NULL,
	[Compare73] [varchar](4) NOT NULL,
	[ShDolsDD_1] [numeric](19, 0) NULL,
	[ShDolsDD_2] [numeric](19, 0) NULL,
	[Compare74] [varchar](4) NOT NULL,
	[ATLCusNum_1] [char](6) NOT NULL,
	[ATLCusNum_2] [char](6) NULL,
	[Compare75] [varchar](4) NOT NULL,
	[ShipName_1] [char](30) NOT NULL,
	[ShipName_2] [varchar](1) NULL,
	[Compare76] [varchar](4) NOT NULL,
	[UPArr_1] [numeric](19, 0) NULL,
	[UPArr_2] [numeric](19, 0) NULL,
	[Compare77] [varchar](4) NOT NULL,
	[BrdPerArr_1] [numeric](19, 0) NULL,
	[BrdPerArr_2] [numeric](19, 0) NULL,
	[Compare78] [varchar](4) NOT NULL,
	[AreaA_1] [numeric](19, 0) NULL,
	[AreaA_2] [numeric](19, 0) NULL,
	[Compare79] [varchar](4) NOT NULL,
	[CPRTSID_1] [numeric](19, 0) NULL,
	[CPRTSID_2] [numeric](19, 0) NULL,
	[Compare80] [varchar](4) NOT NULL,
	[InvBP_1] [char](30) NOT NULL,
	[InvBP_2] [char](9) NULL,
	[Compare81] [varchar](4) NOT NULL,
	[InvBPName_1] [varchar](100) NULL,
	[InvBPName_2] [char](35) NULL,
	[Compare82] [varchar](4) NOT NULL,
	[CprtID_PDDim_1] [numeric](19, 0) NULL,
	[CprtID_PDDim_2] [numeric](19, 0) NULL,
	[Compare83] [varchar](4) NOT NULL,
	[ProToolNum_PDDim_1] [char](30) NOT NULL,
	[ProToolNum_PDDim_2] [varchar](8) NULL,
	[Compare84] [varchar](4) NOT NULL,
	[SOSeq_1] [numeric](19, 0) NULL,
	[SOSeq_2] [numeric](19, 0) NULL,
	[Compare85] [varchar](4) NOT NULL,
	[ShDols_loc_1] [numeric](19, 0) NULL,
	[ShDols_loc_2] [numeric](19, 0) NULL,
	[Compare86] [varchar](4) NOT NULL,
	[NRE_loc_1] [numeric](19, 0) NULL,
	[NRE_loc_2] [numeric](19, 0) NULL,
	[Compare87] [varchar](4) NOT NULL,
	[TtlSales_loc_1] [numeric](19, 0) NULL,
	[TtlSales_loc_2] [numeric](19, 0) NULL,
	[Compare88] [varchar](4) NOT NULL,
	[PriceB_loc_1] [numeric](19, 0) NULL,
	[PriceB_loc_2] [numeric](19, 0) NULL,
	[Compare89] [varchar](4) NOT NULL,
	[CostB_loc_1] [numeric](19, 0) NULL,
	[CostB_loc_2] [numeric](19, 0) NULL,
	[Compare90] [varchar](4) NOT NULL,
	[ProfitB_loc_1] [numeric](19, 0) NULL,
	[ProfitB_loc_2] [numeric](19, 0) NULL,
	[Compare91] [varchar](4) NOT NULL,
	[PriceP_loc_1] [numeric](19, 0) NULL,
	[PriceP_loc_2] [numeric](19, 0) NULL,
	[Compare92] [varchar](4) NOT NULL,
	[CostP_loc_1] [numeric](19, 0) NULL,
	[CostP_loc_2] [numeric](19, 0) NULL,
	[Compare93] [varchar](4) NOT NULL,
	[ProfitP_loc_1] [numeric](19, 0) NULL,
	[ProfitP_loc_2] [numeric](19, 0) NULL,
	[Compare94] [varchar](4) NOT NULL,
	[ProfitPct_loc_1] [numeric](19, 0) NULL,
	[ProfitPct_loc_2] [numeric](19, 0) NULL,
	[Compare95] [varchar](4) NOT NULL,
	[ProfitT_loc_1] [numeric](19, 0) NULL,
	[ProfitT_loc_2] [numeric](19, 0) NULL,
	[Compare96] [varchar](4) NOT NULL,
	[ShDolsDD_loc_1] [numeric](19, 0) NULL,
	[ShDolsDD_loc_2] [numeric](19, 0) NULL,
	[Compare97] [varchar](4) NOT NULL,
	[Item_1] [char](32) NOT NULL,
	[Item_2] [varchar](47) NULL,
	[Compare98] [varchar](4) NOT NULL,
	[ShDateTime_1] [datetime] NULL,
	[ShDateTime_2] [char](10) NULL,
	[Compare99] [varchar](4) NOT NULL,
	[ShipID_1] [numeric](19, 0) NULL,
	[ShipID_2] [numeric](19, 0) NULL,
	[Compare100] [varchar](4) NOT NULL,
	[Plant_1] [char](2) NOT NULL,
	[Plant_2] [char](5) NULL,
	[Compare101] [varchar](4) NOT NULL,
	[Bus_Unit_1] [char](30) NOT NULL,
	[Bus_Unit_2] [nvarchar](15) NULL,
	[Compa102] [varchar](4) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
