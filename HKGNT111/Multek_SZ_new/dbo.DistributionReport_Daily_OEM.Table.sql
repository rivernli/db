USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[DistributionReport_Daily_OEM]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DistributionReport_Daily_OEM](
	[Type] [varchar](50) NOT NULL,
	[Site] [varchar](50) NOT NULL,
	[Plant] [varchar](50) NOT NULL,
	[OEM] [varchar](500) NOT NULL,
	[Day] [datetime] NOT NULL,
	[RevenueAmount] [numeric](18, 2) NOT NULL,
	[MaterialAmount] [numeric](18, 2) NULL,
	[MaterialPercent] [numeric](18, 2) NULL,
 CONSTRAINT [PK_DistributionReport_Daily_OEM_1] PRIMARY KEY CLUSTERED 
(
	[Type] ASC,
	[Site] ASC,
	[Plant] ASC,
	[OEM] ASC,
	[Day] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [dayoem] ON [dbo].[DistributionReport_Daily_OEM] 
(
	[Day] ASC,
	[OEM] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [typesiteplantday] ON [dbo].[DistributionReport_Daily_OEM] 
(
	[Type] ASC,
	[Site] ASC,
	[Plant] ASC,
	[Day] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
