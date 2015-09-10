USE [TrainingWeb]
GO
/****** Object:  Table [dbo].[UserFormTable]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserFormTable](
	[id] [int] NOT NULL,
	[bid] [int] NULL,
	[username] [nvarchar](50) NULL,
	[password] [nvarchar](50) NULL,
	[addtime] [nvarchar](50) NULL,
	[logintimes] [int] NULL,
	[flag] [nvarchar](50) NULL,
	[shenghe] [bit] NOT NULL
) ON [PRIMARY]

GO
