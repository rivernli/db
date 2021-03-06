USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[ShipmentReport_Shipped_All_Fixed_Top_20_OEM_By_Loc]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ShipmentReport_Shipped_All_Fixed_Top_20_OEM_By_Loc](
	[Loc] [varchar](3) NULL,
	[Year] [varchar](4) NULL,
	[OEM] [varchar](100) NULL,
	[Amount] [numeric](18, 2) NULL,
	[B1Amount] [numeric](18, 2) NULL,
	[B12Amount] [numeric](18, 2) NULL,
	[B2FAmount] [numeric](18, 2) NULL,
	[B3Amount] [numeric](18, 2) NULL,
	[B4Amount] [numeric](18, 2) NULL,
	[B5Amount] [numeric](18, 2) NULL,
	[HKAmount] [numeric](18, 2) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [Loc] ON [dbo].[ShipmentReport_Shipped_All_Fixed_Top_20_OEM_By_Loc] 
(
	[Loc] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [OEM] ON [dbo].[ShipmentReport_Shipped_All_Fixed_Top_20_OEM_By_Loc] 
(
	[OEM] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Year] ON [dbo].[ShipmentReport_Shipped_All_Fixed_Top_20_OEM_By_Loc] 
(
	[Year] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
