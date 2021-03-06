USE [BOC]
GO
/****** Object:  Table [dbo].[tfsboc110180]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tfsboc110180](
	[T$year] [int] NOT NULL,
	[T$prno] [int] NOT NULL,
	[T$plnt] [nvarchar](10) NOT NULL,
	[T$stat] [nvarchar](10) NULL,
	[Column5] [nvarchar](50) NULL,
	[Column6] [nvarchar](50) NULL,
 CONSTRAINT [PK_tfsboc110180] PRIMARY KEY CLUSTERED 
(
	[T$year] ASC,
	[T$prno] ASC,
	[T$plnt] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
