USE [TrainingWeb]
GO
/****** Object:  Table [dbo].[SystemSet]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SystemSet](
	[Title] [ntext] NULL,
	[Description] [ntext] NULL,
	[Keywords] [ntext] NULL,
	[VideoSize] [int] NULL,
	[SourceSize] [int] NULL,
	[PicSize] [int] NULL,
	[NewsSet] [bit] NOT NULL,
	[ShoppingSet] [bit] NOT NULL,
	[LuyanSet] [bit] NOT NULL,
	[copyright] [ntext] NULL,
	[myurl] [nvarchar](50) NULL,
	[introduction] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
