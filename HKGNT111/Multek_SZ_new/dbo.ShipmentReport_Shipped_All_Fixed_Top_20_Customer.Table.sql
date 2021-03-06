USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[ShipmentReport_Shipped_All_Fixed_Top_20_Customer]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ShipmentReport_Shipped_All_Fixed_Top_20_Customer](
	[Year] [varchar](4) NULL,
	[Customer] [varchar](100) NULL,
	[Amount] [numeric](18, 2) NULL,
	[DisAmount] [numeric](18, 2) NULL,
	[ChiAmount] [numeric](18, 2) NULL,
	[NfdAmount] [numeric](18, 2) NULL,
	[SaoAmount] [numeric](18, 2) NULL,
	[GerAmount] [numeric](18, 2) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [Customer] ON [dbo].[ShipmentReport_Shipped_All_Fixed_Top_20_Customer] 
(
	[Customer] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [Year] ON [dbo].[ShipmentReport_Shipped_All_Fixed_Top_20_Customer] 
(
	[Year] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
