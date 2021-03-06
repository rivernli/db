USE [BOC]
GO
/****** Object:  Table [dbo].[tfsboc112180]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tfsboc112180](
	[T$matp] [nvarchar](50) NOT NULL,
	[T$seri] [int] NOT NULL,
	[T$type] [nvarchar](50) NULL,
	[Column4] [nvarchar](50) NULL,
	[Column5] [nvarchar](50) NULL,
 CONSTRAINT [PK_tfsboc112180] PRIMARY KEY CLUSTERED 
(
	[T$matp] ASC,
	[T$seri] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
