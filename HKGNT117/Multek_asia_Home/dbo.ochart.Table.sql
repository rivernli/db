USE [Multek_AsiaHome]
GO
/****** Object:  Table [dbo].[ochart]    Script Date: 2014/11/12 17:07:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ochart](
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
	[hide] [bit] NULL,
	[path] [nvarchar](250) NULL,
	[depGroup] [nchar](10) NULL,
	[lastUpdate] [datetime] NULL
) ON [PRIMARY]

GO
