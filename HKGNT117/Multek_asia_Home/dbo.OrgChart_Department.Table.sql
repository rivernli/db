USE [Multek_AsiaHome]
GO
/****** Object:  Table [dbo].[OrgChart_Department]    Script Date: 2014/11/12 17:07:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrgChart_Department](
	[UniqueId] [int] IDENTITY(1,1) NOT NULL,
	[ManagerId] [int] NOT NULL CONSTRAINT [DF_Table_1_Manager_id]  DEFAULT ((0)),
	[Name] [nvarchar](50) NOT NULL,
	[Title] [nvarchar](250) NULL,
	[Department] [nvarchar](250) NULL,
	[PhotoURL] [nvarchar](500) NULL,
	[keyword] [nvarchar](50) NULL,
	[email] [nvarchar](50) NULL,
	[tel] [nvarchar](50) NULL,
	[voip] [nvarchar](50) NULL,
	[userId] [nvarchar](50) NULL,
	[city] [nvarchar](50) NULL,
	[hide] [bit] NULL CONSTRAINT [DF_OrgChart_Department_hide]  DEFAULT ((0)),
	[domain] [nvarchar](50) NULL
) ON [PRIMARY]

GO
