USE [Multek_AsiaHome]
GO
/****** Object:  Table [dbo].[ProductWarranty_ProductApp]    Script Date: 2014/11/12 17:07:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProductWarranty_ProductApp](
	[AppId] [uniqueidentifier] NOT NULL,
	[AppName] [varchar](50) NOT NULL,
	[AppEnabled] [bit] NOT NULL,
 CONSTRAINT [PK_ProductWarranty_ProductApp] PRIMARY KEY NONCLUSTERED 
(
	[AppId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_ProductWarranty_ProductApp]    Script Date: 2014/11/12 17:07:58 ******/
CREATE UNIQUE CLUSTERED INDEX [IX_ProductWarranty_ProductApp] ON [dbo].[ProductWarranty_ProductApp]
(
	[AppName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
