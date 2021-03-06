USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[DistributionReport_TOP20CustomerOEM_Total]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DistributionReport_TOP20CustomerOEM_Total](
	[ReportCode] [varchar](3) NOT NULL,
	[Type] [varchar](10) NOT NULL,
	[Site] [varchar](50) NOT NULL,
	[Plant] [varchar](50) NOT NULL,
	[Year] [varchar](4) NOT NULL,
	[OEMCustomer] [varchar](300) NOT NULL,
	[Amount] [bigint] NOT NULL,
	[B1] [bigint] NOT NULL,
	[B2F] [bigint] NOT NULL,
	[B3] [bigint] NOT NULL,
	[B4] [bigint] NOT NULL,
	[B5] [bigint] NOT NULL,
	[VVI] [bigint] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ReportCodeTypeSitePlantYearOEMCustomer] ON [dbo].[DistributionReport_TOP20CustomerOEM_Total] 
(
	[ReportCode] ASC,
	[Type] ASC,
	[Site] ASC,
	[Plant] ASC,
	[Year] ASC,
	[OEMCustomer] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DistributionReport_TOP20CustomerOEM_Total] ADD  CONSTRAINT [DF_DistributionReport_TOP20CustomerOEM_Total_Amount]  DEFAULT ((0)) FOR [Amount]
GO
ALTER TABLE [dbo].[DistributionReport_TOP20CustomerOEM_Total] ADD  CONSTRAINT [DF_DistributionReport_TOP20CustomerOEM_Total_B1]  DEFAULT ((0)) FOR [B1]
GO
ALTER TABLE [dbo].[DistributionReport_TOP20CustomerOEM_Total] ADD  CONSTRAINT [DF_DistributionReport_TOP20CustomerOEM_Total_B2F]  DEFAULT ((0)) FOR [B2F]
GO
ALTER TABLE [dbo].[DistributionReport_TOP20CustomerOEM_Total] ADD  CONSTRAINT [DF_DistributionReport_TOP20CustomerOEM_Total_B4]  DEFAULT ((0)) FOR [B4]
GO
ALTER TABLE [dbo].[DistributionReport_TOP20CustomerOEM_Total] ADD  CONSTRAINT [DF_DistributionReport_TOP20CustomerOEM_Total_B5]  DEFAULT ((0)) FOR [B5]
GO
ALTER TABLE [dbo].[DistributionReport_TOP20CustomerOEM_Total] ADD  CONSTRAINT [DF_DistributionReport_TOP20CustomerOEM_Total_VVI]  DEFAULT ((0)) FOR [VVI]
GO
