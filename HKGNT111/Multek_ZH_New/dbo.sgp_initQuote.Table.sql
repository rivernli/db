USE [Multek_ZH_New]
GO
/****** Object:  Table [dbo].[sgp_initQuote]    Script Date: 11/06/2014 15:50:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sgp_initQuote](
	[iqId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[iqDate] [datetime] NOT NULL,
	[OutsideSales] [nvarchar](50) NULL,
	[HKSales] [nvarchar](50) NULL,
	[customer] [nvarchar](255) NULL,
	[NoOfPart] [int] NOT NULL,
	[customerPartNo] [nvarchar](255) NULL,
	[isNew] [bit] NOT NULL,
	[EAU] [int] NOT NULL,
	[customerTargetPrice] [decimal](18, 4) NOT NULL,
	[isQuoted30Days] [bit] NOT NULL,
	[isDataUploaded] [bit] NOT NULL,
	[specialInstructions] [nvarchar](255) NULL,
	[isVI] [bit] NULL,
	[customerDeadline] [datetime] NULL,
	[isDataUpload_Gerber] [bit] NULL,
	[isDataUpload_TechSpec] [bit] NULL,
	[isDataUpload_Far] [bit] NULL,
	[iqGroup] [nvarchar](50) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[sgp_initQuote] ADD  CONSTRAINT [DF_sgp_initQuote_iqDate]  DEFAULT (getdate()) FOR [iqDate]
GO
ALTER TABLE [dbo].[sgp_initQuote] ADD  CONSTRAINT [DF_sgp_initQuote_NoOfPart]  DEFAULT ((1)) FOR [NoOfPart]
GO
ALTER TABLE [dbo].[sgp_initQuote] ADD  CONSTRAINT [DF_sgp_initQuote_isNew]  DEFAULT ((1)) FOR [isNew]
GO
ALTER TABLE [dbo].[sgp_initQuote] ADD  CONSTRAINT [DF_sgp_initQuote_EAU]  DEFAULT ((0)) FOR [EAU]
GO
ALTER TABLE [dbo].[sgp_initQuote] ADD  CONSTRAINT [DF_Table_1_customer_target_price]  DEFAULT ((0)) FOR [customerTargetPrice]
GO
ALTER TABLE [dbo].[sgp_initQuote] ADD  CONSTRAINT [DF_Table_1_isquoted30Days]  DEFAULT ((0)) FOR [isQuoted30Days]
GO
ALTER TABLE [dbo].[sgp_initQuote] ADD  CONSTRAINT [DF_sgp_initQuote_isDataUploaded]  DEFAULT ((0)) FOR [isDataUploaded]
GO
ALTER TABLE [dbo].[sgp_initQuote] ADD  DEFAULT ((0)) FOR [isVI]
GO
ALTER TABLE [dbo].[sgp_initQuote] ADD  CONSTRAINT [DF_sgp_initQuote_isDataUpload_Gerber]  DEFAULT ((0)) FOR [isDataUpload_Gerber]
GO
ALTER TABLE [dbo].[sgp_initQuote] ADD  CONSTRAINT [DF_sgp_initQuote_isDataUpload_TechSpec]  DEFAULT ((0)) FOR [isDataUpload_TechSpec]
GO
ALTER TABLE [dbo].[sgp_initQuote] ADD  CONSTRAINT [DF_sgp_initQuote_isDataUpload_Far]  DEFAULT ((0)) FOR [isDataUpload_Far]
GO
