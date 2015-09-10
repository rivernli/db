USE [Multek_ZH]
GO
/****** Object:  Table [dbo].[IES_PJList_Source]    Script Date: 2014/11/12 17:12:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IES_PJList_Source](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Building] [varchar](10) NULL,
	[Project] [varchar](50) NULL,
	[SubProject] [varchar](50) NULL,
	[ProjectWV] [varchar](50) NULL,
	[Unit] [decimal](18, 4) NULL,
	[Sqft] [decimal](18, 4) NULL,
	[Yield] [decimal](18, 4) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_IES_PJList_Source]    Script Date: 2014/11/12 17:12:19 ******/
CREATE NONCLUSTERED INDEX [IX_IES_PJList_Source] ON [dbo].[IES_PJList_Source]
(
	[Project] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
