USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[hubInventoryOEMPolicy]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[hubInventoryOEMPolicy](
	[billingPolicy] [int] NOT NULL CONSTRAINT [DF_hubInventoryOEMPolicy_billingPolicy]  DEFAULT ((0)),
	[transit] [int] NOT NULL CONSTRAINT [DF_hubInventoryOEMPolicy_oversit]  DEFAULT ((0)),
	[warehouseId] [nchar](10) NOT NULL,
 CONSTRAINT [PK_hubInventoryOEMPolicy_1] PRIMARY KEY CLUSTERED 
(
	[warehouseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
