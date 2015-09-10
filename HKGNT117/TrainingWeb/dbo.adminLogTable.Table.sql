USE [TrainingWeb]
GO
/****** Object:  Table [dbo].[adminLogTable]    Script Date: 2014/11/12 17:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[adminLogTable](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[aid] [int] NULL,
	[name] [nvarchar](50) NULL,
	[logintime] [datetime] NULL,
	[loginip] [nvarchar](50) NULL,
	[flag] [int] NULL,
	[outtime] [datetime] NULL
) ON [PRIMARY]

GO
