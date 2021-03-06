USE [BOC]
GO
/****** Object:  Table [dbo].[MenuTree]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MenuTree](
	[TreeID] [decimal](9, 0) NOT NULL,
	[TreeName] [nvarchar](50) NULL,
	[ParentID] [decimal](9, 0) NULL,
	[URL] [nvarchar](50) NULL,
	[Role_Level] [nvarchar](50) NULL,
	[Target] [nvarchar](50) NULL,
	[SelectAction] [nvarchar](50) NULL
) ON [PRIMARY]

GO
