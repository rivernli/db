USE [Multek_ZH_New]
GO
/****** Object:  Table [dbo].[QMS_quotation_items_costing_pricing]    Script Date: 11/06/2014 15:50:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QMS_quotation_items_costing_pricing](
	[priceId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[costingId] [int] NOT NULL,
	[price] [decimal](18, 4) NOT NULL,
	[qty] [int] NOT NULL,
	[yield] [decimal](18, 4) NOT NULL,
	[paymentTerms] [nvarchar](50) NOT NULL,
	[createDate] [datetime] NOT NULL,
	[lastUpdate] [datetime] NOT NULL,
	[lastStatus] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_QMS_quotation_items_costing_pricing] PRIMARY KEY CLUSTERED 
(
	[priceId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[QMS_quotation_items_costing_pricing]  WITH CHECK ADD  CONSTRAINT [FK_QMS_quotation_items_costing_pricing_QMS_quotation_items_costing] FOREIGN KEY([costingId])
REFERENCES [dbo].[QMS_quotation_items_costing] ([costId])
GO
ALTER TABLE [dbo].[QMS_quotation_items_costing_pricing] CHECK CONSTRAINT [FK_QMS_quotation_items_costing_pricing_QMS_quotation_items_costing]
GO
ALTER TABLE [dbo].[QMS_quotation_items_costing_pricing] ADD  CONSTRAINT [DF_QMS_quotation_items_costing_pricing_yield]  DEFAULT ((1)) FOR [yield]
GO
ALTER TABLE [dbo].[QMS_quotation_items_costing_pricing] ADD  CONSTRAINT [DF_QMS_quotation_items_costing_pricing_createDate]  DEFAULT (getdate()) FOR [createDate]
GO
ALTER TABLE [dbo].[QMS_quotation_items_costing_pricing] ADD  CONSTRAINT [DF_QMS_quotation_items_costing_pricing_lastUpdate]  DEFAULT (getdate()) FOR [lastUpdate]
GO
ALTER TABLE [dbo].[QMS_quotation_items_costing_pricing] ADD  CONSTRAINT [DF_QMS_quotation_items_costing_pricing_lastStatus]  DEFAULT ('init') FOR [lastStatus]
GO
