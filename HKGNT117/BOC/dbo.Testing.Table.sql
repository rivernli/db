USE [BOC]
GO
/****** Object:  Table [dbo].[Testing]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Testing](
	[id] [int] NULL,
	[a] [nchar](10) NULL,
	[b] [nchar](10) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Testing]    Script Date: 2014/11/12 17:02:03 ******/
CREATE NONCLUSTERED INDEX [IX_Testing] ON [dbo].[Testing]
(
	[a] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Testing_1]    Script Date: 2014/11/12 17:02:03 ******/
CREATE NONCLUSTERED INDEX [IX_Testing_1] ON [dbo].[Testing]
(
	[b] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
