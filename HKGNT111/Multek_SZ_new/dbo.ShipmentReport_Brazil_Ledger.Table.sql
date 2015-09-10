USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[ShipmentReport_Brazil_Ledger]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShipmentReport_Brazil_Ledger](
	[T$FYER] [int] NULL,
	[T$FPRD] [int] NULL,
	[T$DBCR] [int] NULL,
	[AMOUNT] [numeric](18, 4) NULL,
	[T$DCDT] [datetime] NULL
) ON [PRIMARY]
GO
