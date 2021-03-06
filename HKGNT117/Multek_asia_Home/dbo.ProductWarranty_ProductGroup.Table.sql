USE [Multek_AsiaHome]
GO
/****** Object:  Table [dbo].[ProductWarranty_ProductGroup]    Script Date: 2014/11/12 17:07:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProductWarranty_ProductGroup](
	[GroupId] [uniqueidentifier] NOT NULL,
	[GroupName] [varchar](50) NOT NULL,
	[GroupEnabled] [bit] NOT NULL CONSTRAINT [DF_ProductWarranty_ProductGroup_Enabled]  DEFAULT ((1)),
 CONSTRAINT [PK_ProductWarranty_ProductGroup_1] PRIMARY KEY NONCLUSTERED 
(
	[GroupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_ProductWarranty_ProductGroup]    Script Date: 2014/11/12 17:07:58 ******/
CREATE CLUSTERED INDEX [IX_ProductWarranty_ProductGroup] ON [dbo].[ProductWarranty_ProductGroup]
(
	[GroupName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
