USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[ShipmentReport_Shipped_All_Fixed_Top_20_OEM_Fiscal_By_LocPlant]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ShipmentReport_Shipped_All_Fixed_Top_20_OEM_Fiscal_By_LocPlant](
	[Loc] [varchar](3) NULL,
	[Plant] [varchar](3) NULL,
	[Year] [varchar](4) NULL,
	[OEM] [varchar](100) NULL,
	[Amount] [numeric](18, 2) NULL,
	[M1] [numeric](18, 2) NULL,
	[M2] [numeric](18, 2) NULL,
	[M3] [numeric](18, 2) NULL,
	[M4] [numeric](18, 2) NULL,
	[M5] [numeric](18, 2) NULL,
	[M6] [numeric](18, 2) NULL,
	[M7] [numeric](18, 2) NULL,
	[M8] [numeric](18, 2) NULL,
	[M9] [numeric](18, 2) NULL,
	[M10] [numeric](18, 2) NULL,
	[M11] [numeric](18, 2) NULL,
	[M12] [numeric](18, 2) NULL,
	[ASP1] [numeric](18, 2) NULL,
	[ASP2] [numeric](18, 2) NULL,
	[ASP3] [numeric](18, 2) NULL,
	[ASP4] [numeric](18, 2) NULL,
	[ASP5] [numeric](18, 2) NULL,
	[ASP6] [numeric](18, 2) NULL,
	[ASP7] [numeric](18, 2) NULL,
	[ASP8] [numeric](18, 2) NULL,
	[ASP9] [numeric](18, 2) NULL,
	[ASP10] [numeric](18, 2) NULL,
	[ASP11] [numeric](18, 2) NULL,
	[ASP12] [numeric](18, 2) NULL,
	[ALC1] [numeric](18, 2) NULL,
	[ALC2] [numeric](18, 2) NULL,
	[ALC3] [numeric](18, 2) NULL,
	[ALC4] [numeric](18, 2) NULL,
	[ALC5] [numeric](18, 2) NULL,
	[ALC6] [numeric](18, 2) NULL,
	[ALC7] [numeric](18, 2) NULL,
	[ALC8] [numeric](18, 2) NULL,
	[ALC9] [numeric](18, 2) NULL,
	[ALC10] [numeric](18, 2) NULL,
	[ALC11] [numeric](18, 2) NULL,
	[ALC12] [numeric](18, 2) NULL,
	[PPL1] [numeric](18, 2) NULL,
	[PPL2] [numeric](18, 2) NULL,
	[PPL3] [numeric](18, 2) NULL,
	[PPL4] [numeric](18, 2) NULL,
	[PPL5] [numeric](18, 2) NULL,
	[PPL6] [numeric](18, 2) NULL,
	[PPL7] [numeric](18, 2) NULL,
	[PPL8] [numeric](18, 2) NULL,
	[PPL9] [numeric](18, 2) NULL,
	[PPL10] [numeric](18, 2) NULL,
	[PPL11] [numeric](18, 2) NULL,
	[PPL12] [numeric](18, 2) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE CLUSTERED INDEX [LocPlantYearOEM] ON [dbo].[ShipmentReport_Shipped_All_Fixed_Top_20_OEM_Fiscal_By_LocPlant] 
(
	[Loc] ASC,
	[Plant] ASC,
	[Year] ASC,
	[OEM] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
