USE [TrainingWeb]
GO
/****** Object:  Table [dbo].[VideoTable]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VideoTable](
	[id] [int] NOT NULL,
	[pic] [nvarchar](50) NULL,
	[title] [nvarchar](50) NULL,
	[url] [nvarchar](50) NULL,
	[addtime] [datetime] NULL,
	[explain] [ntext] NULL,
	[comeform] [nvarchar](50) NULL,
	[sourcesize] [nvarchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
