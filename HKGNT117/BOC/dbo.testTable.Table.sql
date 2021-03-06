USE [BOC]
GO
/****** Object:  Table [dbo].[testTable]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[testTable](
	[id] [int] NOT NULL,
	[plnt] [nchar](10) NULL,
	[item] [nchar](10) NULL,
	[cust] [nchar](10) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_testTable]    Script Date: 2014/11/12 17:02:03 ******/
CREATE NONCLUSTERED INDEX [IX_testTable] ON [dbo].[testTable]
(
	[plnt] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_testTable_1]    Script Date: 2014/11/12 17:02:03 ******/
CREATE NONCLUSTERED INDEX [IX_testTable_1] ON [dbo].[testTable]
(
	[item] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
