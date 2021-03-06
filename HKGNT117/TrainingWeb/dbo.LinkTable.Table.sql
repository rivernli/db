USE [TrainingWeb]
GO
/****** Object:  Table [dbo].[LinkTable]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LinkTable](
	[id] [int] NOT NULL,
	[title] [nvarchar](50) NULL,
	[pic] [nvarchar](50) NULL,
	[url] [nvarchar](50) NULL,
	[show] [bit] NOT NULL,
	[click] [int] NULL
) ON [PRIMARY]

GO
