USE [Multek_AsiaHome]
GO
/****** Object:  Table [dbo].[ProductWarranty_Base]    Script Date: 2014/11/12 17:07:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProductWarranty_Base](
	[WarrantyId] [uniqueidentifier] NOT NULL,
	[CustomerName] [nvarchar](200) NULL,
	[CustomerType] [nvarchar](20) NULL,
	[ProductApplication] [varchar](max) NULL,
	[ProductGroup] [varchar](max) NULL,
	[ContractName] [nvarchar](200) NULL,
	[ContractNumber] [nvarchar](100) NULL,
	[ContractDate] [datetime] NULL,
	[ContractValidity] [nvarchar](50) NULL,
	[Site] [nvarchar](500) NULL,
	[Representative] [nvarchar](50) NULL,
	[WarrantyTime] [numeric](18, 0) NULL,
	[WarrantyTimeType] [varchar](50) NULL,
	[WarrantyDefined] [bit] NULL,
	[MaxLiability] [numeric](18, 2) NULL,
	[MaxLiabilityCurrency] [varchar](5) NULL,
	[MaxLiabilityDefined] [bit] NULL,
	[MaxLiabilityRemark] [nvarchar](500) NULL,
	[PCBACostAgreed] [bit] NULL,
	[MaxCreditCost] [numeric](18, 2) NULL,
	[MaxCreditCostType] [varchar](20) NULL,
	[MaxCreditCostUnlimited] [bit] NULL,
	[BOMShown] [bit] NULL,
	[CustomerSite] [nvarchar](200) NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [uniqueidentifier] NOT NULL,
	[ModifiedOn] [datetime] NOT NULL,
	[ModifiedBy] [uniqueidentifier] NOT NULL,
	[Deleted] [bit] NOT NULL CONSTRAINT [DF_ProductWarranty_Base_Deleted]  DEFAULT ((0)),
	[Owner] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_ProductWarranty_Base] PRIMARY KEY NONCLUSTERED 
(
	[WarrantyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_ProductWarranty_Base]    Script Date: 2014/11/12 17:07:58 ******/
CREATE CLUSTERED INDEX [IX_ProductWarranty_Base] ON [dbo].[ProductWarranty_Base]
(
	[CustomerName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_PWB_createtime]    Script Date: 2014/11/12 17:07:58 ******/
CREATE NONCLUSTERED INDEX [IX_PWB_createtime] ON [dbo].[ProductWarranty_Base]
(
	[CreatedOn] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
