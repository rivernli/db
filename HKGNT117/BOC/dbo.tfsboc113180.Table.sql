USE [BOC]
GO
/****** Object:  Table [dbo].[tfsboc113180]    Script Date: 2014/11/12 17:02:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tfsboc113180](
	[T$pjno] [nvarchar](50) NOT NULL,
	[Column1] [nvarchar](50) NULL,
	[Column2] [nvarchar](50) NULL,
 CONSTRAINT [PK_tfsboc113180] PRIMARY KEY CLUSTERED 
(
	[T$pjno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
