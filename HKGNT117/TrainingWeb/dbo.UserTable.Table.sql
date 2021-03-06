USE [TrainingWeb]
GO
/****** Object:  Table [dbo].[UserTable]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserTable](
	[id] [int] NOT NULL,
	[rid] [int] NULL,
	[username] [nvarchar](50) NULL,
	[reallyname] [nvarchar](50) NULL,
	[password] [nvarchar](50) NULL,
	[regtime] [datetime] NULL,
	[state] [int] NULL,
	[logintimes] [int] NULL,
	[obligate] [nvarchar](50) NULL
) ON [PRIMARY]

GO
