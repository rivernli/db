USE [Multek_AsiaHome]
GO
/****** Object:  Table [dbo].[ochart_bk]    Script Date: 2014/11/12 17:07:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ochart_bk](
	[UniqueId] [int] IDENTITY(1,1) NOT NULL,
	[ManagerId] [int] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Title] [nvarchar](250) NULL,
	[Department] [nvarchar](250) NULL,
	[PhotoURL] [nvarchar](500) NULL,
	[keyword] [nvarchar](50) NULL,
	[email] [nvarchar](50) NULL,
	[tel] [nvarchar](50) NULL,
	[voip] [nvarchar](50) NULL,
	[userId] [nvarchar](50) NOT NULL,
	[city] [nvarchar](50) NULL,
	[hide] [bit] NULL CONSTRAINT [DF_OChart_hide]  DEFAULT ((0)),
	[path] [nvarchar](250) NULL,
	[depGroup] [nchar](10) NULL,
	[lastUpdate] [datetime] NULL,
 CONSTRAINT [PK_OChart] PRIMARY KEY CLUSTERED 
(
	[userId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_OChart]    Script Date: 2014/11/12 17:07:58 ******/
CREATE NONCLUSTERED INDEX [IX_OChart] ON [dbo].[ochart_bk]
(
	[depGroup] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
