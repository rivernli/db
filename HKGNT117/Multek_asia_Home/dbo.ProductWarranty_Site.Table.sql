USE [Multek_AsiaHome]
GO
/****** Object:  Table [dbo].[ProductWarranty_Site]    Script Date: 2014/11/12 17:07:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProductWarranty_Site](
	[SiteCode] [varchar](10) NOT NULL,
	[SiteDesc] [varchar](50) NOT NULL,
	[SiteEnabled] [bit] NOT NULL CONSTRAINT [DF_ProductWarranty_Site_Enabled]  DEFAULT ((1)),
 CONSTRAINT [PK_ProductWarranty_Site] PRIMARY KEY NONCLUSTERED 
(
	[SiteCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_ProductWarranty_Site]    Script Date: 2014/11/12 17:07:58 ******/
CREATE CLUSTERED INDEX [IX_ProductWarranty_Site] ON [dbo].[ProductWarranty_Site]
(
	[SiteDesc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
