USE [TrainingWeb]
GO
/****** Object:  Table [dbo].[ProduceTable]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProduceTable](
	[pid] [int] NOT NULL,
	[classid] [int] NULL,
	[pname] [nvarchar](50) NULL,
	[price] [nvarchar](50) NULL,
	[pic] [nvarchar](50) NULL,
	[addtime] [datetime] NULL,
	[purview] [bit] NOT NULL,
	[explain] [ntext] NULL,
	[address] [nvarchar](50) NULL,
	[pubdate] [nvarchar](50) NULL,
	[click] [int] NULL,
	[nums] [int] NULL,
	[tuijian] [bit] NOT NULL,
	[bid] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
