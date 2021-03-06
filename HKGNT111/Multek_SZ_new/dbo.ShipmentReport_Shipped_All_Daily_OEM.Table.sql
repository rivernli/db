USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[ShipmentReport_Shipped_All_Daily_OEM]    Script Date: 11/06/2014 15:47:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ShipmentReport_Shipped_All_Daily_OEM](
	[Site] [varchar](50) NOT NULL,
	[Plant] [varchar](50) NOT NULL,
	[OEM] [varchar](100) NOT NULL,
	[Day] [datetime] NOT NULL,
	[RevenueAmount] [numeric](18, 2) NOT NULL,
	[MaterialAmount] [numeric](18, 2) NULL,
	[MaterialPercent] [numeric](18, 2) NULL,
 CONSTRAINT [PK_ShipmentReport_Shipped_All_Daily_OEM] PRIMARY KEY CLUSTERED 
(
	[Site] ASC,
	[Plant] ASC,
	[OEM] ASC,
	[Day] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
