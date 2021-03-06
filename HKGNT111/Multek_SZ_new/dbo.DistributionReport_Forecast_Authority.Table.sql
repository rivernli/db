USE [Multek_SZ_New]
GO
/****** Object:  Table [dbo].[DistributionReport_Forecast_Authority]    Script Date: 11/06/2014 15:47:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DistributionReport_Forecast_Authority](
	[UserID] [varchar](50) NOT NULL,
	[Output] [bit] NOT NULL,
	[Shipment] [bit] NOT NULL,
	[Outbound] [bit] NOT NULL,
	[HubIn] [bit] NOT NULL,
	[RMA] [bit] NOT NULL,
	[Scrap] [bit] NOT NULL,
	[Incoming] [bit] NOT NULL,
	[B1] [bit] NOT NULL,
	[B2F] [bit] NOT NULL,
	[B3] [bit] NOT NULL,
	[B4] [bit] NOT NULL,
	[B5] [bit] NOT NULL,
	[VVI] [bit] NOT NULL,
	[SUB] [bit] NOT NULL,
	[ZhuHai] [bit] NOT NULL,
	[ZhuHaiEXB2F] [bit] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[DistributionReport_Forecast_Authority] ADD  CONSTRAINT [DF_Distribution_Forecast_Authority_Output]  DEFAULT ((0)) FOR [Output]
GO
ALTER TABLE [dbo].[DistributionReport_Forecast_Authority] ADD  CONSTRAINT [DF_Distribution_Forecast_Authority_Shipment]  DEFAULT ((0)) FOR [Shipment]
GO
ALTER TABLE [dbo].[DistributionReport_Forecast_Authority] ADD  CONSTRAINT [DF_Distribution_Forecast_Authority_Outbound]  DEFAULT ((0)) FOR [Outbound]
GO
ALTER TABLE [dbo].[DistributionReport_Forecast_Authority] ADD  CONSTRAINT [DF_Distribution_Forecast_Authority_HubIn]  DEFAULT ((0)) FOR [HubIn]
GO
ALTER TABLE [dbo].[DistributionReport_Forecast_Authority] ADD  CONSTRAINT [DF_Distribution_Forecast_Authority_RMA]  DEFAULT ((0)) FOR [RMA]
GO
ALTER TABLE [dbo].[DistributionReport_Forecast_Authority] ADD  CONSTRAINT [DF_Distribution_Forecast_Authority_Scrap]  DEFAULT ((0)) FOR [Scrap]
GO
ALTER TABLE [dbo].[DistributionReport_Forecast_Authority] ADD  CONSTRAINT [DF_DistributionReport_Forecast_Authority_Incoming]  DEFAULT ((0)) FOR [Incoming]
GO
ALTER TABLE [dbo].[DistributionReport_Forecast_Authority] ADD  CONSTRAINT [DF_Distribution_Forecast_Authority_B1]  DEFAULT ((0)) FOR [B1]
GO
ALTER TABLE [dbo].[DistributionReport_Forecast_Authority] ADD  CONSTRAINT [DF_Distribution_Forecast_Authority_B2F]  DEFAULT ((0)) FOR [B2F]
GO
ALTER TABLE [dbo].[DistributionReport_Forecast_Authority] ADD  CONSTRAINT [DF_Distribution_Forecast_Authority_B3]  DEFAULT ((0)) FOR [B3]
GO
ALTER TABLE [dbo].[DistributionReport_Forecast_Authority] ADD  CONSTRAINT [DF_Distribution_Forecast_Authority_B4]  DEFAULT ((0)) FOR [B4]
GO
ALTER TABLE [dbo].[DistributionReport_Forecast_Authority] ADD  CONSTRAINT [DF_Distribution_Forecast_Authority_B5]  DEFAULT ((0)) FOR [B5]
GO
ALTER TABLE [dbo].[DistributionReport_Forecast_Authority] ADD  CONSTRAINT [DF_Distribution_Forecast_Authority_VVI]  DEFAULT ((0)) FOR [VVI]
GO
ALTER TABLE [dbo].[DistributionReport_Forecast_Authority] ADD  CONSTRAINT [DF_DistributionReport_Forecast_Authority_SUB]  DEFAULT ((0)) FOR [SUB]
GO
ALTER TABLE [dbo].[DistributionReport_Forecast_Authority] ADD  CONSTRAINT [DF_Distribution_Forecast_Authority_ZhuHai]  DEFAULT ((0)) FOR [ZhuHai]
GO
ALTER TABLE [dbo].[DistributionReport_Forecast_Authority] ADD  CONSTRAINT [DF_DistributionReport_Forecast_Authority_ZhuHaiEXB2F]  DEFAULT ((0)) FOR [ZhuHaiEXB2F]
GO
