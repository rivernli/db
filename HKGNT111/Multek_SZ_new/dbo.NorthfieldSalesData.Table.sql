USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[NorthfieldSalesData]    Script Date: 11/06/2014 15:47:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NorthfieldSalesData](
	[ID] [int] NOT NULL,
	[FlexBusline] [varchar](100) NULL,
	[Key] [varchar](100) NULL,
	[BusUnitNo] [varchar](5) NULL,
	[OrgDesc] [varchar](5) NULL,
	[MktNo] [varchar](5) NULL,
	[FlexCustName] [varchar](100) NULL,
	[OracleCustomer] [varchar](100) NULL,
	[OracleCustNo] [varchar](15) NULL,
	[OrderType] [varchar](100) NULL,
	[OrderNo] [varchar](20) NULL,
	[InvoiceNumber] [varchar](20) NULL,
	[Itemno] [varchar](20) NULL,
	[Description] [varchar](150) NULL,
	[ShippedQty] [numeric](22, 4) NULL,
	[InvoicedDollarsInUSD] [numeric](22, 4) NULL,
	[ExtendedMtlCost] [numeric](22, 4) NULL,
	[ExtendedMtlOHCost] [numeric](22, 4) NULL,
	[ExtendedResourceCost] [numeric](22, 4) NULL,
	[EXTOUTProcCost] [numeric](22, 4) NULL,
	[ExtendedOverheadCost] [numeric](22, 4) NULL,
	[ExtendedCost] [numeric](22, 4) NULL,
	[ShippedDate] [date] NULL,
	[RevenueYrMo] [varchar](50) NULL,
	[ProdFamNo] [varchar](5) NULL,
	[ProdFamdescription] [varchar](100) NULL,
	[SalesAccount] [varchar](100) NULL,
	[CogsAccount] [varchar](100) NULL,
	[ShipLoc] [varchar](100) NULL,
	[ShipCity] [varchar](100) NULL,
	[ShipState] [varchar](20) NULL,
	[ShipStateCountry] [varchar](30) NULL,
	[ShipCountry] [varchar](30) NULL,
	[BillCountry] [varchar](30) NULL,
	[BillCity] [varchar](100) NULL,
	[BillProvince] [varchar](100) NULL,
	[BillState] [varchar](100) NULL,
	[FreightTermsCode] [varchar](100) NULL,
	[ShipPeriod] [varchar](50) NULL,
	[MtlUnitCost] [numeric](22, 4) NULL,
	[MtlFrtUnitCost] [numeric](22, 4) NULL,
	[ResourceUnitCost] [numeric](22, 4) NULL,
	[OutsideProcessUnitCost] [numeric](22, 4) NULL,
	[OverheadUnitCost] [numeric](22, 4) NULL,
	[ItemUnitCost] [numeric](22, 4) NULL,
	[InvCategory] [varchar](100) NULL,
	[ItemType] [varchar](100) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
