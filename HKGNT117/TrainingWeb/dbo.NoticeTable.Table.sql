USE [TrainingWeb]
GO
/****** Object:  Table [dbo].[NoticeTable]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NoticeTable](
	[id] [int] NOT NULL,
	[name] [ntext] NULL,
	[show] [bit] NOT NULL,
	[click] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
