USE [TrainingWeb]
GO
/****** Object:  Table [dbo].[NewsTable]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NewsTable](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ClassId] [int] NULL,
	[img] [nvarchar](255) NULL,
	[title] [nvarchar](255) NULL,
	[content] [ntext] NULL,
	[pub_date] [datetime] NULL,
	[click] [int] NULL,
	[purview] [bit] NOT NULL,
	[user] [nvarchar](50) NULL,
	[from] [nvarchar](50) NULL,
	[flag] [bit] NOT NULL,
	[bid] [int] NULL,
	[htmlurl] [nvarchar](50) NULL,
	[htmls] [bit] NOT NULL,
 CONSTRAINT [PK_NewsTable] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
