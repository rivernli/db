USE [TrainingWeb]
GO
/****** Object:  Table [dbo].[admin]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[admin](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[r_id] [int] NULL,
	[admin] [nvarchar](50) NULL,
	[pwd] [nvarchar](50) NULL,
	[flag] [int] NULL,
	[logintimes] [int] NULL,
	[explain] [nvarchar](50) NULL,
	[aaa] [nchar](10) NULL
) ON [PRIMARY]

GO
