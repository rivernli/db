USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[DistributionReport_TOP20CustomerOEM]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DistributionReport_TOP20CustomerOEM](
	[ReportCode] [varchar](3) NOT NULL,
	[Type] [varchar](10) NOT NULL,
	[Site] [varchar](50) NOT NULL,
	[Plant] [varchar](50) NOT NULL,
	[Year] [varchar](4) NOT NULL,
	[OEMCustomer] [varchar](300) NOT NULL,
	[Amount] [bigint] NOT NULL,
	[M1] [bigint] NOT NULL,
	[M2] [bigint] NOT NULL,
	[M3] [bigint] NOT NULL,
	[M4] [bigint] NOT NULL,
	[M5] [bigint] NOT NULL,
	[M6] [bigint] NOT NULL,
	[M7] [bigint] NOT NULL,
	[M8] [bigint] NOT NULL,
	[M9] [bigint] NOT NULL,
	[M10] [bigint] NOT NULL,
	[M11] [bigint] NOT NULL,
	[M12] [bigint] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ReportCodeTypeSitePlantYearOEMCustomer] ON [dbo].[DistributionReport_TOP20CustomerOEM] 
(
	[ReportCode] ASC,
	[Type] ASC,
	[Site] ASC,
	[Plant] ASC,
	[Year] ASC,
	[OEMCustomer] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DistributionReport_TOP20CustomerOEM] ADD  CONSTRAINT [DF_DistributionReport_TOP20CustomerOEM_Amount]  DEFAULT ((0)) FOR [Amount]
GO
ALTER TABLE [dbo].[DistributionReport_TOP20CustomerOEM] ADD  CONSTRAINT [DF_DistributionReport_TOP20CustomerOEM_M1]  DEFAULT ((0)) FOR [M1]
GO
ALTER TABLE [dbo].[DistributionReport_TOP20CustomerOEM] ADD  CONSTRAINT [DF_DistributionReport_TOP20CustomerOEM_M2]  DEFAULT ((0)) FOR [M2]
GO
ALTER TABLE [dbo].[DistributionReport_TOP20CustomerOEM] ADD  CONSTRAINT [DF_DistributionReport_TOP20CustomerOEM_M3]  DEFAULT ((0)) FOR [M3]
GO
ALTER TABLE [dbo].[DistributionReport_TOP20CustomerOEM] ADD  CONSTRAINT [DF_DistributionReport_TOP20CustomerOEM_M4]  DEFAULT ((0)) FOR [M4]
GO
ALTER TABLE [dbo].[DistributionReport_TOP20CustomerOEM] ADD  CONSTRAINT [DF_DistributionReport_TOP20CustomerOEM_M5]  DEFAULT ((0)) FOR [M5]
GO
ALTER TABLE [dbo].[DistributionReport_TOP20CustomerOEM] ADD  CONSTRAINT [DF_DistributionReport_TOP20CustomerOEM_M6]  DEFAULT ((0)) FOR [M6]
GO
ALTER TABLE [dbo].[DistributionReport_TOP20CustomerOEM] ADD  CONSTRAINT [DF_DistributionReport_TOP20CustomerOEM_M7]  DEFAULT ((0)) FOR [M7]
GO
ALTER TABLE [dbo].[DistributionReport_TOP20CustomerOEM] ADD  CONSTRAINT [DF_DistributionReport_TOP20CustomerOEM_M8]  DEFAULT ((0)) FOR [M8]
GO
ALTER TABLE [dbo].[DistributionReport_TOP20CustomerOEM] ADD  CONSTRAINT [DF_DistributionReport_TOP20CustomerOEM_M9]  DEFAULT ((0)) FOR [M9]
GO
ALTER TABLE [dbo].[DistributionReport_TOP20CustomerOEM] ADD  CONSTRAINT [DF_DistributionReport_TOP20CustomerOEM_M10]  DEFAULT ((0)) FOR [M10]
GO
ALTER TABLE [dbo].[DistributionReport_TOP20CustomerOEM] ADD  CONSTRAINT [DF_DistributionReport_TOP20CustomerOEM_M11]  DEFAULT ((0)) FOR [M11]
GO
ALTER TABLE [dbo].[DistributionReport_TOP20CustomerOEM] ADD  CONSTRAINT [DF_DistributionReport_TOP20CustomerOEM_M12]  DEFAULT ((0)) FOR [M12]
GO
